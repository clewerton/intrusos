package evento {
	
	import flash.events.EventDispatcher;
	import utils.MultiMap;
	
	public class EventChannel extends EventDispatcher {

		private static var _instance:EventChannel;
		
		public static const EDGE_CLICKED:String			= "EdgeEvent:EdgeClicked";
		public static const EDGE_ADDED:String 			= "PathEvent:EdgeAdded";
		public static const EDGE_REMOVED:String 		= "PathEvent:EdgeRemoved";
		public static const EDGE_VISITED:String 		= "PathEvent:EdgeVisited";

		public static const PATH_FINISHED:String		= "PathEvent:PathFiished";

		public static const OBJECT_HIT:String 			= "DestroyableEvent:ObjectHit";
		public static const OBJECT_DESTROYED:String 	= "DestroyableEvent:ObjectDestroyed";
		public static const TOWER_DESTROYED:String 		= "DestroyableEvent:TowerDestroyed";
		public static const VEHICLE_DESTROYED:String 	= "DestroyableEvent:VehicleDestroyed";

		public static const CREATE_BULLET:String 		= "BulletEvent:CreateBullet";
		public static const BULLET_CREATED:String 		= "BulletEvent:BulletCreated";
		
		public function EventChannel() {
			throw new Error("Construtor abstrato!!");
		}
		
		public static function getInstance():EventChannel {
			if (_instance == null) {
				_instance = new EventChannel();
			}
			return _instance;
		}
	}
	
}
