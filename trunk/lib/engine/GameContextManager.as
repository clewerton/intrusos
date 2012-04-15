package lib.engine
{
	import flash.utils.Dictionary;
	
	/**
	 * ...
	 * @author Clewerton Coelho
	 * Classe interna reponsável por gerenciar os contextos.
	 */
	internal class GameContextManager
	{
		private var _gameApp:GameApp;
		
		// <id:uint, context:GameContext> - Nao usar Vector, pois a matriz deve ser indexada !
		private var _contextMap:Dictionary;
		private var _activeContextId:int;
		
		public function GameContextManager(gameApp:GameApp)
		{
			init();
			_gameApp = gameApp;
		}
		
		public function init():void
		{
			_contextMap = new Dictionary();
		}
		
		function addContext(context:GameContext, id:int):void
		{
			if (_contextMap[id] == null) {
				_contextMap[id] = context;
			}
		}
		
		function removeContext(id:int):void
		{
			if (id != _activeContextId && existsContext(id)) {
				delete _contextMap[id];
			}
		}
		
		function get activeContext():GameContext
		{
			return _contextMap[_activeContextId];
		}
		
		function existsContext(id:int)
		{
			return _contextMap[id] != null;
		}
		
		function switchContext(id:int, deletePrevious:Boolean = false)
		{
			var nextContext:GameContext = _contextMap[id];
			
			if (id != _activeContextId && nextContext != null) {
				if (_contextMap[_activeContextId] != null) {
					// limpar a configuração do contexto antigo:
					_gameApp.removeChild(_contextMap[_activeContextId]);
					_contextMap[_activeContextId].inputManager.disable();
					if (deletePrevious) {
						_contextMap[_activeContextId].dispose();
						delete _contextMap[_activeContextId];
					}
				}
				
				// configurar o novo contexto:
				_activeContextId = id;
				_gameApp.inputManager = _contextMap[_activeContextId].inputManager;
				_contextMap[_activeContextId].inputManager.enable();
				_gameApp.addChild(_contextMap[_activeContextId]);
			}
		}
	
	}

}