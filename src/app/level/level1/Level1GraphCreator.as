package src.app.level.level1
{
	import lib.graph.DirectedGraph;
	import lib.graph.event.EdgeEvent;
	import lib.graph.Node;
	import lib.graph.Edge;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import src.entidade.StandardLinearEdge;
	import src.entidade.StandardQuadrantEdge;
	
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
			_grafo.addNode(new Node(50, 250));	//	0
			_grafo.addNode(new Node(150, 250));	//	1
			_grafo.addNode(new Node(250, 250));	//	2
			_grafo.addNode(new Node(50, 150));	//	3
			_grafo.addNode(new Node(150, 150));	//	4
			_grafo.addNode(new Node(250, 150));	//	5
			_grafo.addNode(new Node(50, 50));	//	6
			_grafo.addNode(new Node(250, 50));	//	7
		}
		
		private function creatGraph():void {
			createNodes();
			
			_grafo.connect(0, 1, new StandardLinearEdge()).name = "01";
			_grafo.connect(0, 3, new StandardLinearEdge()).name = "03";
			//_grafo.connect(1, 2, new StandardLinearEdge()).name = "12";
			_grafo.connect(1, 4, new StandardLinearEdge()).name = "14";
			//_grafo.connect(2, 5, new StandardLinearEdge()).name = "25";
			_grafo.connect(3, 4, new StandardLinearEdge()).name = "34";
			_grafo.connect(6, 3, new StandardLinearEdge()).name = "63";
			_grafo.connect(4, 5, new StandardLinearEdge()).name = "45";
			_grafo.connect(5, 7, new StandardLinearEdge()).name = "57";
			_grafo.connect(7, 6, new StandardLinearEdge()).name = "76";
			_grafo.connect(1, 5, new StandardQuadrantEdge(false)).name = "15";
			
		}
		
	}

}