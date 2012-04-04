package engine
{
	import engine.GameObject;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Clewerton Coelho
	 */
	public class GameContainer extends GameObject
	{
		private var _gameObjects:Vector.<GameObject>;
		
		public function GameContainer()
		{
			_gameObjects = new Vector.<GameObject>;
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage, false, 0, true);
		}

		protected function onAddedToStage(e:Event = null):void
		{
			for each(var obj:GameObject in _gameObjects) {
				addChild(obj);
			}
		}
			
		public override function update():void
		{
			super.update();
			for each (var item:GameObject in _gameObjects) {
				item.update();
			}
		}
		
		public override function set active(value:Boolean):void 
		{
			super.active = value;
			for each (var item:GameObject in _gameObjects) {
				item.active = value;
			}
		}
		
		public function addGameObject(obj:GameObject):void
		{
			if (stage != null && !contains(obj)) {
				addChild(obj);
			}
			_gameObjects.push(obj);
		}
		
		public function removeGameObject(obj:GameObject):void
		{
			if (stage != null && contains(obj)) {
				removeChild(obj);
			}
			_gameObjects.splice(_gameObjects.indexOf(obj), 1);
		}
		
		protected function filterGameObjects(predicate:Function, obj:GameObject)
		{
			var result:Vector.<GameObject> = _gameObjects.filter(predicate, obj);
			return result;
		}
	
	}

}