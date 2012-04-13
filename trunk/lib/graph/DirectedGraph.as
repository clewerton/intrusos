package lib.graph {
	import lib.engine.GameObject;
	import src.evento.EventChannel;
	import lib.graph.event.NodeEvent;
	
	public class DirectedGraph extends GameObject {

		private var _nodes: Vector.<Node>;
		private var _edges:Vector.<Edge>;

		public function DirectedGraph() {
			_nodes = new Vector.<Node>;
			_edges = new Vector.<Edge>;
		}

		public function getNodeAt(index:uint):Node {
			return _nodes[index];
		}

		public function getEdgeAt(index:uint):Edge {
			return _edges[index];
		}

		public function addNode(node:Node):void {
			_nodes.push(node);
			addChild(node);
			dispatchEvent(new NodeEvent(EventChannel.NODE_ADDED, node));
		}

		public function addNodes(nodes:Vector.<Node>):void {
			for each(var node:Node in nodes) {
				addNode(node);
			}
		}

		public function connect(firstNodeIndex:uint, secondNodeIndex:uint, edge:Edge):Edge {
			if(!_nodes.length == 0) {
				edge.connect(_nodes[firstNodeIndex], _nodes[secondNodeIndex]);
				_edges.push(edge);
				addChild(edge);
				return edge;
			}
			else {
				throw new Error("Os indices não possuem refer}ancias válidas.");
			}
		}

		public function disconnect(edge:Edge):void {
			removeChild(edge);
			edge.disconnect();
			delete _edges[edge];
			edge = null;
		}

		public function traversseByFirstEdge():void {
			var currentNode:Node = _nodes[0];
			var currentEdge:Edge = currentNode.getOutEdgeByIndex(0);
			var previousEdge:Edge = currentEdge;
			while(currentNode != null && currentEdge != null && !currentEdge.marked) {
				//trace("Node " + currentNode.name + " Edge " + currentEdge.name);
				previousEdge = currentEdge;
				currentNode = currentEdge.targetNode;
				currentEdge = currentNode.getOutEdgeByIndex(0);
				previousEdge.marked = true;  // set marked = false to get infinite loop
			}
		}
		
		public function forEachEdge(func:Function):void {
			_edges.forEach(func);
		}

	}
	
}
