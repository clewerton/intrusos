package src.entidade 
{
	import lib.engine.GameObject;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import src.app.BaseWorld;

	/**
	 * ...
	 * @author Clewerton Coelho
	 */
	public class Cannon extends DestroyableObject
	{
		private var _radius:uint;
		private var _interval:uint;
		private var _timer:Timer;
		private var _canShoot:Boolean = false;
		private var _owner:Vehicle;
		private var _bulletClass:Class;
		
		public function Cannon(world:BaseWorld, owner:Vehicle, radius:uint, interval:uint)
		{
			super(world, 10, 0);
			_radius = radius;
			_interval = interval;
			_owner = owner;
			
			_timer = new Timer(_interval);
			_timer.addEventListener(TimerEvent.TIMER, enableShooting, false, 0, true);
		}
		
		public function shoot():void {
			if(!_timer.running) {
				_timer.start();
			}
			if (_canShoot) {
				getNewBullet();
			}
			_canShoot = false;
		}
		
		public function deactivate():void {
			_timer.stop();
		}
		
		protected function getNewBullet():void {
			throw new Error("Metodo Abstrato!");
		}
		
		private function enableShooting(e:TimerEvent):void {
			_canShoot = true;
		}
		
		public function dispose():void {
			_timer = null;
		}
		
		public function get interval():uint 
		{
			return _interval;
		}
		
		public function set interval(value:uint):void 
		{
			_interval = value;
		}
		
		public function get radius():uint 
		{
			return _radius;
		}
		
		public function set radius(value:uint):void 
		{
			_radius = value;
		}
		
		public function get owner():Vehicle 
		{
			return _owner;
		}
		
		public function set owner(value:Vehicle):void 
		{
			_owner = value;
		}
		
		public function get bulletClass():Class 
		{
			return _bulletClass;
		}
		
	}

}