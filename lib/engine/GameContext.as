package lib.engine
{
	
	/**
	 * ...
	 * @author Clewerton Coelho
	 */
	public class GameContext extends GameContainer
	{
		private var _parentContext:GameContext;
		
		// Container de telas
		private var _contextManager:GameContextManager;
		
		// Processador de input
		private var _inputManager:InputManager;

		// Processador de comandos
		private var _commandProcessor:CommandProcessor;
		
		// Estado corrente do contexto
		private var _stateManager:StateManager;
		
		public function GameContext(parentContext:GameContext)
		{
			_parentContext = parentContext;
			reset();
		}
		
		public function enter():void {}
		
		protected function reset():void {
			_contextManager = new GameContextManager(_parentContext);
			_inputManager = new InputManager(_parentContext);
			_commandProcessor = new CommandProcessor();
			_stateManager = new StateManager();
		}
		
		public override function update():void
		{
			commandProcessor.processAll(inputManager.commands);
			super.update();
			if (_contextManager.activeContext != null && _contextManager.activeContext != this)
			{
				_contextManager.activeContext.update();
			}
		}

		public override function dispose():void
		{
			if (_contextManager.activeContext != null && _contextManager.activeContext != this)
			{
				removeChild(_contextManager.activeContext);
			}
		}

		// Métodos relativos à contexto
		public function addContext(context:GameContext, id:int)
		{
			_contextManager.addContext(context, id);
		}

		protected function removeContext(id:int)
		{
			_contextManager.removeContext(id);
		}
		
		public function switchContext(contextId:int, removePreviousFromStage=true, disposePrevious:Boolean=false)
		{
			_contextManager.switchContext(contextId, removePreviousFromStage, disposePrevious);
		}
		
		// Métodos relativos à estado
		protected function addState(stateId:uint, action:Function):void 
		{
			_stateManager.addState(stateId, action);
		}
		
		public function get activeState():uint {
			return _stateManager._activeStateId;
		}

		// Getters e Setters
		public function set activeState(value:uint):void 
		{
			_stateManager.activeStateId = value;
		}
		
		public function get inputManager():InputManager
		{
			return _inputManager;
		}
		
		public function set inputManager(value:InputManager):void 
		{
			_inputManager = value;
		}
		
		public function get commandProcessor():CommandProcessor 
		{
			return _commandProcessor;
		}
		
		public function get parentContext():GameContext 
		{
			return _parentContext;
		}
		
	}

}