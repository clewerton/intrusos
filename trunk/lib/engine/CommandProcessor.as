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
		private var _popFromCommandBuffer:Array;
		
		public function CommandProcessor()
		{
			init();
		}
		
		public function init():void {
			_commandHandlers = new Dictionary();
			_popFromCommandBuffer = new Array();
		}
		
		public function dispose():void {
			_commandHandlers = null;
		}
		
		public function addCommand(command:String, handler:Function, popFromBuffer:Boolean=true):void {
			_commandHandlers[command] = handler;
			if (popFromBuffer) {
				_popFromCommandBuffer[command] = true;
			}
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
				if (_popFromCommandBuffer[command]) {
					commands.pop();
				}
				process(command);
			}
		}
		
	}

}