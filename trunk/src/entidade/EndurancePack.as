package src.entidade {
	
	import flash.display.MovieClip;
	import lib.engine.GameObject;
	import src.app.BaseWorld;
	
	
	public class EndurancePack extends PowerUp {
		
		public function EndurancePack(world:BaseWorld) {
			super(world, 0, 2);
			
			_hitRegion.graphics.beginFill(0xCCCCCC, 0);
			_hitRegion.graphics.drawRect( -7, -7, 15, 15);
			_hitRegion.graphics.endFill();
		}
		
		public override function apply(obj:Vehicle):void {
			obj.endurance += endurance;
		}
		
	}
	
}
