package entidade {
	
	import flash.display.MovieClip;
	import flash.display.Shape;
	
	public class StandardTruck extends Vehicle {
		
		public function StandardTruck() {
			super(500, 2, 50);
			
			_hitRegion.graphics.beginFill(0xCCCCCC, 0);
			_hitRegion.graphics.drawRect(-12, -5, 25, 10);
		}
		
		protected override function getNewBullet():void {
			engine.getBullet(FireBullet, this, enemy);
		}
		
	}
	
}
