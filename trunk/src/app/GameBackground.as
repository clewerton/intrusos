package src.app
{
	
	import flash.display.MovieClip;
	import lib.engine.GameObject;
	import flash.events.Event;
	
	public class GameBackground extends GameObject
	{
		private var _levelIndex:int;
		
		public function GameBackground(levelIndex:int)
		{
			_levelIndex = levelIndex;
		}
		
		protected override function onAddedToStage(e:Event = null):void
		{
			switch (_levelIndex)
			{
				case 1: 
					graphics.beginFill(0xA99480);
					break;
			}
			graphics.drawRect(0, 0, stage.stageWidth, stage.stageHeight);
			graphics.endFill();
		}
	}

}
