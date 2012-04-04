package grafo {
	
	import evento.EdgeEvent;
	import evento.EventChannel;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import flash.display.Sprite;
	import evento.PathEvent;
	import engine.GameObject;
	import utils.Utils;
	
	// A connection between 2 nodes.
	public class Edge extends GameObject {

		protected var _target: Node;
		protected var _source: Node;
		private var _modulus:Number;
		private var _angle:Number;
		private var _marked:Boolean = false;
		
		public function Edge() {
			addEventListener(MouseEvent.CLICK, notifyEdgeCliked, false, 0, true);
		}
		
		private function notifyEdgeCliked(e:MouseEvent):void {
			dispatchEvent(new Event(EventChannel.EDGE_CLICKED));
		}
		
		internal function get modulus():Number {
			return _modulus;
		}

		internal function getAngle(x:Number, y:Number):Number {
			return _angle;
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

		public function connect(source: Node, target: Node):void {
			_source = source;
			_target = target;
			source.addOutEdge(this);
			target.addInEdge(this);
			x = _source.x;
			y = _source.y;

			var dx:int = _target.x - _source.x;
			var dy:int = _target.y - _source.y;
			_modulus = Math.sqrt((Math.abs(dx * dx) + Math.abs(dy * dy)));
			_angle = Math.atan2(dy, dx);
			graphics.lineStyle(3, 0x00FF00);
			graphics.lineTo(_target.x - _source.x, _target.y - _source.y);
		}

		public function disconnect():void {
			_source.removeOutEdge(this);
			_target.removeInEdge(this);
			_modulus = 0.0;
			_angle = 0.0;
			_source = null;
			_target = null;
		}

		public function get marked(): Boolean {
			return _marked;
		}
		
		public function set marked(val: Boolean):void {
			_marked = val;
		}
		
		public function walk(node:DisplayObject, delta:uint) {
			node.x = x + delta * Math.cos(getAngle(node.x, node.y));
			node.y = y + delta * Math.sin(getAngle(node.x, node.y));
			node.rotation = Utils.getDegree(getAngle(node.x, node.y));
		}
		
	}
	
}
