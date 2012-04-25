package src.entidade {
	import src.app.BaseWorld;
	
	/**
	 * ...
	 * @author Clewerton Coelho
	 * Um tipo de munição para arma de fogo.
	 */
	
	public class Missile extends Bullet {
		
		public function Missile(world:BaseWorld) {
			super(world, 2, 3, 60);
		}
	}
	
}
