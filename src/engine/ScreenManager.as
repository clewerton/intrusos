package engine 
{
	/**
	 * ...
	 * @author Clewerton Coelho
	 */
	public class ScreenManager 
	{
		private var _screens:Vector.<GameScreen> = new Vector.<GameScreen>;
		private var _currentScreen:GameScreen;
		
		public function ScreenManager() 
		{
		}
		
		public function addScreen(screen:GameScreen):void {
			_screens.push(screen);
		}
		
		public function removeScreen(screen:GameScreen):void {
			_screens.splice(_screens.indexOf(screen), 1);
			_screens.push(screen);
		}
		
		public function get currentScreen():GameScreen 
		{
			return _currentScreen;
		}
		
		public function set currentScreen(value:GameScreen):void 
		{
			_currentScreen = value;
		}
		
		
	}

}