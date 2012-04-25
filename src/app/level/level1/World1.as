package src.app.level.level1
{
	import flash.display.Shape;
	import flash.events.Event;
	import lib.graph.DirectedGraph;
	import lib.graph.Node;
	import src.app.BaseWorld;
	import src.app.GameLevel;
	import src.entidade.BigTower;
	import src.entidade.Bullet;
	import src.entidade.DestroyableObject;
	import src.entidade.EndurancePack;
	import src.entidade.HealthPack;
	import src.entidade.PowerUp;
	import src.entidade.StandardTower;
	import src.entidade.Tower;
	import src.entidade.Vehicle;
	import src.evento.DestroyableEvent;
	import src.evento.EventChannel;

	/**
	 * ...
	 * @author Clewerton Coelho
	 * Mundo da fase 1
	 */
	public class World1 extends BaseWorld
	{
		private var _gameLevel:GameLevel;

		public function World1(gameLevel:GameLevel)
		{
			super();
			_gameLevel = gameLevel;
			
			mapLayer.scaleX = 2;
			mapLayer.scaleY = 2;
			
			// Create graph:
			var graph:DirectedGraph = new Level1GraphCreator().getGraph();
			var node:Node = graph.getNodeById(0);
			addGraph(graph, node);
			
			convoy.active = false;
			convoy.visible = false;
		
			createTowers();
			createPowerUps();
		}
		
		protected override function onAddedToStage(ev:Event = null):void {
			super.onAddedToStage(ev);
			var background:Shape = new Shape();
			background.graphics.beginFill(0x777777);
			background.graphics.drawRect(0, 0, stage.stageWidth, stage.stageHeight);
			background.graphics.endFill();
			addChildAt(background, 0);
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
			configureTower(new StandardTower(this), 170, 325);
			configureTower(new StandardTower(this), 170, 475);
			configureTower(new StandardTower(this), 335, 160);
			configureTower(new StandardTower(this), 450, 160);
			configureTower(new StandardTower(this), 350, 635);
			configureTower(new StandardTower(this), 635, 160);
			configureTower(new StandardTower(this), 635, 350);
			configureTower(new StandardTower(this), 475, 635);
			configureTower(new StandardTower(this), 635, 475);
			configureTower(new BigTower(this), 625, 625);
			configureTower(new BigTower(this), 400, 400);
			configureTower(new StandardTower(this), 170, 630);
		}
		
		private function configureTower(tower:Tower, px:int, py:int):void {
			tower.x = px;
			tower.y = py;
			addTower(tower);
			tower.addEventListener(EventChannel.OBJECT_DESTROYED, destroyTower, false, 0, true);
		}
		
		private function destroyTower(e:DestroyableEvent):void
		{
			var tower:Tower = e.gameObject as Tower;
			tower.active = false;
			removeTower(tower);
			vehicleScoreHUD.score += tower.scoreValue();
			tower.dispose();
			tower = null;
			if (numberOfTowers == 0) {
				_gameLevel.activeState = GameLevel.SUCCEDED;
			}
		}
		
		public override function addVehicle(vehicle:Vehicle):void {
			super.addVehicle(vehicle);
			vehicle.addEventListener(EventChannel.OBJECT_HIT, hitVehicle, false, 0, true);
			vehicle.addEventListener(EventChannel.OBJECT_DESTROYED, destroyVehicle, false, 0, true);
		}
		
		private function hitVehicle(e:DestroyableEvent):void
		{
			var vehicle:Vehicle = e.gameObject as Vehicle;
			setVehicleHealthHUDValue(vehicle.index, vehicle.health);
			
		}

		private function destroyVehicle(e:DestroyableEvent):void
		{
			var vehicle:Vehicle = e.gameObject as Vehicle;
			setVehicleHealthHUDValue(vehicle.index, 0);
			removeVehicle(vehicle);
			vehicle.active = false;
			vehicle = null;
			if (convoy.size == 0) {
				_gameLevel.activeState = GameLevel.FAILED;
			}
		}
		
		private function createPowerUps():void
		{
			configurePowerUp(new HealthPack(this), 300, 500);
			configurePowerUp(new HealthPack(this), 700, 300);
			configurePowerUp(new HealthPack(this), 100, 400);
			configurePowerUp(new HealthPack(this), 550, 550);
			configurePowerUp(new EndurancePack(this), 400, 100);
			configurePowerUp(new EndurancePack(this), 700, 700);
			configurePowerUp(new EndurancePack(this), 400, 700);
			configurePowerUp(new EndurancePack(this), 500, 300);
		}
		
		private function configurePowerUp(powerUp:PowerUp, px:int, py:int):void {
			addPowerUp(powerUp);
			powerUp.x = px;
			powerUp.y = py;
			powerUp.addEventListener(EventChannel.OBJECT_DESTROYED, destroyPowerUp, false, 0, true);
		}
		
		private function destroyPowerUp(e:DestroyableEvent):void {
			var powerUp:PowerUp = e.gameObject as PowerUp;
			powerUp.active = false;
			removePowerUp(powerUp);
		}
	}
	
}