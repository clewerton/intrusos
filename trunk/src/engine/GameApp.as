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
		private var _contextManager:GameContextManager;
		
		// Gerenciador de Som
		private var _soundManager:SoundManager;
		
		// Gerenciador de Input
		private var _inputManager:InputManager;

		// Gerenciador de estados
		private var _stateManager:StateManager;
		
		private var _levelIndex:uint = 1;
		
		public function GameApp()
		{
			_soundManager = new SoundManager();
			_contextManager = new GameContextManager(this);
			_stateManager = new StateManager();
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
			if (_contextManager.activeContext != null)
			{
				_contextManager.activeContext.update();
			}
		}
		
		public function dispose():void
		{
			stage.removeEventListener(Event.ENTER_FRAME, updateFrameHandler, false);
			if (_contextManager.activeContext != null)
			{
				removeChild(_contextManager.activeContext);
			}
		}
		
		// Métodos relativos à estado
		protected function addState(stateId:uint, action:Function):void 
		{
			_stateManager.addState(stateId, action);
		}
		
		public function get activeState():uint {
			return _stateManager._activeStateId;
		}

		public function set activeState(value:uint):void 
		{
			_stateManager.activeStateId = value;
		}
		
		// Métodos relativos à contexto
		protected function addContext(context:GameContext, id:int)
		{
			_contextManager.addContext(context, id);
		}

		protected function removeContext(id:int)
		{
			_contextManager.removeContext(id);
		}
		
		public function switchContext(contextId:int, disposePrevious:Boolean=false)
		{
			_contextManager.switchContext(contextId, disposePrevious);
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
		
		public function get levelIndex():uint 
		{
			return _levelIndex;
		}
		
		public function set levelIndex(value:uint):void 
		{
			_levelIndex = value;
		}
		
	}

}