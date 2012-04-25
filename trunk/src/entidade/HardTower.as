package src.entidade {
	import src.app.BaseWorld;
	
	/**
	 * ...
	 * @author Clewerton Coelho
	 * Um tipo de torre.
	 */
	
	public class HardTower extends Tower {
		
		public function HardTower(world:BaseWorld) {
			super(world, 2000, 150, 2000);
			
			_hitRegion.graphics.beginFill(0xCCCCCC, 0);
			_hitRegion.graphics.drawRect( -13, -13, 26, 26);
			_hitRegion.graphics.endFill();
		}
		
		public override function scoreValue():uint {
			return 250;
		}
		
		protected override function getNewBullet():void {
			gameWorld.newBullet(NukaBeam, this, enemy);
		}
	}
	
}
