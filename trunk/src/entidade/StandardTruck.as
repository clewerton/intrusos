﻿package entidade {
	
	public class StandardTruck extends Vehicle {
		
		public function StandardTruck(world:BaseWorld) {
			super(world, 500, 2, 50);
			
			_hitRegion.graphics.beginFill(0xCCCCCC, 0);
			_hitRegion.graphics.drawRect(-12, -5, 25, 10);
		}
		
		protected override function getNewBullet():void {
			gameWorld.newBullet(FireBullet, this, enemy);
		}
		
	}
	
}