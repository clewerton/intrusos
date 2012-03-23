package entidade {
	
	import flash.display.MovieClip;
	
	
	public class NeonLaser extends Bullet {
		
		public function NeonLaser(enemy:GameObject, health:uint, speed:uint) {
			super(enemy, 1, 15);
		}
	}
	
}
