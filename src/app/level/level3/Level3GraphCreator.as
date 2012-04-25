package src.app.level.level3
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
	 * Criador do grafo da fase 3
	 */
	public class Level3GraphCreator
	{
		private var _grafo:DirectedGraph;
		private var _total:uint = 0;
		
		public function Level3GraphCreator() {
			_grafo = new DirectedGraph();
			_grafo.addEventListener(EventChannel.NODE_ADDED, paintNode, false, 0, true);
			creatGraph();
		}
		
		public function getGraph():DirectedGraph {
			return _grafo;
		}

		private function createNodes():void {
			
			_grafo.addNode(new Node(_total++, 480, 390));
			_grafo.addNode(new Node(_total++, 530, 340));
			_grafo.addNode(new Node(_total++, 460, 270));
			_grafo.addNode(new Node(_total++, 370, 360));
			_grafo.addNode(new Node(_total++, 480, 470));
			_grafo.addNode(new Node(_total++, 610, 340));
			_grafo.addNode(new Node(_total++, 460, 190));
			_grafo.addNode(new Node(_total++, 290, 360));
			_grafo.addNode(new Node(_total++, 480, 550));
			_grafo.addNode(new Node(_total++, 700, 340));
			_grafo.addNode(new Node(_total++, 460, 100));
			_grafo.addNode(new Node(_total++, 200, 360));
			_grafo.addNode(new Node(_total++, 480, 640));
			_grafo.addNode(new Node(_total++, 800, 340));
			_grafo.addNode(new Node(_total++, 460, 0));
			_grafo.addNode(new Node(_total++, 100, 360));
			_grafo.addNode(new Node(_total++, 480, 740));
		}
		
		private function creatGraph():void {
			createNodes();
			var counter:int = _total - 1;
			while (counter > 0) {
				_grafo.connect(counter, --counter, new StandardQuadrantEdge());
			}
		}
		
		private function paintNode(ev:NodeEvent):void {
			ev.node.graphics.beginFill(Node.NODE_COLOR, 1);
			ev.node.graphics.drawCircle(0, 0, Node.NODE_RADIUS);
			ev.node.graphics.endFill();
			ev.node.visible = false;
		}
		
	}

}