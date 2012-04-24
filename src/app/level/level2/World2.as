﻿package src.app.level.level2
{
	import lib.graph.DirectedGraph;
	import lib.graph.Node;
	import src.app.BaseWorld;
	import src.app.GameLevel;
	import src.entidade.Bullet;
	import src.entidade.DestroyableObject;
	import src.entidade.StandardTower;
	import src.entidade.Tower;
	import src.entidade.Vehicle;
	import src.evento.DestroyableEvent;
	import src.evento.EventChannel;
	import flash.events.Event;
	import flash.display.Shape;

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
			var node:Node = graph.getNodeAt(0);
			addGraph(graph, node);
			
			convoy.active = false;
			convoy.visible = false;
		
			createTowers();
		}
		
		protected override function onAddedToStage(ev:Event = null):void {
			super.onAddedToStage(ev);
			var background:Shape = new Shape();
			background.graphics.beginFill(0x993300, 0.5);
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
			var torre:Tower = new StandardTower(this);
			torre.x = 75;
			torre.y = 75;
			addTower(torre);
			torre.addEventListener(EventChannel.OBJECT_DESTROYED, destroyTower, false, 0, true);

			torre = new StandardTower(this);
			torre.x = 225;
			torre.y = 125;
			addTower(torre);
			torre.addEventListener(EventChannel.OBJECT_DESTROYED, destroyTower, false, 0, true);

			torre = new StandardTower(this);
			torre.x = 225;
			torre.y = 225;
			addTower(torre);
			torre.addEventListener(EventChannel.OBJECT_DESTROYED, destroyTower, false, 0, true);
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