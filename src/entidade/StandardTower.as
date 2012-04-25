package src.entidade {
	import src.app.BaseWorld;
	
	/**
	 * ...
	 * @author Clewerton Coelho
	 * Um tipo de torre.
	 */
	
	public class StandardTower extends Tower {
		
		public function StandardTower(world:BaseWorld) {
			super(world, 400, 100, 600);
			
			_hitRegion.graphics.beginFill(0xCCCCCC, 0);
			_hitRegion.graphics.drawRect( -8, -8, 16, 16);
			_hitRegion.graphics.endFill();
		}
		
		public override function scoreValue():uint {
			return 150;
		}
		
		protected override function getNewBullet():void {
			gameWorld.newBullet(NeonLaser, this, enemy);
		}
	}
	
}
