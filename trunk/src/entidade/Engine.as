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
	/**
	 * ...
	 * @author ...
	 */
	public class Engine 
	{
		private var _stageRef:Stage;
		private var _world:GameWorld;
		private var _map:Map;
		private var _path:Path;
		private var _graph:DirectedGraph;
		private	var _truck:Vehicle;
		private	var _pathWalker:PathWalker;
		
		public function Engine(stageRef:Stage) {
			_stageRef = stageRef;
		}
		
		protected function get stageRef():Stage {
			return _stageRef;
		}
		
		protected function get world():GameWorld {
			return _world;
		}
		
		protected function set world(value:GameWorld):void {
			_world = value;
		}
		
		protected function get map():Map {
			return _map;
		}
		
		protected function set map(value:Map):void {
			_map = value;
		}
		
		protected function get graph():DirectedGraph {
			return _graph;
		}
		
		protected function set graph(value:DirectedGraph):void {
			_graph = value;
		}
		
		public function get truck():Vehicle {
			return _truck;
		}
		
		public function set truck(value:Vehicle):void  {
			_truck = value;
		}
		
		public function get path():Path {
			return _path;
		}
		
		public function set path(value:Path):void {
			_path = value;
		}
		
		protected function addVehicle(vehicle:Vehicle):void {
			_world.addVehicle(vehicle);
		}
		
		protected function addTower(tower:Tower):void {
			_world.addTower(tower);
		}
		
		protected function addPathWalker(pathWalker:PathWalker):void {
			_map.addPathWalker(pathWalker);
		}
		
	}

}