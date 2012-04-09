package lib.graph {
	
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import lib.engine.GameObject;
	import src.evento.EventChannel;
	import lib.utils.Utils;
	
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

		// Retorna a distancia que excedente ao comprimento do caminho 
		public override function walk(node:DisplayObject, distance:uint):Number {
			var distanceToWalk = (distance > _modulus ? _modulus : distance);
			node.x = x + distanceToWalk * Math.cos(_angle);
			node.y = y + distanceToWalk * Math.sin(_angle);
			node.rotation = Utils.getDegree(_angle);
			return distance - distanceToWalk;
		}

		// Getters e setters
		public override function getAngle(x:Number, y:Number):Number {
			return _angle;
		}

	}
	
}
