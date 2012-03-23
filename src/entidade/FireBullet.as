package entidade {
	
	import flash.display.MovieClip;
	
	
	public class FireBullet extends Bullet {
		
		
		public function FireBullet(enemy:GameObject, health:uint, speed:uint) {
			super(enemy, 2, 10);
		}
	}
	
}
