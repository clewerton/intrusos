package entidade 
{
	import entidade.GameWorld;
	import entidade.Tower;
	import entidade.Vehicle;
	import flash.display.Stage;
	import grafo.DirectedGraph;
	import grafo.Map;
	import grafo.Path;
	import grafo.PathWalker;
	import evento.DestroyableEvent;
	import evento.EventChannel;

	/**
	 * ...
	 * @author ...
	 */
	public class Engine {
		private var _stage:Stage;
		private var _world:GameWorld;
		private var _map:Map;
		private var _path:Path;
		private var _graph:DirectedGraph;
		private	var _truck:Vehicle;
		private	var _pathWalker:PathWalker;
		
		public function Engine(stageRef:Stage) {
			_stage = stageRef;
		}
		
		public function start():void {
			_world.start();
		}
		
		protected function get stageRef():Stage {
			return _stage;
		}
		
		protected function get world():GameWorld {
			return _world;
		}
		
		protected function set world(val:GameWorld):void {
			if (val != null) {
				_world = val;
			}
		}
		
		protected function get map():Map {
			return _map;
		}
		
		protected function set map(val:Map):void {
			if (val != null) {
				_map = val;
			}
		}
		
		protected function get graph():DirectedGraph {
			return _graph;
		}
		
		protected function set graph(val:DirectedGraph):void {
			if (val != null) {
				_graph = val;
			}
		}
		
		public function get truck():Vehicle {
			return _truck;
		}
		
		public function set truck(val:Vehicle):void  {
			if (val != null) {
				_truck = val;
			}
		}
		
		public function get path():Path {
			return _path;
		}
		
		public function set path(val:Path):void {
			if (val != null) {
				_path = val;
			}
		}
		
		protected function addVehicle(val:Vehicle):void {
			if (val != null) {
				_world.addVehicle(val);
			}
		}
		
		protected function addTower(tower:Tower):void {
			_world.addTower(tower);
		}
		
		/*protected function addPathWalker(pathWalker:PathWalker):void {
			_map.addPathWalker(pathWalker);
		}*/

		protected function set pathWalker(pW:PathWalker):void {
			_map.addPathWalker(pW);
			_pathWalker = pW;
		}
		
		protected function get pathWalker():PathWalker {
			return _pathWalker;
		}
		
		public function getBullet(bulletType:String, sender:GameObject, receiver:GameObject):void {
			var bullet:Bullet = BulletFactory.getInstance().getBullet(bulletType);
			bullet.enemy = receiver;
			bullet.x = sender.x;
			bullet.y = sender.y;
			_world.addBullet(bullet);
			bullet.addEventListener(EventChannel.OBJECT_DESTROYED, destroyBullet, false, 0, true);
		}

		private function destroyBullet(e:DestroyableEvent):void {
			var bullet:Bullet = e.gameObject as Bullet;
			_world.removeBullet(bullet);
			bullet.active = false;
		}
		
	}

}
