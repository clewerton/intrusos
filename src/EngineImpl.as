package {
	
	import entidade.*;
	import evento.*;
	import flash.display.Stage;
	import grafo.*;
	import flash.geom.ColorTransform;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import flash.display.Bitmap;
	import terrain.Soil2;
	
	/**
	 * ...
	 * @author ...
	 */
	public class EngineImpl extends Engine 
	{
		private var _vehicleScoreHUD:HudValue;
		private var _vehicleHealthHUD:HudValue;
		
		public function EngineImpl(stageRef:Stage) {
			super(stageRef);
			
			//createTerreno();
			createGraph();
			createPath();
			createVehicles();
			createMap();
			createWorld();
			createTowers();
			setHUD();
			
			stageRef.addEventListener(KeyboardEvent.KEY_DOWN, handleKeyboard, false, 0, true);
			
		}

		private function handleKeyboard(event:KeyboardEvent):void {
			switch (event.keyCode) {
				case Keyboard.E:
					if (path.edges.length > 0) {
						truck.visible = true;
						EventChannel.getInstance().addEventListener(EventChannel.EDGE_VISITED, showEdge, false, 0 , true);
						pathWalker.start();
					}
				break;
				case Keyboard.R:
					pathWalker.reset();
				break;
				case Keyboard.Q:
					pathWalker.stop();
				break;
			}
		}

		private function showEdge(event:EdgeEvent):void {
			trace("Edge: " + event.edge.name);
		}

		private function setHUD():void {
		
			_vehicleScoreHUD = new HudValue();
			_vehicleScoreHUD.x = 40;
			_vehicleScoreHUD.y = 570;
			stageRef.addChild(_vehicleScoreHUD);
			
			_vehicleHealthHUD = new HudValue(truck.health);
			_vehicleHealthHUD.x = 760;
			_vehicleHealthHUD.y = 570;
			stageRef.addChild(_vehicleHealthHUD);
		}
		
		private function createGraph(): void {
			graph = new Level1GraphCreator(stageRef).getGraph();
		}
		
		private function createPath():void {
			path = new Path(graph.getNodeAt(0), true, true);
			path.addEventListener(EventChannel.EDGE_ADDED, edgeAdded, false, 0, true);
			path.addEventListener(EventChannel.EDGE_REMOVED, edgeRemoved, false, 0, true);
		}
		
		private function edgeAdded(e:PathEvent):void {
			var theEdge:Edge = e.edge;
			var myColor:ColorTransform = theEdge.transform.colorTransform;
			myColor.color = 0x00FFFF;
			theEdge.transform.colorTransform = myColor;
			//trace(theEdge.name);
		}
		
		private function edgeRemoved(e:PathEvent):void {
			var theEdge:Edge = e.edge;
			var myColor:ColorTransform = theEdge.transform.colorTransform;
			myColor.color = 0x00FF00;
			theEdge.transform.colorTransform = myColor;
			//trace(theEdge.name);
		}
		
		private function createVehicles():void {
			truck = new StandardTruck();
			truck.engine = this;
			truck.x = 500;
			truck.y = 500;
			truck.visible = false;
			truck.addEventListener(EventChannel.OBJECT_DESTROYED, destroyVehicle, false, 0, true);
			truck.addEventListener(EventChannel.OBJECT_HIT, adjustHealthHUD, false, 0, true);
		}
		
		private function createTowers():void {
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
		
		private function destroyTower(e:DestroyableEvent):void {
			var tower:Tower = e.gameObject as Tower;
			world.removeTower(tower);
			tower.active = false;
			_vehicleScoreHUD.score += tower.scoreValue();
		}
		
		private function destroyVehicle(e:DestroyableEvent):void {
			var vehicle:Vehicle = e.gameObject as Vehicle;
			world.removeVehicle(vehicle);
			vehicle.active = false;
		}

		private function adjustHealthHUD(e:DestroyableEvent):void  {
			var vehicle:Vehicle = e.gameObject as Vehicle;
			_vehicleHealthHUD.score = truck.health;
		}
		
		private function createMap(): void {
			map = new Map(stageRef, graph, path);
			pathWalker = new PathWalker(stageRef, path, truck);
			map.addPathWalker(pathWalker);
			stageRef.addChild(map);
			map.scaleX = 2;
			map.scaleY = 2;
		}

		private function createWorld():void {
			world = new GameWorld(stageRef, map);
			world.addVehicle(truck);
		}
		
		private function createTerreno():void {
			var terreno:Bitmap = new Bitmap(new Soil2());
			stageRef.addChild(terreno);
		}
		
	}

}