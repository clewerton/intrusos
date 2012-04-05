package entidade
{
	import engine.GameApp;
	import engine.GameContainer;
	import entidade.Bullet;
	import entidade.Convoy;
	import entidade.DestroyableObject;
	import entidade.StandardTower;
	import entidade.StandardTruck;
	import entidade.Tower;
	import entidade.Vehicle;
	import evento.DestroyableEvent;
	import evento.EventChannel;
	import grafo.DirectedGraph;
	import grafo.Node;
	
	/**
	 * ...
	 * @author Clewerton Coelho
	 */
	public class BaseWorld extends GameContainer
	{
		private var _vehicleScoreHUD:HudValue;
		//private var _vehicleHealthHUD:HudValue;
		
		private var _towers:Vector.<Tower>;
		private var _convoy:Convoy;
		//private var _bullets:Vector.<Bullet>;
		
		//Grafo com os possíveis caminhos a serem percorridos
		private var _graph:DirectedGraph;
		
		// Layer do ambiente do jogo
		private var _mapLayer:GameContainer;
		// Layer do HUD do jogo
		private var _hudLayer:GameContainer;
		
		
		// Referência à engine
		private var _gameApp;
		
		public function BaseWorld()
		{
			super();
			
			_towers = new Vector.<Tower>;
			//_bullets = new Vector.<Bullet>;
			_mapLayer = new GameContainer();
			_hudLayer = new GameContainer();

			addGameObject(_mapLayer);
			addGameObject(_hudLayer);
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

		public function addGraph(graph:DirectedGraph, sourceNode:Node):void {
			_graph = graph;
			_mapLayer.addGameObject(_graph);
			
			// Create convoy:
			_convoy = new Convoy(_graph, sourceNode, true, true);
			_mapLayer.addGameObject(_convoy);
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
		
		protected function get numberOfTowers():int {
			return _towers.length;
		}
		
		public function addVehicle(vehicle:Vehicle):void
		{
			_convoy.addVehicle(vehicle);
		}
		
		public function removeVehicle(vehicle:Vehicle):void
		{
			_convoy.removeVehicle(vehicle);
		}
		
		private function addBullet(bullet:Bullet):void
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
		
		public function get convoy():Convoy {
			return _convoy;
		}
		
		protected function get mapLayer():GameContainer {
			return _mapLayer;
		}
		
		public function get hudLayer():GameContainer {
			return _hudLayer;
		}
		
		public function get vehicleScoreHUD():HudValue 
		{
			return _vehicleScoreHUD;
		}
		
		/*public function get vehicleHealthHUD():HudValue 
		{
			return _vehicleHealthHUD;
		}*/
		
		private function setHUD():void
		{
			_vehicleScoreHUD = new HudValue();
			_vehicleScoreHUD.x = 40;
			_vehicleScoreHUD.y = 570;
			_hudLayer.addGameObject(_vehicleScoreHUD);
			
			//_vehicleHealthHUD = new HudValue(_convoy.vehicles[0].health);
			//_vehicleHealthHUD.x = 760;
			//_vehicleHealthHUD.y = 570;
			//_hudLayer.addGameObject(_vehicleHealthHUD);
		}
		
		public function newBullet(bulletClass:Class, sender:DestroyableObject, receiver:DestroyableObject):Bullet
		{
			var bullet:Bullet = new bulletClass(this);
			if (!bullet is Bullet) {
				trace("Type Error !!!!!!!");
			}
			bullet.enemy = receiver;
			bullet.x = sender.x;
			bullet.y = sender.y;
			addBullet(bullet);
			return bullet;
		}
		
	}

}