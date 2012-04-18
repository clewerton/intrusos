package src.app
{
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class GameMenuItem extends MovieClip
	{
		
		private var command:Function;
		
		public function GameMenuItem(val:String, func:Function) {
			buttonMode = true;
			useHandCursor = true;
			mouseChildren = false;			
			str.text = val;
			addEventListener(Event.ADDED_TO_STAGE, init);
			command = func;
			addEventListener(MouseEvent.CLICK, command, false, 0, true);
		}
		
		protected function init(e:Event = null):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
		}
	}

}
