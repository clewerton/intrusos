package engine 
{
	import flash.utils.Dictionary;

	/**
	 * ...
	 * @author Clewerton Coelho
	 */
	public class CommandProcessor 
	{
		// Mapeamento comando -> handler. Map<String, Function)
		private var _commandHandlers:Dictionary;
		
		public function CommandProcessor()
		{
			_commandHandlers = new Dictionary();
		}
		
		public function addCommand(command:String, handler:Function):void {
			_commandHandlers[command] = handler;
		}

		public function removeCommand(command:String):void {
			delete _commandHandlers[command];
		}
		
		public function process(commands:Vector.<String>):void {
			for each(var command:String in commands) {
				_commandHandlers[command]();
			}
		}
		
	}

}