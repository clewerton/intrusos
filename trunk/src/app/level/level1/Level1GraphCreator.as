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
			
			_grafo.addNode(new Node(230, 250));	//	2
			
			_grafo.addNode(new Node(70, 150));	//	3
			_grafo.addNode(new Node(150, 150));	//	4
			_grafo.addNode(new Node(250, 150));	//	5
			_grafo.addNode(new Node(50, 50));		//	6
			_grafo.addNode(new Node(250, 70));	//	7
			
			_grafo.addNode(new Node(250, 230));	//	8
			_grafo.addNode(new Node(50, 130));	//	9
			_grafo.addNode(new Node(50, 170));	//	10
			_grafo.addNode(new Node(230, 50));	//	11
			
		}
		
		private function creatGraph():void {
			createNodes();
			
			_grafo.connect(0, 1, new StandardLinearEdge()).name = "0-1";
			_grafo.connect(0, 10, new StandardLinearEdge()).name = "0-10";
			_grafo.connect(10, 3, new StandardQuadrantEdge()).name = "10-3";
			_grafo.connect(9, 3, new StandardQuadrantEdge(false)).name = "9-3";
			
			_grafo.connect(1, 2, new StandardLinearEdge()).name = "1-2";
			_grafo.connect(8, 5, new StandardLinearEdge()).name = "8-5";
			
			_grafo.connect(1, 4, new StandardLinearEdge()).name = "1-4";
			_grafo.connect(8, 5, new StandardLinearEdge()).name = "8-5";
			_grafo.connect(3, 4, new StandardLinearEdge()).name = "3-4";
			_grafo.connect(6, 9, new StandardLinearEdge()).name = "6-9";
			_grafo.connect(4, 5, new StandardLinearEdge()).name = "4-5";
			_grafo.connect(5, 7, new StandardLinearEdge()).name = "5-7";
			_grafo.connect(11, 6, new StandardLinearEdge()).name = "11-6";
			_grafo.connect(7, 11, new StandardQuadrantEdge(false)).name = "7-11";
			_grafo.connect(2, 8, new StandardQuadrantEdge(false)).name = "2-8";
			
		}
		
	}

}