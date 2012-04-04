package level.level1
{
	import engine.GameApp;
	import engine.GameContainer;
	import entidade.BaseWorld;
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
	public class World1 extends BaseWorld
	{
		private var _gameApp;
		
		public function World1(gameApp:GameApp)
		{
			super();

			_gameApp = gameApp;
			
			mapLayer.scaleX = 2;
			mapLayer.scaleY = 2;
			
			// Create graph:
			var graph:DirectedGraph = new Level1GraphCreator().getGraph();
			var node:Node = graph.getNodeAt(0);
			addGraph(graph, node);
			
			convoy.addVehicle(new StandardTruck(this));
			convoy.addVehicle(new StandardTruck(this));
			convoy.active = false;
			convoy.visible = false;
		
			createTowers();
		}
		
		public override function newBullet(bulletClass:Class, sender:DestroyableObject, receiver:DestroyableObject):Bullet
		{
			var bullet:Bullet = super.newBullet(bulletClass, sender, receiver);
			bullet.addEventListener(EventChannel.OBJECT_DESTROYED, destroyBullet, false, 0, true);
			return bullet;
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
			vehicleScoreHUD.score += tower.scoreValue();
			tower = null;
			if (numberOfTowers == 0) {
				_gameApp.activeState = Main.LEVEL_COMPLETE;
			}
		}
		
		private function destroyVehicle(e:DestroyableEvent):void
		{
			var vehicle:Vehicle = e.gameObject as Vehicle;
			adjustHealthHUD(e);
			removeVehicle(vehicle);
			vehicle.active = false;
			if (convoy.size == 0) {
				_gameApp.activeState = Main.GAME_OVER;
			}
		}
		
		private function adjustHealthHUD(e:DestroyableEvent):void
		{
			var vehicle:Vehicle = e.gameObject as Vehicle;
			vehicleHealthHUD.score = convoy.vehicles[0].health;
		}
		
	}

}