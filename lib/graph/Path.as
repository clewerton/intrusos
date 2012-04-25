package lib.graph {
	import lib.graph.event.PathEvent;
	import src.evento.EventChannel;
	
	/**
	 * ...
	 * @author Clewerton Coelho
	 * Representa um caminho. Além disso gerencia a configuração do mesmo.
	 */
	
	public class Path extends Edge {

		private var _edges:Vector.<Edge>;
		private var _continuousPath:Boolean;
		private var _canModify:Boolean;
		private var _firstNode:Node;
		private var _lastNode:Node;
		private var _currentEdgeIndex:int;
		
		public function Path(sourceNode:Node, canModify:Boolean = true, continuousPath:Boolean = false) {
			_edges = new Vector.<Edge>();
			_continuousPath = continuousPath;
			_firstNode = sourceNode;
			_canModify = canModify;
		}

		public function addEdge(edge:Edge):Path {
			if(_edges.length == 0) {
				if(edge.sourceNode == _firstNode) {
					join(edge);
				}
				return this;
			}
			var index:int = getOutEdgeFrom(edge.sourceNode);
			if(index >= 0) {
				if(_canModify && !_edges[index].marked) {
					separateFromIndex(index);
					join(edge);
				}
			}
			else if(
				(!_continuousPath) || 
				(_continuousPath && (_edges[edges.length - 1].targetNode == edge.sourceNode))) {
					join(edge);
			}
			return this;
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

		public function inPath(edge:Edge):Boolean {
			return _edges.indexOf(edge) >= 0;
		}
		
		private function join(edge: Edge):Path {
			// ignorar se a aresta ja estiver no caminho
			if(inPath(edge)) {
				return this;
			}
			if(_edges.length < 1) {
				sourceNode = edge.sourceNode;
			}
			else {
				targetNode = edge.targetNode;
			}
			_edges.push(edge);
			dispatchEvent(new PathEvent(EventChannel.EDGE_ADDED, edge));

			return this;
		}

		private function separateFromIndex(index:int):void {
			var edge:Edge = _edges[index];
			separate(edge);
			//_edges.splice(index, _edges.length - index);
		}

		public function get edges():Vector.<Edge> {
			return _edges;
		}
		
		public function get firstNode():Node 
		{
			return _firstNode;
		}
		
		public function get lastNode():Node 
		{
			return _lastNode;
		}
		
		function get currentEdgeIndex():int 
		{
			return _currentEdgeIndex;
		}
		
		function set currentEdgeIndex(value:int):void 
		{
			_currentEdgeIndex = value;
		}
		
		private function adjustNodes():void {
			if(_edges.length > 0) {
				targetNode = _edges[_edges.length - 1].targetNode;
			}
			else {
				sourceNode = null;
				targetNode = null;
			}
		}
		
		public function unMarkEdges(index:int):void {
			for (var idx:int = index; idx < _edges.length; idx++ ) {
				_edges[idx].marked = false;
			}
		}

	}
	
}
