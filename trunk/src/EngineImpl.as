package
{
	
	import entidade.*;
	import evento.*;
	import flash.display.Stage;
	import grafo.*;
	import flash.geom.ColorTransform;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import flash.display.Bitmap;
	import entidade.Convoy;
	import terrain.Soil2;
	import entidade.Engine;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author ...
	 */
	public class EngineImpl extends Engine
	{
		private var _path:Path;
		private var _graph:DirectedGraph;
		private var _convoy:Convoy;
		private var _vehicleScoreHUD:HudValue;
		private var _vehicleHealthHUD:HudValue;
		
		
		public function EngineImpl(stageRef:Stage)
		{
			super(stageRef);
			
			//createTerreno();
			createGraph();
			createPath();
			createConvoy();
			createWorld();
			createTowers();
			setHUD();
			
			stageRef.addEventListener(KeyboardEvent.KEY_DOWN, handleKeyboard, false, 0, true);
		
		}
		
		private function handleKeyboard(event:KeyboardEvent):void
		{
			switch (event.keyCode)
			{
				case Keyboard.E: 
					if (_path.edges.length > 0) {
						_convoy.visible = true;
						EventChannel.getInstance().addEventListener(EventChannel.EDGE_VISITED, showEdge, false, 0, true);
						_world.start();
						/*for each (var pW:PathWalker in _world.pathWalkers) {
							pW.start();
						}*/
					}
					break;
				case Keyboard.R:
					_world.reset();
					/*for each (pW in _world.pathWalkers) {
						pW.reset();
					}*/
					break;
				case Keyboard.Q:
					_world.stop();
					/*for each (pW in _world.pathWalkers) {
						pW.stop();
					}*/
					break;
			}
		}
		
		private function showEdge(event:EdgeEvent):void
		{
			trace("Edge: " + event.edge.name);
		}
		
		private function setHUD():void
		{
			
			_vehicleScoreHUD = new HudValue();
			_vehicleScoreHUD.x = 40;
			_vehicleScoreHUD.y = 570;
			_stage.addChild(_vehicleScoreHUD);
			
			_vehicleHealthHUD = new HudValue(_convoy.vehicles[0].health);
			_vehicleHealthHUD.x = 760;
			_vehicleHealthHUD.y = 570;
			_stage.addChild(_vehicleHealthHUD);
		}
		
		protected function addVehicle(val:Vehicle):void
		{
			if (val != null)
			{
				_convoy.addVehicle(val);
			}
		}
		
		protected function addTower(tower:Tower):void
		{
			_world.addTower(tower);
		}
		
		public function getBullet(bulletClass:Class, sender:GameObject, receiver:GameObject):void
		{
			var bullet:Bullet = new bulletClass();
			bullet.enemy = receiver;
			bullet.x = sender.x;
			bullet.y = sender.y;
			_world.addBullet(bullet);
			bullet.addEventListener(EventChannel.OBJECT_DESTROYED, destroyBullet, false, 0, true);
		}
		
		private function destroyBullet(e:DestroyableEvent):void
		{
			var bullet:Bullet = e.gameObject as Bullet;
			_world.removeBullet(bullet);
			bullet.active = false;
		}
		
		private function createGraph():void
		{
			_graph = new Level1GraphCreator(_stage).getGraph();
		}
		
		private function createPath():void
		{
			_path = new Path(_graph, _graph.getNodeAt(0), true, true);
			_path.addEventListener(EventChannel.EDGE_ADDED, edgeAdded, false, 0, true);
			_path.addEventListener(EventChannel.EDGE_REMOVED, edgeRemoved, false, 0, true);
		}

		private function edgeAdded(e:PathEvent):void
		{
			var theEdge:Edge = e.edge;
			var myColor:ColorTransform = theEdge.transform.colorTransform;
			myColor.color = 0x00FFFF;
			theEdge.transform.colorTransform = myColor;
			//trace(theEdge.name);
		}
		
		private function edgeRemoved(e:PathEvent):void
		{
			var theEdge:Edge = e.edge;
			var myColor:ColorTransform = theEdge.transform.colorTransform;
			myColor.color = 0x00FF00;
			theEdge.transform.colorTransform = myColor;
			//trace(theEdge.name);
		}
		
		private function createConvoy():void
		{
			_convoy = new Convoy();
			
			var truck:Vehicle = new StandardTruck();
			truck.engine = this;
			truck.x = 1000;
			truck.y = 1000;
			truck.visible = false;
			truck.addEventListener(EventChannel.OBJECT_DESTROYED, destroyVehicle, false, 0, true);
			truck.addEventListener(EventChannel.OBJECT_HIT, adjustHealthHUD, false, 0, true);
			_convoy.addVehicle(truck);

			var pathWalker:PathWalker = null;
			for each (var vehicle:Vehicle in _convoy.vehicles) {
				pathWalker = new PathWalker(_stage, _path, vehicle);
			}

		}
		
		private function createTowers():void
		{
			var torre:Tower = new StandardTower();
			torre.engine = this;
			torre.x = 75;
			torre.y = 75;
			_world.addTower(torre);
			torre.addEventListener(EventChannel.OBJECT_DESTROYED, destroyTower, false, 0, true);
			
			torre = new StandardTower();
			torre.engine = this;
			torre.x = 225;
			torre.y = 225;
			_world.addTower(torre);
			torre.addEventListener(EventChannel.OBJECT_DESTROYED, destroyTower, false, 0, true);
		}
		
		private function destroyTower(e:DestroyableEvent):void
		{
			var tower:Tower = e.gameObject as Tower;
			_world.removeTower(tower);
			tower.active = false;
			_vehicleScoreHUD.score += tower.scoreValue();
		}
		
		private function destroyVehicle(e:DestroyableEvent):void
		{
			var vehicle:Vehicle = e.gameObject as Vehicle;
			adjustHealthHUD(e);
			_world.removeVehicle(vehicle);
			vehicle.active = false;
		}
		
		private function adjustHealthHUD(e:DestroyableEvent):void
		{
			var vehicle:Vehicle = e.gameObject as Vehicle;
			_vehicleHealthHUD.score = _convoy.vehicles[0].health;
		}
		
		private function createWorld():void
		{
			_world = new GameWorld(_stage, _graph, _path);
			_world.convoy = _convoy;
			
			/*(var pathWalker:PathWalker = null;
			
			for each (var vehicle:Vehicle in _convoy.vehicles)
			{
				pathWalker = new PathWalker(_stage, _path, vehicle);
				_world.addPathWalker(pathWalker);
			}*/
			_stage.addChild(_world);
			_world.scaleX = 2;
			_world.scaleY = 2;
			
		}
		
		private function createTerreno():void
		{
			var terreno:Bitmap = new Bitmap(new Soil2());
			_stage.addChild(terreno);
		}
		
	}

}