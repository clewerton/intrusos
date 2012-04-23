package src.entidade 
{
	import lib.engine.GameObject;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import src.app.BaseWorld;

	/**
	 * ...
	 * @author Clewerton Coelho
	 */
	public class GunCannon extends Cannon {

		public function GunCannon(world:BaseWorld, owner:Vehicle) {
			super(world, owner, 100, 400);
		}
		
		protected override function getNewBullet():void {
			gameWorld.newBullet(FireBullet, owner, owner.enemy);
		}
	}

}