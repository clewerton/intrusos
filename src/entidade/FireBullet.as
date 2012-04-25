package src.entidade {
	import src.app.BaseWorld;
	
	/**
	 * ...
	 * @author Clewerton Coelho
	 * Um tipo de munição de arma de fogo.
	 */
	
	public class FireBullet extends Bullet {
		
		public function FireBullet(world:BaseWorld) {
			super(world, 2, 10, 25);
		}
	}
	
}
