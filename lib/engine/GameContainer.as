package lib.engine
{
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
			if (!active) {
				return;
			}
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

		public function get size():int {
			return _gameObjects.length;
		}

		public function getElement(index:int):GameObject {
			return _gameObjects[index];
		}
		
		public function get firstElement():GameObject {
			if(_gameObjects.length > 0) {
				return _gameObjects[0];
			}
			return null;
		}

		public function get lastElement():GameObject {
			if(_gameObjects.length > 0) {
				return _gameObjects[_gameObjects.length - 1];
			}
			return null;
		}

		protected function filterGameObjects(predicate:Function, obj:GameObject):Vector.<GameObject>
		{
			var result:Vector.<GameObject> = _gameObjects.filter(predicate, obj);
			return result;
		}

		protected function forEachGameObject(callback:Function, obj:GameObject=null):void
		{
			_gameObjects.forEach(callback, obj);
		}

	}

}