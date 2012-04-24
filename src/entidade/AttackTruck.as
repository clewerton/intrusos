package src.entidade {
	import src.app.BaseWorld;
	
	public class AttackTruck extends Vehicle {
		
		public function AttackTruck(world:BaseWorld) {
			super(world, 500, 2, 8, new MissileCannon(world, this));
			
			_hitRegion.graphics.beginFill(0xCCCCCC, 0);
			_hitRegion.graphics.drawRect( -12, -5, 25, 10);
			_hitRegion.graphics.endFill();
		}
	}
	
}
