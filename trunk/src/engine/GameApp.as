package engine
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Clewerton Coelho
	 */
	public class GameApp extends GameObject
	{
		// Container de telas
		private var _contextRepository:GameContextRepository;
		
		// Gerenciador de Som
		private var _soundManager:SoundManager;
		
		// Gerenciador de Input
		private var _inputManager:InputManager;
		
		public function GameApp()
		{
			_soundManager = new SoundManager();
			_contextRepository = new GameContextRepository(this);
		}
		
		// Coloca a engine em estado de execução
		public function runApp():void
		{
			stage.addEventListener(Event.ENTER_FRAME, updateFrameHandler, false, 0, true);
		}
		
		// Suspende a execução da engine
		public function stopApp():void
		{
			stage.removeEventListener(Event.ENTER_FRAME, updateFrameHandler, false);
		}
		
		private function updateFrameHandler(e:Event):void
		{
			update();
		}
		
		public override function update():void
		{
			super.update();
			if (_contextRepository.activeContext != null)
			{
				_contextRepository.activeContext.update();
			}
		}
		
		public override function dispose():void
		{
			stage.removeEventListener(Event.ENTER_FRAME, updateFrameHandler, false);
			if (_contextRepository.activeContext != null)
			{
				removeChild(_contextRepository.activeContext);
			}
			super.dispose();
		}
		
		// Getters and Setters
		public function get soundManager():SoundManager
		{
			return _soundManager;
		}
		
		internal function get inputManager():InputManager 
		{
			return _inputManager;
		}
		
		internal function set inputManager(value:InputManager):void 
		{
			_inputManager = value;
		}
		
		public function registerContext(contextClass:Class, id:String)
		{
			_contextRepository.registerContext(contextClass, id);
		}

		public function unregisterContext(id:String)
		{
			_contextRepository.unregisterContext(id);
		}
		
		public function switchContext(contextId:String, disposePrevious:Boolean=false)
		{
			_contextRepository.switchContext(contextId, disposePrevious);
		}
		
	}

}