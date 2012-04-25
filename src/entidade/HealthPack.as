package src.entidade {
	
	import flash.display.MovieClip;
	import lib.engine.GameObject;
	import src.app.BaseWorld;
	
	/**
	 * ...
	 * @author Clewerton Coelho
	 * Power-up de HP.
	 */
	
	public class HealthPack extends PowerUp {
		
		public function HealthPack(world:BaseWorld) {
			super(world, 200, 0);
			
			_hitRegion.graphics.beginFill(0xCCCCCC, 0);
			_hitRegion.graphics.drawRect( -7, -7, 15, 15);
			_hitRegion.graphics.endFill();

		}
		
		public override function apply(obj:Vehicle):void {
			obj.increaseHealth(health);
		}
	}
	
}
