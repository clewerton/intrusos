package src.app.level.level1
{
	import lib.graph.DirectedGraph;
	import lib.graph.event.NodeEvent;
	import lib.graph.Node;
	import src.entidade.StandardLinearEdge;
	import src.entidade.StandardQuadrantEdge;
	import src.evento.EventChannel;
	
	/**
	 * ...
	 * @author Clewerton Coelho
	 */
	public class Level1GraphCreator
	{
		private var _grafo:DirectedGraph;
		
		public function Level1GraphCreator() {
			_grafo = new DirectedGraph();
			_grafo.addEventListener(EventChannel.NODE_ADDED, paintNode, false, 0, true);
			creatGraph();
		}
		
		public function getGraph():DirectedGraph {
			return _grafo;
		}

		private function createNodes():void {
			_grafo.addNode(new Node(100, 100));		//	0
			_grafo.addNode(new Node(400, 100));		//	1
			_grafo.addNode(new Node(500, 100));		//	2
			_grafo.addNode(new Node(700, 100));		//	3
			
			_grafo.addNode(new Node(300, 300));		//	4
			_grafo.addNode(new Node(400, 300));		//	4
			_grafo.addNode(new Node(500, 300));		//	5
			_grafo.addNode(new Node(700, 300));		//	7
			
			_grafo.addNode(new Node(100, 400));		//	8
			_grafo.addNode(new Node(300, 400));		//	9
			_grafo.addNode(new Node(500, 400));		//	10
			_grafo.addNode(new Node(700, 400));		//	11

			_grafo.addNode(new Node(300, 500));		//	12
			_grafo.addNode(new Node(400, 500));		//	13
			_grafo.addNode(new Node(500, 500));		//	14
			
			_grafo.addNode(new Node(550, 550));		//	15
			_grafo.addNode(new Node(700, 550));		//	16
									 
			_grafo.addNode(new Node(100, 700));		//	17
			_grafo.addNode(new Node(300, 700));		//	18
			_grafo.addNode(new Node(400, 700));		//	19
			_grafo.addNode(new Node(550, 700));		//	20
			_grafo.addNode(new Node(700, 700));		//	21

		}
		
		private function creatGraph():void {
			createNodes();
			
			_grafo.connect(0, 1, new StandardLinearEdge()).name = "0-1";
			_grafo.connect(1, 5, new StandardLinearEdge()).name = "1-5";
			_grafo.connect(5, 4, new StandardLinearEdge()).name = "5-4";
			_grafo.connect(4, 9, new StandardLinearEdge()).name = "4-9";
			_grafo.connect(9, 8, new StandardLinearEdge()).name = "9-8";
			_grafo.connect(8, 0, new StandardLinearEdge()).name = "8-0";
			
			_grafo.connect(2, 1, new StandardLinearEdge()).name = "2-1";
			_grafo.connect(6, 2, new StandardLinearEdge()).name = "6-2";
			_grafo.connect(5, 6, new StandardLinearEdge()).name = "5-6";

			_grafo.connect(2, 3, new StandardLinearEdge()).name = "2-3";
			_grafo.connect(3, 7, new StandardLinearEdge()).name = "3-7";
			_grafo.connect(7, 6, new StandardLinearEdge()).name = "7-6";

			_grafo.connect(7, 11, new StandardLinearEdge()).name = "7-11";
			_grafo.connect(11, 10, new StandardLinearEdge()).name = "11-10";
			_grafo.connect(10, 6, new StandardLinearEdge()).name = "10-6";
			
			_grafo.connect(16, 11, new StandardLinearEdge()).name = "16-11";
			_grafo.connect(10, 14, new StandardLinearEdge()).name = "10-14";
			_grafo.connect(14, 13, new StandardLinearEdge()).name = "14-13";
			_grafo.connect(13, 19, new StandardLinearEdge()).name = "13-19";
			_grafo.connect(19, 20, new StandardLinearEdge()).name = "19-20";
			_grafo.connect(20, 15, new StandardLinearEdge()).name = "20-15";
			_grafo.connect(15, 16, new StandardLinearEdge()).name = "15-16";
			
			_grafo.connect(16, 21, new StandardLinearEdge()).name = "16-21";
			_grafo.connect(21, 20, new StandardLinearEdge()).name = "21-20";

			_grafo.connect(19, 18, new StandardLinearEdge()).name = "19-18";
			_grafo.connect(18, 12, new StandardLinearEdge()).name = "18-12";
			_grafo.connect(12, 13, new StandardLinearEdge()).name = "21-20";

			_grafo.connect(12, 9, new StandardLinearEdge()).name = "12-9";
			_grafo.connect(9, 8, new StandardLinearEdge()).name = "9-8";
			_grafo.connect(8, 17, new StandardLinearEdge()).name = "8-17";
			_grafo.connect(17, 18, new StandardLinearEdge()).name = "17-18";

			_grafo.connect(8, 0, new StandardLinearEdge()).name = "8-0";

			//_grafo.connect(2, 8, new StandardQuadrantEdge(false)).name = "2-8";
			
		}
		
		private function paintNode(ev:NodeEvent):void {
			ev.node.graphics.beginFill(Node.NODE_COLOR, 1);
			ev.node.graphics.drawCircle(0, 0, Node.NODE_RADIUS);
			ev.node.graphics.endFill();
			ev.node.visible = false;
		}
		
	}

}