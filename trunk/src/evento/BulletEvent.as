package src.evento 
{
	import flash.events.Event;

	/**
	 * ...
	 * @author Clewerton Coelho
	 * Representa um evento de Munição.
	 */
	public class BulletEvent extends Event {

		private var _enemy:Bullet;
		
		public function BulletEvent(type:String, enemy:Bullet, bubbles:Boolean=false, cancelable:Boolean=false) {
			super(type, bubbles, cancelable);
			_enemy = enemy;
		}
		
		public function get enemy():Bullet 
		{
			return _enemy;
		}
		
	}

}