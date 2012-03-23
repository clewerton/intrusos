package grafo {
	
	import flash.display.Stage;
	import evento.*
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class Path extends Edge {

		private var _edges:Vector.<Edge>;
		private var _continuousPath:Boolean;
		private var _canModify:Boolean;
		private var _firstNode:Node;
		
		public function Path(firstNode:Node, canModify:Boolean = true, continuousPath:Boolean = false) {
			_edges = new Vector.<Edge>();
			_continuousPath = continuousPath;
			_firstNode = firstNode;
			_canModify = canModify;
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
			
			// Notificar listeners
			var ev:PathEvent = new PathEvent(EventChannel.EDGE_ADDED);
			ev.edge = edge;
			dispatchEvent(ev);

			return this;
		}

		public function separate(edge: Edge):Path {
			if(inPath(edge)) {
				var curEdge:Edge = null;
				do {
					curEdge = _edges.pop();
					
					// Notificar listeners
					var ev:PathEvent = new PathEvent(EventChannel.EDGE_REMOVED);
					ev.edge = curEdge;
					dispatchEvent(ev);
					
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
		
	}
	
}
