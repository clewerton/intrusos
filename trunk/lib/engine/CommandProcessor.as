package lib.engine 
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
			init();
		}
		
		public function init():void {
			_commandHandlers = new Dictionary();
		}
		
		public function dispose():void {
			_commandHandlers = null;
		}
		
		public function addCommand(command:String, handler:Function):void {
			_commandHandlers[command] = handler;
		}

		public function removeCommand(command:String):void {
			delete _commandHandlers[command];
		}
		
		public function process(commandId:String):void {
			//trace("-> " + commandId);
			_commandHandlers[commandId]();
		}

		public function processAll(commands:Vector.<String>):void {
			for each(var command:String in commands) {
				commands.pop();
				process(command);
			}
		}
		
	}

}