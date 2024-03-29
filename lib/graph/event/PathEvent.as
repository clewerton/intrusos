﻿package lib.graph.event {
	
	import flash.events.Event;
	import lib.graph.Edge;

	/**
	 *
	 * Representa eventos de Path.
	 *
	 */

	public class PathEvent extends Event {

		//public static const PATH_FINISHED:String	= "PathEvent:PathFiished";
		//public static const EDGE_ADDED:String 		= "PathEvent:EdgeAdded";
		//public static const EDGE_REMOVED:String 		= "PathEvent:EdgeRemoved";
		//public static const EDGE_VISITED:String 	= "PathEvent:EdgeVisited";

		private var _edge:Edge;

		public function PathEvent(type:String, theEdge:Edge, bubbles:Boolean=false, cancelable:Boolean=false) {
			super(type, bubbles, cancelable);
			_edge = theEdge;
		}

		public function get edge():Edge {
			return _edge;
		}

	}
}