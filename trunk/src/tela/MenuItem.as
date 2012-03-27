﻿package tela {
	
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;
	import flash.events.Event;
	
	
	public class MenuItem extends SimpleButton {
		
		private var command:Function;
		
		public function MenuItem(val:String, func:Function) {
			addEventListener(Event.ADDED_TO_STAGE, init);
			command = func;
			this.addEventListener(MouseEvent.CLICK, command, false, 0, true);
		}

		protected function init(e:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
		}
		
	}
	
}