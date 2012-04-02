package entidade
{
	import engine.GameContainer;
	import entidade.Bullet;
	import entidade.Convoy;
	import entidade.DestroyableObject;
	import entidade.StandardTower;
	import entidade.StandardTruck;
	import entidade.Tower;
	import entidade.Vehicle;
	import evento.DestroyableEvent;
	import evento.EdgeEvent;
	import evento.EventChannel;
	import evento.PathEvent;
	import flash.geom.ColorTransform;
	import grafo.DirectedGraph;
	import grafo.Edge;
	import grafo.Path;
	import grafo.PathWalker;
	
	/**
	 * ...
	 * @author Clewerton Coelho
	 */
	public class GameWorld extends GameContainer
	{
		
		private var _vehicleScoreHUD:HudValue;
		private var _vehicleHealthHUD:HudValue;
		
		private var _towers:Vector.<Tower>;
		private var _convoy:Convoy;
		private var _bullets:Vector.<Bullet>;
		
		private var _graph:DirectedGraph;
		
		// Para o jogo, 1 caminho só basta
		private var _path:Path;
		
		// Layers
		private var _mapLayer:GameContainer;
		private var _hudLayer:GameContainer;
		
		public function GameWorld()
		{
			super();
			
			_towers = new Vector.<Tower>;
			_bullets = new Vector.<Bullet>;
			_mapLayer = new GameContainer();
			_hudLayer = new GameContainer();

			addGameObject(_mapLayer);
			addGameObject(_hudLayer);
			
			_mapLayer.scaleX = 2;
			_mapLayer.scaleY = 2;
			
			// Create graph:
			_graph = _graph = new Level1GraphCreator().getGraph();
			_mapLayer.addGameObject(_graph);
			
			// Create path:
			_path = new Path(_graph, _graph.getNodeAt(0), true, true);
			_path.addEventListener(EventChannel.EDGE_ADDED, edgeAdded, false, 0, true);
			_path.addEventListener(EventChannel.EDGE_REMOVED, edgeRemoved, false, 0, true);
			_mapLayer.addGameObject(_path);
			
			// Create convoy:
			_convoy = new Convoy();
			
			var truck:Vehicle = new StandardTruck(this);
			//truck.x = 500;
			//truck.y = 500;
			truck.addEventListener(EventChannel.OBJECT_DESTROYED, destroyVehicle, false, 0, true);
			truck.addEventListener(EventChannel.OBJECT_HIT, adjustHealthHUD, false, 0, true);
			_convoy.addVehicle(truck);
			_convoy.active = false;
			_convoy.visible = false;
			_mapLayer.addGameObject(truck);
			
			var pathWalker:PathWalker = null;
			for each (var vehicle:Vehicle in _convoy.vehicles)
			{
				pathWalker = new PathWalker(_path, vehicle);
			}
		
			createTowers();
			setHUD();
		}
		
		public override function update():void
		{
			super.update();
			/*if(!active) {
				return;
			}*/
			checkColisions();
		}
		
		public function startWalkingPath():void {
			if (_path.edges.length > 0) {
				_convoy.active = true;
				_convoy.visible = true;
				EventChannel.getInstance().addEventListener(EventChannel.EDGE_VISITED, showEdge, false, 0, true);
				_path.startWalking();
			}
		}

		public function resetWalkingPath():void {
			_path.resetWalking();
		}

		public function stopWalkingPath():void {
			_path.stopWalking();
		}

		private function showEdge(event:EdgeEvent):void
		{
			trace("Edge: " + event.edge.name);
		}
		
		public function addTower(tower:Tower):void
		{
			_towers.push(tower);
			_mapLayer.addGameObject(tower);
		}
		
		public function removeTower(tower:Tower):void
		{
			_towers.splice(_towers.indexOf(tower), 1);
			_mapLayer.removeGameObject(tower);
		}
		
		public function addVehicle(vehicle:Vehicle):void
		{
			_convoy.addVehicle(vehicle);
			_mapLayer.addGameObject(vehicle);
		}
		
		public function removeVehicle(vehicle:Vehicle):void
		{
			_convoy.removeVehicle(vehicle);
			_mapLayer.removeGameObject(vehicle);
		}
		
		public function addBullet(bullet:Bullet):void
		{
			_bullets.push(bullet);
			_mapLayer.addGameObject(bullet);
		}
		
		public function removeBullet(bullet:Bullet):void
		{
			_bullets.splice(_bullets.indexOf(bullet), 1);
			_mapLayer.removeGameObject(bullet);
		}
		
		protected function checkColisions():void
		{
			for (var indexTowers:uint = 0; indexTowers < _towers.length; indexTowers++)
			{
				for (var indexVehicles:uint = 0; indexVehicles < convoy.vehicles.length; indexVehicles++)
				{
					if (convoy.vehicles[indexVehicles].range.hitTestObject(_towers[indexTowers].hitRegion) && convoy.vehicles[indexVehicles].enemy == null)
					{
						convoy.vehicles[indexVehicles].enemy = _towers[indexTowers];
					}
					if (_towers[indexTowers].range.hitTestObject(convoy.vehicles[indexVehicles].hitRegion) && _towers[indexTowers].enemy == null)
					{
						_towers[indexTowers].enemy = convoy.vehicles[indexVehicles];
					}
				}
			}
		}
		
		public function get convoy():Convoy
		{
			return _convoy;
		}
		
		public function set convoy(value:Convoy):void
		{
			_convoy = value;
			for each (var vehicle:Vehicle in _convoy.vehicles)
			{
				_mapLayer.addGameObject(vehicle);
			}
		}
		
		public override function dispose():void
		{
			super.dispose();
			_path = null;
			_graph = null;
			_convoy = null;
			_vehicleScoreHUD = null;
			_vehicleHealthHUD = null;
		}
		
		private function setHUD():void
		{
			_vehicleScoreHUD = new HudValue();
			_vehicleScoreHUD.x = 40;
			_vehicleScoreHUD.y = 570;
			_hudLayer.addGameObject(_vehicleScoreHUD);
			
			_vehicleHealthHUD = new HudValue(_convoy.vehicles[0].health);
			_vehicleHealthHUD.x = 760;
			_vehicleHealthHUD.y = 570;
			_hudLayer.addGameObject(_vehicleHealthHUD);
		}
		
		public function getBullet(bulletClass:Class, sender:DestroyableObject, receiver:DestroyableObject):void
		{
			var bullet:Bullet = new bulletClass(this);
			if (!bullet is Bullet)
			{
				trace("Type Error !!!!!!!");
			}
			bullet.enemy = receiver;
			bullet.x = sender.x;
			bullet.y = sender.y;
			addBullet(bullet);
			bullet.addEventListener(EventChannel.OBJECT_DESTROYED, destroyBullet, false, 0, true);
		}
		
		private function destroyBullet(e:DestroyableEvent):void
		{
			var bullet:Bullet = e.gameObject as Bullet;
			removeBullet(bullet);
			bullet.active = false;
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
		
		private function createTowers():void
		{
			var torre:Tower = new StandardTower(this);
			torre.x = 75;
			torre.y = 75;
			addTower(torre);
			torre.addEventListener(EventChannel.OBJECT_DESTROYED, destroyTower, false, 0, true);
			
			torre = new StandardTower(this);
			torre.x = 225;
			torre.y = 225;
			addTower(torre);
			torre.addEventListener(EventChannel.OBJECT_DESTROYED, destroyTower, false, 0, true);
		}
		
		private function destroyTower(e:DestroyableEvent):void
		{
			var tower:Tower = e.gameObject as Tower;
			removeTower(tower);
			tower.active = false;
			_vehicleScoreHUD.score += tower.scoreValue();
		}
		
		private function destroyVehicle(e:DestroyableEvent):void
		{
			var vehicle:Vehicle = e.gameObject as Vehicle;
			adjustHealthHUD(e);
			removeVehicle(vehicle);
			vehicle.active = false;
		}
		
		private function adjustHealthHUD(e:DestroyableEvent):void
		{
			var vehicle:Vehicle = e.gameObject as Vehicle;
			_vehicleHealthHUD.score = _convoy.vehicles[0].health;
		}
		
	}

}