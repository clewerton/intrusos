package src.evento 
{
	import flash.events.Event;

	/**
	 * ...
	 * @author ...
	 */
	public class ConvoySelectedEvent extends Event {

		private var _selection:Vector.<Class>;
		
		public function ConvoySelectedEvent(type:String, selection:Vector.<Class>, bubbles:Boolean=false, cancelable:Boolean=false) {
			super(type, bubbles, cancelable);
			_selection = selection;
		}
		
		public function get selection():Vector.<Class> 
		{
			return _selection;
		}
		
	}

}