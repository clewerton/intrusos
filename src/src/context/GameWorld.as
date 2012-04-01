package context
{
	import engine.CommandProcessor;
	import engine.GameApp;
	import engine.GameContext;
	import engine.InputManager;
	import entidade.Convoy;
	import entidade.Tower;
	import entidade.Vehicle;
	import evento.DestroyableEvent;
	import evento.EdgeEvent;
	import evento.EventChannel;
	import evento.PathEvent;
	import flash.geom.ColorTransform;
	import flash.ui.Keyboard;
	import grafo.DirectedGraph;
	import grafo.Edge;
	import grafo.Path;
	import grafo.PathWalker;
	import entidade.Bullet;
	import entidade.DestroyableObject;
	import entidade.StandardTruck;
	import entidade.StandardTower;
	
	/**
	 * ...
	 * @author Clewerton Coelho
	 */
	public class GameWorld extends GameContext
	{
		
		private var _vehicleScoreHUD:HudValue;
		private var _vehicleHealthHUD:HudValue;
		
		private var _towers:Vector.<Tower> = new Vector.<Tower>;
		private var _convoy:Convoy;
		private var _bullets:Vector.<Bullet> = new Vector.<Bullet>;
		
		private var _graph:DirectedGraph;
		
		// Para o jogo, 1 caminho só basta
		private var _path:Path;
		
		// Processador de comandos
		private var _commandProcessor:CommandProcessor;
		
		public function GameWorld(gameApp:GameApp, id:String)
		{
			super(gameApp, id);
			
			// Create graph:
			_graph = _graph = new Level1GraphCreator().getGraph();
			addGameObject(_graph);
			
			// Create path:
			_path = new Path(_graph, _graph.getNodeAt(0), true, true);
			_path.addEventListener(EventChannel.EDGE_ADDED, edgeAdded, false, 0, true);
			_path.addEventListener(EventChannel.EDGE_REMOVED, edgeRemoved, false, 0, true);
			addGameObject(_path);
			
			// Create inputManager:
			inputManager.addCommandMapping(Keyboard.E, "START_WALKING");
			inputManager.addCommandMapping(Keyboard.R, "RESET_WALKING");
			inputManager.addCommandMapping(Keyboard.Q, "STOP_WALKING");

			
			// Create commandProcessor
			_commandProcessor = new CommandProcessor();
			
			_commandProcessor.addCommand("START_WALKING", function() {
				if (_path.edges.length > 0) {
					_convoy.active = true;
					_convoy.visible = true;
					EventChannel.getInstance().addEventListener(EventChannel.EDGE_VISITED, showEdge, false, 0, true);
					_path.startWalking();
				}});
			_commandProcessor.addCommand("RESET_WALKING", function() {_path.resetWalking();});
			_commandProcessor.addCommand("STOP_WALKING", function() {_path.stopWalking();});

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
			addGameObject(truck);
			
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
			_commandProcessor.process(inputManager.commands);
			checkColisions();
			super.update();
		}
		
		public function addTower(tower:Tower):void
		{
			_towers.push(tower);
			addGameObject(tower);
		}
		
		public function removeTower(tower:Tower):void
		{
			_towers.splice(_towers.indexOf(tower), 1);
			removeGameObject(tower);
		}
		
		public function addVehicle(vehicle:Vehicle):void
		{
			_convoy.addVehicle(vehicle);
			addGameObject(vehicle);
		}
		
		public function removeVehicle(vehicle:Vehicle):void
		{
			_convoy.removeVehicle(vehicle);
			removeGameObject(vehicle);
		}
		
		public function addBullet(bullet:Bullet):void
		{
			_bullets.push(bullet);
			addGameObject(bullet);
		}
		
		public function removeBullet(bullet:Bullet):void
		{
			_bullets.splice(_bullets.indexOf(bullet), 1);
			removeGameObject(bullet);
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
				addGameObject(vehicle);
			}
		}
		
		public override function dispose():void
		{
			_path = null;
			_graph = null;
			_convoy = null;
			_vehicleScoreHUD = null;
			_vehicleHealthHUD = null;
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
			addGameObject(_vehicleScoreHUD);
			
			_vehicleHealthHUD = new HudValue(_convoy.vehicles[0].health);
			_vehicleHealthHUD.x = 760;
			_vehicleHealthHUD.y = 570;
			addGameObject(_vehicleHealthHUD);
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