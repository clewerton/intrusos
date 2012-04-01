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
			_contextRepository = new GameContextRepository();
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
		
		public function get inputManager():InputManager
		{
			return _inputManager;
		}
		
		public function registerContext(context:GameContext, id:String)
		{
			_contextRepository.registerContext(context, id);
		}

		public function unregisterContext(id:String)
		{
			_contextRepository.unregisterContext(id);
		}
		
		public function set activeContext(contextId:String)
		{
			if ((stage != null) && _contextRepository.existsContext(contextId)) {
				if (_contextRepository.activeContext != null)
				{
					removeChild(_contextRepository.activeContext);
				}
				_contextRepository.activateContextById(contextId);
				_inputManager = _contextRepository.activeContext.inputManager;
				addChild(_contextRepository.activeContext);
			}
		}
		
	}

}