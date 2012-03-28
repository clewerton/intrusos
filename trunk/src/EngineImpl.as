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
	import tela.MenuItem;
	import terrain.Soil2;
	import flash.events.Event;
	import engine.GameApp;
	
	/**
	 * ...
	 * @author ...
	 */
	public class EngineImpl extends GameApp
	{
		private var _path:Path;
		private var _graph:DirectedGraph;
		private var _convoy:Convoy;
		private var _vehicleScoreHUD:HudValue;
		private var _vehicleHealthHUD:HudValue;
		
		
		public function EngineImpl()
		{
		}

		public override function init():void {
			//createTerreno();
			createGraph();
			createPath();
			createConvoy();
			createWorld();
			createTowers();
			setHUD();
			
			stage.addEventListener(KeyboardEvent.KEY_DOWN, handleKeyboard, false, 0, true);
		}
		
		public override function update():void {
			super.update();			
		}
		
		public override function dispose():void {
			_path = null;
			_graph = null;
			_convoy = null;
			_vehicleScoreHUD = null;
			_vehicleHealthHUD = null;
		}

		private function handleKeyboard(event:KeyboardEvent):void
		{
			switch (event.keyCode)
			{
				case Keyboard.E: 
					if (_path.edges.length > 0) {
						_convoy.visible = true;
						EventChannel.getInstance().addEventListener(EventChannel.EDGE_VISITED, showEdge, false, 0, true);
						world.startWalking();
					}
					break;
				case Keyboard.R:
					world.resetWalking();
					break;
				case Keyboard.Q:
					world.stopWalking();
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
			stage.addChild(_vehicleScoreHUD);
			
			_vehicleHealthHUD = new HudValue(_convoy.vehicles[0].health);
			_vehicleHealthHUD.x = 760;
			_vehicleHealthHUD.y = 570;
			stage.addChild(_vehicleHealthHUD);
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
			world.addTower(tower);
		}
		
		public function getBullet(bulletClass:Class, sender:DestroyableObject, receiver:DestroyableObject):void
		{
			var bullet:Bullet = new bulletClass();
			bullet.enemy = receiver;
			bullet.x = sender.x;
			bullet.y = sender.y;
			world.addBullet(bullet);
			bullet.addEventListener(EventChannel.OBJECT_DESTROYED, destroyBullet, false, 0, true);
		}
		
		private function destroyBullet(e:DestroyableEvent):void
		{
			var bullet:Bullet = e.gameObject as Bullet;
			world.removeBullet(bullet);
			bullet.active = false;
		}
		
		private function createGraph():void
		{
			_graph = new Level1GraphCreator().getGraph();
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
			truck.x = 50;
			truck.y = 250;
			truck.visible = true;
			truck.addEventListener(EventChannel.OBJECT_DESTROYED, destroyVehicle, false, 0, true);
			truck.addEventListener(EventChannel.OBJECT_HIT, adjustHealthHUD, false, 0, true);
			_convoy.addVehicle(truck);

			var pathWalker:PathWalker = null;
			for each (var vehicle:Vehicle in _convoy.vehicles) {
				pathWalker = new PathWalker(_path, vehicle);
			}

		}
		
		private function createTowers():void
		{
			var torre:Tower = new StandardTower();
			torre.engine = this;
			torre.x = 75;
			torre.y = 75;
			world.addTower(torre);
			torre.addEventListener(EventChannel.OBJECT_DESTROYED, destroyTower, false, 0, true);
			
			torre = new StandardTower();
			torre.engine = this;
			torre.x = 225;
			torre.y = 225;
			world.addTower(torre);
			torre.addEventListener(EventChannel.OBJECT_DESTROYED, destroyTower, false, 0, true);
		}
		
		private function destroyTower(e:DestroyableEvent):void
		{
			var tower:Tower = e.gameObject as Tower;
			world.removeTower(tower);
			tower.active = false;
			_vehicleScoreHUD.score += tower.scoreValue();
		}
		
		private function destroyVehicle(e:DestroyableEvent):void
		{
			var vehicle:Vehicle = e.gameObject as Vehicle;
			adjustHealthHUD(e);
			world.removeVehicle(vehicle);
			vehicle.active = false;
		}
		
		private function adjustHealthHUD(e:DestroyableEvent):void
		{
			var vehicle:Vehicle = e.gameObject as Vehicle;
			_vehicleHealthHUD.score = _convoy.vehicles[0].health;
		}
		
		private function createWorld():void
		{
			world = new InstrusosWorld(_graph, _path);
			world.convoy = _convoy;
			
			stage.addChild(world);
			world.scaleX = 2;
			world.scaleY = 2;
			
		}
		
		private function createTerreno():void
		{
			var terreno:Bitmap = new Bitmap(new Soil2());
			stage.addChild(terreno);
		}
		
	}

}