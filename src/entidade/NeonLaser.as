package entidade {
	
	import flash.display.MovieClip;
	import context.GameWorld;
	
	
	public class NeonLaser extends Bullet {
		
		public function NeonLaser(world:GameWorld) {
			super(world, 1, 7, 30);
		}
	}
	
}
