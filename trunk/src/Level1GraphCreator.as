package
{
	import evento.PathEvent;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.ColorTransform;
	import grafo.DirectedGraph;
	import grafo.Edge;
	import grafo.Node;
	import grafo.Path;
	
	/**
	 * ...
	 * @author Clewerton Coelho
	 */
	public class Level1GraphCreator
	{
		private var _grafo:DirectedGraph;
		private var _stage:Stage;
		
		public function Level1GraphCreator(stage:Stage) {
			_stage = stage;
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
			
			_grafo.connect(0, 1, new Edge()).name = "01";
			_grafo.connect(0, 3, new Edge()).name = "03";
			_grafo.connect(1, 2, new Edge()).name = "12";
			_grafo.connect(1, 4, new Edge()).name = "14";
			_grafo.connect(2, 5, new Edge()).name = "25";
			_grafo.connect(3, 4, new Edge()).name = "34";
			_grafo.connect(3, 6, new Edge()).name = "36";
			_grafo.connect(4, 5, new Edge()).name = "45";
			_grafo.connect(5, 7, new Edge()).name = "57";
			_grafo.connect(6, 7, new Edge()).name = "67";
			_grafo.connect(7, 6, new Edge()).name = "76";
			_grafo.connect(6, 3, new Edge()).name = "63";
			
		}
	}

}