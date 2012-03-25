package {
	import entidade.Bullet;
	import entidade.FireBullet;
	import entidade.NeonLaser;
	/**
	 * ...
	 * @author Clewerton Coelho
	 */
	public class BulletFactory 
	{
		
		public static const FIRE_BULLET:String = "FireBullet";
		public static const NEON_LASER:String = "NeonLaser";
		
		private static var _instance:BulletFactory;
		
		public function BulletFactory() { }
		
		public static function getInstance():BulletFactory {
			if (_instance == null) {
				_instance = new BulletFactory();
			}
			return _instance;
		}
		
		public function getBullet(type:String):Bullet {
			switch(type) {
				case FIRE_BULLET:
					return new FireBullet();
				case NEON_LASER:
					return new NeonLaser();
			}
			return null;
		}
		
	}

}