package engine 
{
	import flash.display.MovieClip;
	import flash.events.Event;

	/**
	 * ...
	 * @author Clewerton Coelho
	 */
	public class GameObject extends MovieClip
	{
		private var _active:Boolean;
		
		public function GameObject() 
		{
			_active = true;
			//addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		/*protected function onAddedToStage(e:Event = null):void
		{
		}*/
		
		// Atualiza o estado do elemento
		public function update():void {
			if (!_active) {
				return;
			}
		}

		public function get active():Boolean 
		{
			return _active;
		}
		
		public function set active(value:Boolean):void 
		{
			_active = value;
		}
		
	}

}