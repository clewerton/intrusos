package lib.graph.event {
	
	import flash.events.Event;
	import lib.graph.Node;
	
	/**
	 * ...
	 * @author Clewerton Coelho
	 * Representa um evento de Nó.
	 */
	
	public class NodeEvent extends Event {

    //public static const EDGE_CLICKED:String = "EdgeEvent:EdgeClicked";

		private var _node:Node;
		
		public function NodeEvent(type:String, theNode:Node, bubbles:Boolean=false, cancelable:Boolean=false) {
			super(type, bubbles, cancelable);
			_node = theNode;
		}

		public function get node():Node {
			return _node;
		}

	}
	
}
