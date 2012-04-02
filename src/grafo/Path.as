package grafo {
	
	import flash.display.Stage;
	import evento.*
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class Path extends Edge {

		private var _graph:DirectedGraph;
		private var _edges:Vector.<Edge>;
		private var _continuousPath:Boolean;
		private var _canModify:Boolean;
		private var _firstNode:Node;
		private var _pathWalkers:Vector.<PathWalker> = new Vector.<PathWalker>();
		
		public function Path(graph:DirectedGraph, firstNode:Node, canModify:Boolean = true, continuousPath:Boolean = false) {
			_graph = graph;
			_edges = new Vector.<Edge>();
			_continuousPath = continuousPath;
			_firstNode = firstNode;
			_canModify = canModify;
			_graph.forEachEdge(handleClick);
		}

		public override function dispose():void {
			super.dispose();
			_graph = null;
			_edges = null;
			_firstNode = null;
			_pathWalkers = null;
		}

		private function handleClick(item:Edge, index:int, vector:Vector.<Edge>):void {
			item.addEventListener(MouseEvent.CLICK, configurePath, false, 0, true);
		}

		private function configurePath(e:Event):void {
			var theEdge:Edge = e.target as Edge;
			if (!inPath(theEdge)) {
				addEdge(theEdge);
			}
			else {
				if (isRemovable(theEdge)) {
					separate(theEdge);
				}
			}
		}
		
		private function isRemovable(edge:Edge):Boolean {
			var resultado:Boolean = true;
			var walkersIndex:uint = 0;
			
			while (resultado && (walkersIndex < _pathWalkers.length)) {
				if (!_pathWalkers[walkersIndex++].edgeAhead(edge)) {
					resultado = false;
				}
			}
			return resultado;
		}
		
		public function addEdge(edge:Edge):Path {
			if(_edges.length == 0) {
				if(edge.sourceNode == _firstNode) {
					join(edge);
				}
				else {
					throw new Error("Primeira aresta deve sair do nó inicial.");
				}
				return this;
			}
			var index:int = getOutEdgeFrom(edge.sourceNode);
			if(index >= 0) {
				if(_canModify) {
					separateFromIndex(index);
					join(edge);
				}
			}
			else if(
				(!_continuousPath) || 
				(_continuousPath && (_edges[edges.length - 1].targetNode == edge.sourceNode))) {
					join(edge);
			}
			else {
				throw new Error("Permitido somente caminho contínuo.");
			}
			return this;
		}
		
		private function join(edge: Edge):Path {
			// ignorar se a aresta ja estiver no caminho
			if(inPath(edge)) {
				return this;
			}
			if(_edges.length < 1) {
				_source = edge.sourceNode;
			}
			else {
				_target = edge.targetNode;
			}
			_edges.push(edge);
			dispatchEvent(new PathEvent(EventChannel.EDGE_ADDED, edge));

			return this;
		}

		public function separate(edge: Edge):Path {
			if(inPath(edge)) {
				var curEdge:Edge = null;
				do {
					curEdge = _edges.pop();
					dispatchEvent(new PathEvent(EventChannel.EDGE_REMOVED, curEdge));
					
				} while(curEdge != edge);
				adjustNodes();
			}
			return this;
		}

		public function separateFromIndex(index:int):void {
			var edge:Edge = _edges[index];
			separate(edge);
			//_edges.splice(index, _edges.length - index);
		}

		public function get edges():Vector.<Edge> {
			return _edges;
		}
		
		public function getOutEdgeFrom(node:Node):int {
			var retorno:int = -1;
			for (var index:int = 0; index < _edges.length; index++ ) {
				if(_edges[index].sourceNode == node) {
					retorno = index;
					break;
				}
			}
			return retorno;
		}
		
		private function adjustNodes():void {
			if(_edges.length > 0) {
				_target = _edges[_edges.length - 1].targetNode;
			}
			else {
				_source = null;
				_target = null;
			}
		}

		public function inPath(edge:Edge):Boolean {
			return _edges.indexOf(edge) >= 0;
		}
		
		public function addPathWalker(pathWalker:PathWalker):void {
			_pathWalkers.push(pathWalker);
		}

		public function removePathWalker(pathWalker:PathWalker):void {
			_pathWalkers.splice(_pathWalkers.indexOf(pathWalker), 1);
		}
		
		public override function update():void {
			for each(var pathWalker:PathWalker in _pathWalkers) {
				pathWalker.update();
			}
		}

		public function startWalking():void {
			for each(var pathWalker:PathWalker in _pathWalkers) {
				pathWalker.startWalking();
			}
		}

		public function resetWalking():void {
			for each(var pathWalker:PathWalker in _pathWalkers) {
				pathWalker.resetWalking();
			}
		}
		
		public function stopWalking():void {
			for each(var pathWalker:PathWalker in _pathWalkers) {
				pathWalker.stopWalking();
			}
		}
		
	}
	
}
