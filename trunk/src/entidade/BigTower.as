package src.entidade {
	import src.app.BaseWorld;
	
	public class BigTower extends Tower {
		
		public function BigTower(world:BaseWorld) {
			super(world, 600, 120, 1800);
			
			_hitRegion.graphics.beginFill(0xCCCCCC, 0);
			_hitRegion.graphics.drawRect( -13, -13, 26, 26);
			_hitRegion.graphics.endFill();
		}
		
		public override function scoreValue():uint {
			return 250;
		}
		
		protected override function getNewBullet():void {
			gameWorld.newBullet(PlasmaBeam, this, enemy);
		}
	}
	
}
