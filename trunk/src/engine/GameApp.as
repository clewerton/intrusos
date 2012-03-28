package engine 
{
	import flash.display.MovieClip;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Clewerton Coelho
	 */
	public class GameApp extends GameObject 
	{
		// Gerenciador de GameObjects
		private var _world:GameWorld;
		
		// Gerenciador de Som
		private var _soundManager:SoundManager;
		
		// Gerenciador de telas
		private var _screenManager:ScreenManager;

		// Gerenciador de Input
		private var _inputManager:InputManager;
		
		// Método padrão a ser chamado para inicializar os filhos
		public override function init():void
		{
			super.init();
			
			_soundManager = new SoundManager();
			_screenManager = new ScreenManager();
			
			addChild(_world);
			_world.init();
		}
		
		// Coloca a engine em estado de execução
		public function runApp():void {
			stage.addEventListener(Event.ENTER_FRAME, updateFrameHandler, false, 0, true);
		}

		// Suspende a execução da engine
		public function stopApp():void {
			stage.removeEventListener(Event.ENTER_FRAME, updateFrameHandler, false);
		}
		
		protected function updateFrameHandler(e:Event):void {
			update();
		}

		public override function update():void {
			super.update();
			_world.update();
		}
		
		public override function dispose():void {
			stage.removeEventListener(Event.ENTER_FRAME, updateFrameHandler, false);
			removeChild(_world);
			super.dispose();
		}
		
		// Getters and Setters
		protected function get world():GameWorld
		{
			return _world;
		}
		
		protected function set world(value:GameWorld):void 
		{
			_world = value;
		}
		
		public function get soundManager():SoundManager 
		{
			return _soundManager;
		}
		
		public function get screenManager():ScreenManager 
		{
			return _screenManager;
		}
		
		public function get inputManager():InputManager 
		{
			return _inputManager;
		}
		
		public function set inputManager(value:InputManager):void 
		{
			_inputManager = value;
		}
		
	}

}