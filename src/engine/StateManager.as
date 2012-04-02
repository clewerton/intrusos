package engine 
{
	/**
	 * ...
	 * @author Clewerton Coelho
	 */
	public class StateManager 
	{
		// Indexed array (uint -> Function)
		var _states:Array
		
		// Estado ativo
		var _activeStateId:uint;
		
		public function StateManager() 
		{
			_states = new Array();
		}
		
		public function addState(stateId:uint, transition:Function):void {
			_states[stateId] = transition;
		}

		public function removeState(stateId:uint):void {
			delete _states[stateId];
		}
		
		public function get activeStateId():uint 
		{
			return _activeStateId;
		}
		
		public function set activeStateId(value:uint):void 
		{
			_activeStateId = value;
			performTransition(_activeStateId);
		}
		
		private function performTransition(stateId:uint):void {
			_states[stateId]();
		}
		
	}

}