package src.entidade {
	
	import flash.display.MovieClip;
	import src.app.BaseWorld;
	
	
	public class PlasmaBeam extends Bullet {
		
		public function PlasmaBeam(world:BaseWorld) {
			super(world, 1, 5, 150);
		}
	}
	
}
