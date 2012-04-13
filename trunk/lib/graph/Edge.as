package lib.graph {
	
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import lib.engine.GameObject;
	import src.evento.EventChannel;
	import lib.utils.Utils;
	
	// A connection between 2 nodes.
	public class Edge extends GameObject {

		private var _target: Node;
		private var _source: Node;
		private var _modulus:Number = 0.0;
		private var _angle:Number;
		private var _marked:Boolean = false;
		
		public function connect(source: Node, target: Node):void {
			_source = source;
			_target = target;
			source.addOutEdge(this);
			target.addInEdge(this);
			x = _source.x;
			y = _source.y;
			_angle = Math.atan2(targetNode.y - sourceNode.y, targetNode.x - sourceNode.x);
		}

		public function disconnect():void {
			_source.removeOutEdge(this);
			_target.removeInEdge(this);
			_modulus = 0.0;
			_source = null;
			_target = null;
		}

		// ABSTRACT
		public function walk(node:DisplayObject, delta:uint):Number {
			return 0;
		}

		// Getters e setters
		public function get modulus():Number {
			return _modulus;
		}

		protected function setModulus(val:Number):void {
			_modulus = val;
		}

		public function getAngle():Number {
			return _angle;
		}
		
		// ABSTRACT
		public function getAngleAt(x:Number, y:Number):Number {
			return 0;
		}

		public function get targetNode(): Node {
			return _target;
		}

		public function set targetNode(val: Node): void {
			_target = val;
		}

		public function get sourceNode(): Node {
			return _source;
		}

		public function set sourceNode(val: Node): void {
			_source = val;
		}

		public function get marked(): Boolean {
			return _marked;
		}
		
		public function set marked(val: Boolean):void {
			_marked = val;
		}
		
	}
	
}
