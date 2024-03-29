﻿package src.evento {
	
	import flash.events.EventDispatcher;
	
	/**
	 * ...
	 * @author Clewerton Coelho
	 * Dveria ser um canal de eventos, mas se limitou a definir constantes de eventos...
	 */
	
	public class EventChannel extends EventDispatcher {

		private static var _instance:EventChannel;
		
		public static const STATE_CHANGED:String			= "StateEvent:StateChanged";

		public static const NODE_ADDED:String 			= "DirectedGraph:NodeAdded";
		
		public static const EDGE_ADDED:String 			= "PathEvent:EdgeAdded";
		public static const EDGE_REMOVED:String 		= "PathEvent:EdgeRemoved";
		public static const EDGE_VISITED:String 		= "PathEvent:EdgeVisited";

		public static const PATH_FINISHED:String		= "PathEvent:PathFiished";

		public static const OBJECT_HIT:String 			= "DestroyableEvent:ObjectHit";
		public static const OBJECT_DESTROYED:String 	= "DestroyableEvent:ObjectDestroyed";
		public static const TOWER_DESTROYED:String 		= "DestroyableEvent:TowerDestroyed";
		public static const VEHICLE_DESTROYED:String 	= "DestroyableEvent:VehicleDestroyed";

		public static const BULLET_CREATED:String 		= "BulletEvent:BulletCreated";
		
		public static const CONVOY_SELECTED:String 		= "ConvoySelectedEvent:ConvoySelected";
		
		
		public function EventChannel() {}
		
		public static function getInstance():EventChannel {
			if (_instance == null) {
				_instance = new EventChannel();
			}
			return _instance;
		}
	}
	
}
