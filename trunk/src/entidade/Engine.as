package entidade 
{
	import entidade.GameObject;
	import flash.display.Stage;
	import flash.events.Event;

	/**
	 * ...
	 * @author Clewerton Coelho
	 */
	public class Engine 
	{
		protected var _stage:Stage;
		protected var _world:GameWorld;
		protected var _gameObjects:Vector.<GameObject> = new Vector.<GameObject>();
		//private var _inputManager:InputManager;
		//private var _soundManager:SoundManager;
		
		public function Engine(stageRef:Stage)
		{
			_stage = stageRef;
		}
		
		public function start():void {
			_stage.addEventListener(Event.ENTER_FRAME, update, false, 0, true);
		}

		public function stop():void {
			_stage.removeEventListener(Event.ENTER_FRAME, update, false);
		}
		
		public function update(e:Event):void {
			_world.update();
			for each(var obj:GameObject in _gameObjects) {
				obj.update();
			}
		}
		
	}

}