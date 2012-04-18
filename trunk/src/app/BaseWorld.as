package src.app
{
	import flash.geom.Rectangle;
	import lib.engine.GameContainer;
	import lib.graph.DirectedGraph;
	import lib.graph.Node;
	import src.entidade.Bullet;
	import src.entidade.Convoy;
	import src.entidade.DestroyableObject;
	import src.entidade.Tower;
	import src.entidade.Vehicle;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Clewerton Coelho
	 */
	public class BaseWorld extends GameContainer
	{
		private static const MAX_VEHICLES:uint = 4;
		
		private var _vehicleScoreHUD:HudValue;
		
		// indicador de HP de cada veículo
		private var _vehicleHealthHUD:Vector.<HudValue>;
		
		private var _towers:Vector.<Tower>;
		private var _convoy:Convoy;
		//private var _bullets:Vector.<Bullet>;
		
		//Grafo com os possíveis caminhos a serem percorridos
		private var _graph:DirectedGraph;
		
		// Layer do ambiente do jogo
		private var _mapLayer:GameContainer;
		// Layer do HUD do jogo
		private var _hudLayer:GameContainer;
		
		public function BaseWorld()
		{
			super();
			
			_vehicleHealthHUD = new Vector.<HudValue>();
			_towers = new Vector.<Tower>;
			//_bullets = new Vector.<Bullet>;
			_mapLayer = new GameContainer();
			_hudLayer = new GameContainer();

			addGameObject(_mapLayer);
			addGameObject(_hudLayer);
			setHUD();
		}

		protected override function onAddedToStage(ev:Event = null):void {
			super.onAddedToStage(ev);
			_mapLayer.scrollRect = new Rectangle(0, 0, stage.stageWidth, stage.stageHeight);
			enter();
		}

		function enter():void {
			stage.focus = _mapLayer;
			stage.stageFocusRect = false;
		}

		public override function update():void {
			super.update();
			checkColisions();
		}
		
		public function startWalkingPath():void {
			_convoy.active = true;
			_convoy.startWalkingPath();
		}

		/*public function resetWalkingPath():void {
			_convoy.resetWalking();
		}*/

		public function stopWalkingPath():void {
			_convoy.active = false;
			_convoy.stopWalking();
		}

		public function addGraph(graph:DirectedGraph, sourceNode:Node):void {
			_graph = graph;
			_mapLayer.addGameObject(_graph);
			
			// Create convoy:
			_convoy = new Convoy(_graph, sourceNode, true, true);
			_convoy.active = false;
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
			if (_convoy.size < MAX_VEHICLES) {
				_convoy.addVehicle(vehicle);
				
				_vehicleHealthHUD[_convoy.size - 1] = new HudValue(vehicle.health, 0xFFFF00);
				_vehicleHealthHUD[_convoy.size - 1].x = 40 + (_convoy.size - 1) * 100;
				_vehicleHealthHUD[_convoy.size - 1].y = 40;
				_hudLayer.addGameObject(_vehicleHealthHUD[_convoy.size - 1]);
			}
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
				for (var indexVehicles:uint = 0; indexVehicles < convoy.size; indexVehicles++) {
					var vehicle = convoy.getElement(indexVehicles) as Vehicle;
					if (vehicle.range.hitTestObject(_towers[indexTowers].hitRegion) && vehicle.enemy == null) {
						vehicle.enemy = _towers[indexTowers];
					}
					if (_towers[indexTowers].range.hitTestObject(vehicle.hitRegion) && _towers[indexTowers].enemy == null) {
						_towers[indexTowers].enemy = vehicle;
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
		
		/*public function getVehicleHealthHUD(index:uint):HudValue
		{
			return _vehicleHealthHUD[index];
		}*/
		
		public function setVehicleHealthHUDValue(index:uint, value:int):void 
		{
			_vehicleHealthHUD[index].score = value;
		}

		/*public function addVehicleHealthHUDValue(index:uint, value:int):void 
		{
			_vehicleHealthHUD[index] += value;
		}*/
		
		/*public function get vehicleHealthHUD():HudValue 
		{
			return _vehicleHealthHUD;
		}*/
		
		private function setHUD():void
		{
			_vehicleScoreHUD = new HudValue(0, 0x0000FF);
			_vehicleScoreHUD.x = 760;
			_vehicleScoreHUD.y = 570;
			_hudLayer.addGameObject(_vehicleScoreHUD);
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
		
		public function startedMoving():Boolean {
			return _convoy.startedMoving;
		}
		
		public function scroll(dx:int, dy:int):void {
			var newScrollRect:Rectangle = _mapLayer.scrollRect;
			newScrollRect.x += dx;
			newScrollRect.y += dy;
			_mapLayer.scrollRect = newScrollRect;
		}
		
	}

}