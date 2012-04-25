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
	 * Contém as informações do grafo da fase 1.
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
									 
			_grafo.addNode(new Node(17, 100, 650));
			_grafo.addNode(new Node(24, 150, 700));
			
			_grafo.addNode(new Node(18, 300, 700));
			_grafo.addNode(new Node(19, 400, 700));
			_grafo.addNode(new Node(20, 550, 700));
			_grafo.addNode(new Node(21, 700, 700));

			_grafo.addNode(new Node(22, 100, 150));
			_grafo.addNode(new Node(23, 700, 150));
			
		}
		
		private function creatGraph():void {
			createNodes();
			
			_grafo.connect(0, 1, new StandardLinearEdge());
			_grafo.connect(1, 5, new StandardLinearEdge());
			_grafo.connect(5, 4, new StandardLinearEdge());
			_grafo.connect(4, 9, new StandardLinearEdge());
			_grafo.connect(9, 8, new StandardLinearEdge());
			
			_grafo.connect(2, 1, new StandardLinearEdge());
			_grafo.connect(6, 2, new StandardLinearEdge());
			_grafo.connect(5, 6, new StandardLinearEdge());

			_grafo.connect(2, 3, new StandardLinearEdge());
			_grafo.connect(3, 23, new StandardQuadrantEdge());
			_grafo.connect(23, 7, new StandardLinearEdge());
			_grafo.connect(7, 6, new StandardLinearEdge());

			_grafo.connect(7, 11, new StandardLinearEdge());
			_grafo.connect(11, 10, new StandardLinearEdge());
			_grafo.connect(10, 6, new StandardLinearEdge());
			
			_grafo.connect(16, 11, new StandardLinearEdge());
			_grafo.connect(10, 14, new StandardLinearEdge());
			_grafo.connect(14, 13, new StandardLinearEdge());
			_grafo.connect(13, 19, new StandardLinearEdge());
			_grafo.connect(19, 20, new StandardLinearEdge());
			_grafo.connect(20, 15, new StandardLinearEdge());
			_grafo.connect(15, 16, new StandardLinearEdge());
			
			_grafo.connect(16, 21, new StandardLinearEdge());
			_grafo.connect(21, 20, new StandardLinearEdge());

			_grafo.connect(19, 18, new StandardLinearEdge());
			_grafo.connect(18, 12, new StandardLinearEdge());
			_grafo.connect(12, 13, new StandardLinearEdge());

			_grafo.connect(12, 9, new StandardLinearEdge());
			_grafo.connect(9, 8, new StandardLinearEdge());
			_grafo.connect(8, 17, new StandardLinearEdge());
			_grafo.connect(17, 24, new StandardQuadrantEdge(false));
			_grafo.connect(24, 18, new StandardLinearEdge());

			_grafo.connect(8, 22, new StandardLinearEdge());

			_grafo.connect(22, 0, new StandardQuadrantEdge());		
		}
		
		private function paintNode(ev:NodeEvent):void {
			ev.node.graphics.beginFill(Node.NODE_COLOR, 1);
			ev.node.graphics.drawCircle(0, 0, Node.NODE_RADIUS);
			ev.node.graphics.endFill();
			ev.node.visible = false;
		}
		
	}

}