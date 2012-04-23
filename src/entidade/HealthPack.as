package src.entidade {
	
	import flash.display.MovieClip;
	import lib.engine.GameObject;
	import src.app.BaseWorld;
	
	
	public class HealthPack extends DestroyableObject {
		
		public function HealthPack(world:BaseWorld) {
			super(world, 200);
			
			_hitRegion.graphics.beginFill(0xCCCCCC, 0);
			_hitRegion.graphics.drawRect( -7.5, -7.5, 15, 15);
			_hitRegion.graphics.endFill();

		}
	}
	
}
