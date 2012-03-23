package  {
	
	import flash.display.MovieClip;
	
	
	public class HudValue extends MovieClip {
		
		private var _score:int;
		
		public function HudValue(val:int = 0) {
			this.score = val;
		}
		
		public function set score(val:int):void {
			_score = val;
			scoreStr.text = String(_score);
		}

		public function get score():int {
			return _score;
		}
		
	}
	
}
