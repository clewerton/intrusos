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
		// Mapa de contextos <String, GameContext>.
		private var _contextMap:Dictionary;

		// Contexto ativo.
		private var _activeContext:GameContext;
		
		public function GameContextRepository()
		{
			_contextMap = new Dictionary();
		}
		
		function registerContext(context:GameContext, id:String):void 
		{
			_contextMap[id] = context;
		}

		function unregisterContext(id:String):void 
		{
			if(_activeContext != _contextMap[id]) {
				_contextMap[id] = null;
			}
		}
		
		function get activeContext():GameContext 
		{
			return _activeContext;
		}
		
		function activateContextById(id:String):void 
		{
			if (existsContext(id)) {
				if(_activeContext != null) {
					_activeContext.inputManager.disable();
				}
				_activeContext = _contextMap[id];
				_activeContext.inputManager.enable();

			}
		}
		
		function existsContext(id:String) {
			return _contextMap[id] != null;
		}

	}

}