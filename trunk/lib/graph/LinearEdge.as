package lib.graph {
	
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import lib.engine.GameObject;
	import src.evento.EventChannel;
	import lib.utils.Utils;
	
	// A connection between 2 nodes.
	public class LinearEdge extends Edge {

		private var _target: Node;
		private var _source: Node;
		private var _modulus:Number;
		private var _angle:Number;
		private var _marked:Boolean = false;
		
		public override function connect(source: Node, target: Node):void {
			super.connect(source, target);

			var dx:int = targetNode.x - sourceNode.x;
			var dy:int = targetNode.y - sourceNode.y;
			setModulus(Math.sqrt((Math.abs(dx * dx) + Math.abs(dy * dy))));
			_angle = Math.atan2(dy, dx);
		}

		public override function walk(node:DisplayObject, delta:uint) {
			node.x = x + delta * Math.cos(getAngle(node.x, node.y));
			node.y = y + delta * Math.sin(getAngle(node.x, node.y));
			node.rotation = Utils.getDegree(getAngle(node.x, node.y));
		}

		// Getters e setters
		public override function getAngle(x:Number, y:Number):Number {
			return _angle;
		}

	}
	
}
