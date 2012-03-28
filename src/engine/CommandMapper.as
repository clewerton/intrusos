package src.engine 
{
	/**
	 * ...
	 * @author ...
	 */
	public class CommandMapper 
	{
		private var _commands:Vector.<uint> = new Vector.<uint>();
		
		public function CommandMapper() 
		{
			
		}
		
		public function addCommand(key:uint, command:String):void {
			_commands[key] = command;
		}

		public function removeCommand(command:String):void {
			for each(var key:uint in _commands) {
				if (_commands[key] == command) {
					delete _commands[key];
				}
			}
		}
		
	}

}