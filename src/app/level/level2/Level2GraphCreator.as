package src.app.level.level2
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
	 * Contém as informações do grafo da fase 2.
	 */
	public class Level2GraphCreator
	{
		private var _grafo:DirectedGraph;
		
		public function Level2GraphCreator() {
			_grafo = new DirectedGraph();
			_grafo.addEventListener(EventChannel.NODE_ADDED, paintNode, false, 0, true);
			creatGraph();
		}
		
		public function getGraph():DirectedGraph {
			return _grafo;
		}

		private function createNodes():void {
			_grafo.addNode(new Node(51, 350, 456));
			_grafo.addNode(new Node(52, 350, 680));
			_grafo.addNode(new Node(53, 460, 570));
			_grafo.addNode(new Node(54, 240, 570));
			_grafo.addNode(new Node(55, 350, 320));
			_grafo.addNode(new Node(56, 350, 830));
			_grafo.addNode(new Node(57, 610, 570));
			_grafo.addNode(new Node(58, 90, 570));
			_grafo.addNode(new Node(71, 865, 460));
			_grafo.addNode(new Node(72, 865, 680));
			_grafo.addNode(new Node(73, 970, 570));
			_grafo.addNode(new Node(74, 755, 570));
			_grafo.addNode(new Node(75, 865, 315));
			_grafo.addNode(new Node(76, 865, 830));
			_grafo.addNode(new Node(77, 1120, 570));
			_grafo.addNode(new Node(107, 610, 720));
			_grafo.addNode(new Node(109, 715, 830));
			_grafo.addNode(new Node(111, 610, 940));
			_grafo.addNode(new Node(113, 500, 830));
			_grafo.addNode(new Node(120, 610, 210));
			_grafo.addNode(new Node(122, 715, 315));
			_grafo.addNode(new Node(124, 610, 425));
			_grafo.addNode(new Node(126, 500, 320));
			_grafo.addNode(new Node(140, 610, 1080));
			_grafo.addNode(new Node(149, 610, 65));
			_grafo.addNode(new Node(171, 660, 180));
			_grafo.addNode(new Node(173, 540, 435));
			_grafo.addNode(new Node(175, 725, 500));
			_grafo.addNode(new Node(177, 990, 620));
			_grafo.addNode(new Node(179, 660, 690));
			_grafo.addNode(new Node(181, 540, 955));
			_grafo.addNode(new Node(184, 470, 620));
			_grafo.addNode(new Node(186, 200, 510));
			_grafo.addNode(new Node(187, 605, 310));
			_grafo.addNode(new Node(188, 865, 565));
			_grafo.addNode(new Node(189, 350, 565));
			_grafo.addNode(new Node(190, 605, 825));
			_grafo.addNode(new Node(192, 930, 435));
			_grafo.addNode(new Node(193, 800, 700));
			_grafo.addNode(new Node(194, 735, 880));
			_grafo.addNode(new Node(195, 470, 770));
			_grafo.addNode(new Node(196, 400, 420));
			_grafo.addNode(new Node(197, 300, 715));
			_grafo.addNode(new Node(198, 740, 370));
			_grafo.addNode(new Node(199, 470, 260));
			
		}
		
		private function creatGraph():void {
			createNodes();
			
			_grafo.connect(54, 51, new StandardQuadrantEdge());
			_grafo.connect(51, 53, new StandardQuadrantEdge());
			_grafo.connect(53, 52, new StandardQuadrantEdge());
			_grafo.connect(52, 54, new StandardQuadrantEdge());
			_grafo.connect(51, 55, new StandardLinearEdge());
			_grafo.connect(54, 58, new StandardLinearEdge());
			_grafo.connect(57, 55, new StandardLinearEdge());
			_grafo.connect(55, 58, new StandardLinearEdge());
			_grafo.connect(58, 56, new StandardLinearEdge());
			_grafo.connect(56, 57, new StandardLinearEdge());
			_grafo.connect(75, 71, new StandardLinearEdge());
			_grafo.connect(57, 74, new StandardLinearEdge());
			_grafo.connect(124, 57, new StandardLinearEdge());
			_grafo.connect(56, 52, new StandardLinearEdge());
			_grafo.connect(57, 53, new StandardLinearEdge());
			_grafo.connect(73, 77, new StandardLinearEdge());
			_grafo.connect(72, 76, new StandardLinearEdge());
			_grafo.connect(107, 57, new StandardLinearEdge());
			_grafo.connect(122, 120, new StandardQuadrantEdge(false));
			_grafo.connect(120, 126, new StandardQuadrantEdge(false));
			_grafo.connect(126, 124, new StandardQuadrantEdge(false));
			_grafo.connect(124, 122, new StandardQuadrantEdge(false));
			_grafo.connect(57, 76, new StandardLinearEdge());
			_grafo.connect(75, 57, new StandardLinearEdge());
			_grafo.connect(76, 140, new StandardLinearEdge());
			_grafo.connect(140, 56, new StandardLinearEdge());
			_grafo.connect(76, 77, new StandardLinearEdge());
			_grafo.connect(77, 75, new StandardLinearEdge());
			_grafo.connect(55, 149, new StandardLinearEdge());
			_grafo.connect(149, 75, new StandardLinearEdge());
			_grafo.connect(71, 73, new StandardQuadrantEdge());
			_grafo.connect(73, 72, new StandardQuadrantEdge());
			_grafo.connect(72, 74, new StandardQuadrantEdge());
			_grafo.connect(74, 71, new StandardQuadrantEdge());
			_grafo.connect(109, 107, new StandardQuadrantEdge(false));
			_grafo.connect(111, 109, new StandardQuadrantEdge(false));
			_grafo.connect(107, 113, new StandardQuadrantEdge(false));
			_grafo.connect(113, 111, new StandardQuadrantEdge(false));
			_grafo.connect(76, 109, new StandardLinearEdge());
			_grafo.connect(113, 56, new StandardLinearEdge());
			_grafo.connect(55, 126, new StandardLinearEdge());
			_grafo.connect(122, 75, new StandardLinearEdge());
			_grafo.connect(149, 120, new StandardLinearEdge());
			_grafo.connect(140, 111, new StandardLinearEdge());
			
		}
		
		private function paintNode(ev:NodeEvent):void {
			ev.node.graphics.beginFill(Node.NODE_COLOR, 1);
			ev.node.graphics.drawCircle(0, 0, Node.NODE_RADIUS);
			ev.node.graphics.endFill();
			ev.node.visible = false;
		}
		
	}

}