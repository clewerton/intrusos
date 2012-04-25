package src.app
{
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author Clewerton Coelho
	 * Representa um item de menu.
	 */
	
	public class GameMenuItem extends MovieClip
	{
		
		private var command:Function;
		
		public function GameMenuItem(val:String, theColor:uint, func:Function) {
			buttonMode = true;
			useHandCursor = true;
			mouseChildren = false;			
			str.text = val;
			str.textColor = theColor;
			addEventListener(Event.ADDED_TO_STAGE, init);
			command = func;
			addEventListener(MouseEvent.CLICK, command, false, 0, true);
		}
		
		protected function init(e:Event = null):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
		}
	}

}
