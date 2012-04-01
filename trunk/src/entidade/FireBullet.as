package entidade {
	import context.GameWorld;
	
	public class FireBullet extends Bullet {
		
		public function FireBullet(world:GameWorld) {
			super(world, 2, 5, 20);
		}
	}
	
}
