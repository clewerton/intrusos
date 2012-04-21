package src.app {
	
	import flash.display.MovieClip;
	import lib.engine.GameObject;
	import flash.text.TextFieldAutoSize;
	
	
	public class HudValue extends GameObject {
		
		private var _score:int;
		
		public function HudValue(alignment:String, val:int = 0, theColor:uint=0x000000) {
			this.score = val;
			scoreStr.textColor = theColor;
			scoreStr.autoSize = alignment;
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
