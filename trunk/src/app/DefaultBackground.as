package src.app
{
	
	import flash.display.MovieClip;
	import lib.engine.GameObject;
	import flash.events.Event;
	
	public class DefaultBackground extends GameObject
	{
		
		protected override function onAddedToStage(e:Event = null):void
		{
			graphics.beginFill(0x606093);
			graphics.drawRect(0, 0, stage.stageWidth, stage.stageHeight);
			graphics.endFill();
		}
	}

}
