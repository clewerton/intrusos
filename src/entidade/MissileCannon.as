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
	public class MissileCannon extends Cannon {

		public function MissileCannon(world:BaseWorld, owner:Vehicle) {
			super(world, owner, 130, 1500);
		}
		
		protected override function getNewBullet():void {
			gameWorld.newBullet(Missile, owner, owner.enemy);
		}
	}

}