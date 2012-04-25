package src.entidade {
	
	import flash.display.MovieClip;
	import src.app.BaseWorld;
	
	/**
	 * ...
	 * @author Clewerton Coelho
	 * Um tipo de laser.
	 */
	
	public class NeonLaser extends Bullet {
		
		public function NeonLaser(world:BaseWorld) {
			super(world, 1, 7, 45);
		}
	}
	
}
