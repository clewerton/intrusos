package engine 
{
	import engine.GameObject;
	
	/**
	 * ...
	 * @author Clewerton Coelho
	 */
	public class GameWorld extends GameObject 
	{
		private var _gameObjects:Vector.<GameObject> = new Vector.<GameObject>;
		
		public function GameWorld() 
		{
		}

		public override function update():void {
			checkColisions();
			super.update();		// deveria chamar antes ou depois da colisão? :/
			for each(var _gameObject:GameObject in _gameObjects) {
				_gameObject.update();
			}
		}
		
		public override function dispose():void {
			_gameObjects = null;
			super.dispose();
		}
		
		// A ser implementado pelas subclasses
		protected function checkColisions():void {
		}
		
		public function addGameObject(obj:GameObject):void {
			_gameObjects.push(obj);
			addChild(obj);
		}
		
		public function removeGameObject(obj:GameObject):void {
			_gameObjects.splice(_gameObjects.indexOf(obj), 1);
			removeChild(obj);
		}
		
	}

}