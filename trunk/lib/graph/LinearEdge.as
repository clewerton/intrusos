package lib.graph {
	
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import lib.engine.GameObject;
	import src.evento.EventChannel;
	import lib.utils.Utils;
	
	public class LinearEdge extends Edge {

		public override function connect(source: Node, target: Node):void {
			super.connect(source, target);

			var dx:int = targetNode.x - sourceNode.x;
			var dy:int = targetNode.y - sourceNode.y;
			setModulus(Math.sqrt((Math.abs(dx * dx) + Math.abs(dy * dy))));
		}

		// Retorna a distancia que excedente ao comprimento do caminho 
		public override function walk(node:DisplayObject, distance:uint):Number {
			var distanceToWalk = (distance > modulus ? modulus : distance);
			node.x = x + distanceToWalk * Math.cos(getAngle());
			node.y = y + distanceToWalk * Math.sin(getAngle());
			node.rotation = Utils.getDegree(getAngle());
			return distance - distanceToWalk;
		}

		// Getters e setters
		public override function getAngleAt(x:Number, y:Number):Number {
			return getAngle();
		}

	}
	
}
