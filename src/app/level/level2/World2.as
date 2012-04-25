package src.app.level.level2
{
	import lib.graph.DirectedGraph;
	import lib.graph.Node;
	import src.app.BaseWorld;
	import src.app.GameLevel;
	import src.entidade.BigTower;
	import src.entidade.Bullet;
	import src.entidade.DestroyableObject;
	import src.entidade.StandardTower;
	import src.entidade.Tower;
	import src.entidade.Vehicle;
	import src.evento.DestroyableEvent;
	import src.evento.EventChannel;
	import flash.events.Event;
	import flash.display.Shape;
	import src.entidade.PowerUp;
	import src.entidade.EndurancePack;
	import src.entidade.HealthPack;

	/**
	 * ...
	 * @author Clewerton Coelho
	 * Mundo da fase 2
	 */
	public class World2 extends BaseWorld
	{
		private var _gameLevel:GameLevel;

		public function World2(gameLevel:GameLevel)
		{
			super();
			_gameLevel = gameLevel;
			
			mapLayer.scaleX = 2;
			mapLayer.scaleY = 2;
			
			// Create graph:
			var graph:DirectedGraph = new Level2GraphCreator().getGraph();
			var node:Node = graph.getNodeById(140);
			addGraph(graph, node);
			
			convoy.active = false;
			convoy.visible = false;

			createTowers();
			createPowerUps();
		}
		
		protected override function onAddedToStage(ev:Event = null):void {
			super.onAddedToStage(ev);
			var background:Shape = new Shape();
			background.graphics.beginFill(0x663300, 0.3);
			background.graphics.drawRect(0, 0, stage.stageWidth, stage.stageHeight);
			background.graphics.endFill();
			addChildAt(background, 0);
			
			// Rolar o mapa para posicionar no local do ponto de partida
			scroll(400, 900);
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
			configureTower(new StandardTower(this), 660, 180);
			configureTower(new StandardTower(this), 540, 435);
			configureTower(new StandardTower(this), 725, 500);
			configureTower(new StandardTower(this), 990, 620);
			configureTower(new StandardTower(this), 660, 690);
			configureTower(new StandardTower(this), 540, 955);
			configureTower(new StandardTower(this), 470, 620);
			configureTower(new StandardTower(this), 200, 510);
			configureTower(new StandardTower(this), 930, 435);
			configureTower(new StandardTower(this), 800, 700);
			configureTower(new StandardTower(this), 735, 880);
			configureTower(new StandardTower(this), 470, 770);
			configureTower(new StandardTower(this), 400, 420);
			configureTower(new StandardTower(this), 300, 715);
			configureTower(new StandardTower(this), 740, 370);
			configureTower(new StandardTower(this), 470, 260);
			configureTower(new BigTower(this), 865, 570);
			configureTower(new BigTower(this), 350, 570);
			configureTower(new BigTower(this), 610, 315);
			configureTower(new BigTower(this), 610, 830);
		}
		
		private function createPowerUps():void
		{
			configurePowerUp(new HealthPack(this), 350, 830);
			configurePowerUp(new HealthPack(this), 865, 830);
			configurePowerUp(new HealthPack(this), 865, 315);
			configurePowerUp(new HealthPack(this), 350, 320);
			configurePowerUp(new HealthPack(this), 610, 570);
			
			configurePowerUp(new EndurancePack(this), 610, 940);
			configurePowerUp(new EndurancePack(this), 715, 830);
			configurePowerUp(new EndurancePack(this), 610, 720);
			configurePowerUp(new EndurancePack(this), 500, 830);
			
			configurePowerUp(new EndurancePack(this), 865, 680);
			configurePowerUp(new EndurancePack(this), 970, 570);
			configurePowerUp(new EndurancePack(this), 865, 460);
			configurePowerUp(new EndurancePack(this), 755, 570);

			configurePowerUp(new EndurancePack(this), 715, 315);
			configurePowerUp(new EndurancePack(this), 610, 210);
			configurePowerUp(new EndurancePack(this), 500, 320);
			configurePowerUp(new EndurancePack(this), 610, 425);

			configurePowerUp(new EndurancePack(this), 460, 570);
			configurePowerUp(new EndurancePack(this), 350, 455);
			configurePowerUp(new EndurancePack(this), 240, 570);
			configurePowerUp(new EndurancePack(this), 350, 680);
			
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
		
		private function configureTower(tower:Tower, px:int, py:int):void {
			tower.x = px;
			tower.y = py;
			addTower(tower);
			tower.addEventListener(EventChannel.OBJECT_DESTROYED, destroyTower, false, 0, true);
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
		
		private function destroyTower(e:DestroyableEvent):void
		{
			var tower:Tower = e.gameObject as Tower;
			tower.active = false;
			removeTower(tower);
			vehicleScoreHUD.score += tower.scoreValue();
			tower.dispose();
			tower = null;
			if (numberOfTowers == 0) {
				trace("VICTORY");
				_gameLevel.activeState = GameLevel.SUCCEDED;
			}
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
	}
	
}