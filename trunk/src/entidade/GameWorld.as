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
	import engine.GameApp;
	
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
		//private var _bullets:Vector.<Bullet>;
		
		private var _graph:DirectedGraph;
		
		// Layers
		private var _mapLayer:GameContainer;
		private var _hudLayer:GameContainer;
		
		private var _gameApp:GameApp;
		
		public function GameWorld(gameApp:GameApp)
		{
			super();
			
			_gameApp = gameApp;
			_towers = new Vector.<Tower>;
			//_bullets = new Vector.<Bullet>;
			_mapLayer = new GameContainer();
			_hudLayer = new GameContainer();

			addGameObject(_mapLayer);
			addGameObject(_hudLayer);
			
			_mapLayer.scaleX = 2;
			_mapLayer.scaleY = 2;
			
			// Create graph:
			_graph = _graph = new Level1GraphCreator().getGraph();
			_mapLayer.addGameObject(_graph);
			
			// Create convoy:
			_convoy = new Convoy(_graph, _graph.getNodeAt(0), true, true);
			_mapLayer.addGameObject(_convoy);
			
			var truck:Vehicle = new StandardTruck(this);
			truck.addEventListener(EventChannel.OBJECT_DESTROYED, destroyVehicle, false, 0, true);
			//truck.addEventListener(EventChannel.OBJECT_HIT, adjustHealthHUD, false, 0, true);
			_convoy.addVehicle(truck);

			truck = new StandardTruck(this);
			truck.addEventListener(EventChannel.OBJECT_DESTROYED, destroyVehicle, false, 0, true);
			//truck.addEventListener(EventChannel.OBJECT_HIT, adjustHealthHUD, false, 0, true);
			_convoy.addVehicle(truck);
			
			_convoy.active = false;
			_convoy.visible = false;
		
			createTowers();
			setHUD();
		}
		
		public override function update():void
		{
			super.update();
			checkColisions();
		}
		
		public function startWalkingPath():void {
			_convoy.startWalkingPath();
		}

		public function resetWalkingPath():void {
			_convoy.resetWalking();
		}

		public function stopWalkingPath():void {
			_convoy.stopWalking();
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
		}
		
		public function removeVehicle(vehicle:Vehicle):void
		{
			_convoy.removeVehicle(vehicle);
		}
		
		public function addBullet(bullet:Bullet):void
		{
			//_bullets.push(bullet);
			_mapLayer.addGameObject(bullet);
		}
		
		public function removeBullet(bullet:Bullet):void
		{
			//_bullets.splice(_bullets.indexOf(bullet), 1);
			_mapLayer.removeGameObject(bullet);
		}
		
		protected function checkColisions():void
		{
			for (var indexTowers:uint = 0; indexTowers < _towers.length; indexTowers++) {
				for (var indexVehicles:uint = 0; indexVehicles < convoy.vehicles.length; indexVehicles++) {
					if (convoy.vehicles[indexVehicles].range.hitTestObject(_towers[indexTowers].hitRegion) && convoy.vehicles[indexVehicles].enemy == null) {
						convoy.vehicles[indexVehicles].enemy = _towers[indexTowers];
					}
					if (_towers[indexTowers].range.hitTestObject(convoy.vehicles[indexVehicles].hitRegion) && _towers[indexTowers].enemy == null) {
						_towers[indexTowers].enemy = convoy.vehicles[indexVehicles];
					}
				}
			}
		}
		
		public function get convoy():Convoy
		{
			return _convoy;
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
			if (!bullet is Bullet) {
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
			bullet.active = false;
			removeBullet(bullet);
			bullet = null;
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
			tower.active = false;
			removeTower(tower);
			_vehicleScoreHUD.score += tower.scoreValue();
			tower = null;
		}
		
		private function destroyVehicle(e:DestroyableEvent):void
		{
			var vehicle:Vehicle = e.gameObject as Vehicle;
			adjustHealthHUD(e);
			removeVehicle(vehicle);
			vehicle.active = false;
			_gameApp.activeState = Main.GAME_OVER;
			
		}
		
		private function adjustHealthHUD(e:DestroyableEvent):void
		{
			var vehicle:Vehicle = e.gameObject as Vehicle;
			_vehicleHealthHUD.score = _convoy.vehicles[0].health;
		}
		
	}

}