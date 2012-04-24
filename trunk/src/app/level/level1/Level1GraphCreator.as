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
	 * Criador do grafo da fase 1
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
			_grafo.addNode(new Node(0, 150, 100));
			_grafo.addNode(new Node(1, 400, 100));
			_grafo.addNode(new Node(2, 500, 100));
			_grafo.addNode(new Node(3, 650, 100));
			
			_grafo.addNode(new Node(4, 300, 300));
			_grafo.addNode(new Node(5, 400, 300));
			_grafo.addNode(new Node(6, 500, 300));
			_grafo.addNode(new Node(7, 700, 300));
			
			_grafo.addNode(new Node(8, 100, 400));
			_grafo.addNode(new Node(9, 300, 400));
			_grafo.addNode(new Node(10, 500, 400));
			_grafo.addNode(new Node(11, 700, 400));

			_grafo.addNode(new Node(12, 300, 500));
			_grafo.addNode(new Node(13, 400, 500));
			_grafo.addNode(new Node(14, 500, 500));
			
			_grafo.addNode(new Node(15, 550, 550));
			_grafo.addNode(new Node(16, 700, 550));
									 
			_grafo.addNode(new Node(17, 100, 700));
			_grafo.addNode(new Node(18, 300, 700));
			_grafo.addNode(new Node(19, 400, 700));
			_grafo.addNode(new Node(20, 550, 700));
			_grafo.addNode(new Node(21, 700, 700));

			_grafo.addNode(new Node(22, 100, 150));
			_grafo.addNode(new Node(23, 700, 150));
			
		}
		
		private function creatGraph():void {
			createNodes();
			
			_grafo.connect(0, 1, new StandardLinearEdge()).name = "0-1";
			_grafo.connect(1, 5, new StandardLinearEdge()).name = "1-5";
			_grafo.connect(5, 4, new StandardLinearEdge()).name = "5-4";
			_grafo.connect(4, 9, new StandardLinearEdge()).name = "4-9";
			_grafo.connect(9, 8, new StandardLinearEdge()).name = "9-8";
			
			_grafo.connect(2, 1, new StandardLinearEdge()).name = "2-1";
			_grafo.connect(6, 2, new StandardLinearEdge()).name = "6-2";
			_grafo.connect(5, 6, new StandardLinearEdge()).name = "5-6";

			_grafo.connect(2, 3, new StandardLinearEdge()).name = "2-3";
			_grafo.connect(3, 23, new StandardQuadrantEdge()).name = "3-23";
			_grafo.connect(23, 7, new StandardLinearEdge()).name = "23-7";
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

			_grafo.connect(8, 22, new StandardLinearEdge()).name = "8-22";

			_grafo.connect(22, 0, new StandardQuadrantEdge()).name = "22-0";
			
		}
		
		private function paintNode(ev:NodeEvent):void {
			ev.node.graphics.beginFill(Node.NODE_COLOR, 1);
			ev.node.graphics.drawCircle(0, 0, Node.NODE_RADIUS);
			ev.node.graphics.endFill();
			ev.node.visible = false;
		}
		
	}

}