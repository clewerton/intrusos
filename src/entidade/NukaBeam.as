package src.entidade {
	
	import flash.display.MovieClip;
	import src.app.BaseWorld;
	
	/**
	 * ...
	 * @author Clewerton Coelho
	 * Um laser baseado num mundo pós-guerra.
	 */
	
	public class NukaBeam extends Bullet {
		
		public function NukaBeam(world:BaseWorld) {
			super(world, 1, 5, 250);
		}
	}
	
}
