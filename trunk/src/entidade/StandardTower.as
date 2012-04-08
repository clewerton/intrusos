package src.entidade {
	import src.app.BaseWorld;
	
	public class StandardTower extends Tower {
		
		public function StandardTower(world:BaseWorld) {
			super(world, 350, 40);
			
			_hitRegion.graphics.beginFill(0xCCCCCC, 0);
			_hitRegion.graphics.drawRect(-8, -8, 16, 16);
		}
		
		public override function scoreValue():uint {
			return 110;
		}
		
		protected override function getNewBullet():void {
			gameWorld.newBullet(NeonLaser, this, enemy);
		}
	}
	
}
