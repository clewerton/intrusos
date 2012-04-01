package entidade {
	import context.GameWorld;
	
	public class StandardTruck extends Vehicle {
		
		public function StandardTruck(world:GameWorld) {
			super(world, 500, 2, 50);
			
			_hitRegion.graphics.beginFill(0xCCCCCC, 0);
			_hitRegion.graphics.drawRect(-12, -5, 25, 10);
		}
		
		protected override function getNewBullet():void {
			gameWorld.getBullet(FireBullet, this, enemy);
		}
		
	}
	
}
