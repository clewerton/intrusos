﻿package src.app
{
	
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;
	import flash.events.Event;
	
	public class GameMenuItem extends SimpleButton
	{
		
		private var command:Function;
		
		public function GameMenuItem(val:String, func:Function)
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
			command = func;
			addEventListener(MouseEvent.CLICK, command, false, 0, true);
			
		}
		
		protected function init(e:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
		}
	
	}

}