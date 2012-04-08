package src.app.level.level1
{
	import lib.graph.DirectedGraph;
	import lib.graph.event.EdgeEvent;
	import lib.graph.Node;
	import src.entidade.StandardEdge;
	import lib.graph.Edge;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author Clewerton Coelho
	 */
	public class Level1GraphCreator
	{
		private var _grafo:DirectedGraph;
		
		public function Level1GraphCreator() {
			_grafo = new DirectedGraph();
			creatGraph();
		}
		
		public function getGraph():DirectedGraph {
			return _grafo;
		}

		private function createNodes():void {
			_grafo.addNode(new Node(50, 250));
			_grafo.addNode(new Node(150, 250));
			_grafo.addNode(new Node(250, 250));
			_grafo.addNode(new Node(50, 150));
			_grafo.addNode(new Node(150, 150));
			_grafo.addNode(new Node(250, 150));
			_grafo.addNode(new Node(50, 50));
			_grafo.addNode(new Node(250, 50));
		}
		
		private function creatGraph():void {
			createNodes();
			
			_grafo.connect(0, 1, new StandardEdge()).name = "01";
			_grafo.connect(0, 3, new StandardEdge()).name = "03";
			_grafo.connect(1, 2, new StandardEdge()).name = "12";
			_grafo.connect(1, 4, new StandardEdge()).name = "14";
			_grafo.connect(2, 5, new StandardEdge()).name = "25";
			_grafo.connect(3, 4, new StandardEdge()).name = "34";
			_grafo.connect(6, 3, new StandardEdge()).name = "63";
			_grafo.connect(4, 5, new StandardEdge()).name = "45";
			_grafo.connect(5, 7, new StandardEdge()).name = "57";
			_grafo.connect(7, 6, new StandardEdge()).name = "76";
			
		}
		
	}

}