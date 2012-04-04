package engine 
{
	import flash.utils.Dictionary;
	/**
	 * ...
	 * @author Clewerton Coelho
	 * Classe interna reponsável por gerenciar os contextos.
	 */
	internal class GameContextRepository
	{
		private var _gameApp:GameApp;
		
		// Mapa de classes de contextos <String, Class<GameContext>>.
		private var _contextClassMap:Dictionary;

		// Mapa de contextos instanciados <String, GameContext>.
		private var _contextMap:Dictionary;
		
		// Id do contexto ativo
		private var _activeId:String = null;
		
		public function GameContextRepository(gameApp:GameApp)
		{
			init();
			_gameApp = gameApp;
		}
		
		public function init():void {
			_contextClassMap = new Dictionary();
			_contextMap = new Dictionary();
		}

		function registerContext(contextClass:Class, id:String):void 
		{
			_contextClassMap[id] = contextClass;
		}

		function unregisterContext(id:String):void 
		{
			if(_activeId != id) {
				delete _contextMap[id];
			}
			delete _contextClassMap[id];
		}
		
		function get activeContext():GameContext 
		{
			return _contextMap[_activeId];
		}
		
		function existsContextClass(id:String) {
			return _contextClassMap[id] != null;
		}

		function existsContext(id:String) {
			return _contextMap[id] != null;
		}
		
		function switchContext(id:String, deletePrevious:Boolean=false) 
		{
			var nextContextClass:Class = _contextClassMap[id];
			var nextContext:GameContext = _contextMap[id];
			
			if ((nextContextClass != null) && (id != _activeId)) {
				if (_contextMap[_activeId] != null) {
					// limpar a configuração do contexto antigo:
					_gameApp.removeChild(_contextMap[_activeId]);
					_contextMap[_activeId].inputManager.disable();
					if (deletePrevious) {
						delete _contextMap[_activeId];
					}
				}
				
				// configurar o novo contexto:
				_activeId = id;
				if (_contextMap[_activeId] == null) {
					_contextMap[_activeId] = new _contextClassMap[id](_gameApp);
				}
				_gameApp.inputManager = _contextMap[_activeId].inputManager;
				_contextMap[_activeId].inputManager.enable();
				_gameApp.addChild(_contextMap[_activeId]);
			}
		}
		
	}

}