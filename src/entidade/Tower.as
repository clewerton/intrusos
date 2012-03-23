﻿package entidade {
	
	import evento.DestroyableEvent;
	import evento.EventChannel;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import evento.BulletEvent;
	
	public class Tower extends GameObject {

		private var _radius:uint;
		private var _enemy:Vehicle;
		private var _states:Array;
		private var _range:Shape;
		private var _timer:Timer;
		private var _canShoot:Boolean = false;

		public function Tower(health:uint, radius:uint) {
			super(health);
			_radius = radius;
			
			_range = new Shape();
			_range.graphics.beginFill(0xAAAAAA, 0.4);
			_range.graphics.drawCircle(x, y, _radius);
			_range.graphics.endFill();
			addChild(_range);
			_timer = new Timer(2000);
			_timer.addEventListener(TimerEvent.TIMER, enableShooting, false, 0, true);
		}
		
		public function get radius():uint {
			return _radius;
		}
		
		public function set radius(valor:uint):void {
			_radius = valor;
		}
		
		public function get enemy():Vehicle {
			return _enemy;
		}
		
		public function set enemy(valor:Vehicle):void {
			_enemy = valor;
		}
		
		public function get range():Shape {
			return _range;
		}

		public function update():void {
			if (!active || !_enemy) {
				return;
			}
			if (_range.hitTestObject(_enemy.hitRegion)) {
				if (_canShoot) {
					
					//EventChannel.getInstance().dispatchEvent(new BulletEvent(EventChannel.CREATE_BULLET, this));
				}
				_enemy.decreaseHealth(1);
				trace("Tower " + this.name + ":" + health);
				if(!_enemy.isAlive()) {
					_enemy = null;
				}
			} 
			else {
				_enemy = null;
			}
		}
		
		public function scoreValue():uint {
			throw Error("O metodo scoreValue da subclasse de Tower nao foi sobrescrito!");
		}
		
		private function enableShooting(e:TimerEvent):void {
			_canShoot = true;
		}
		
	}
	
}
