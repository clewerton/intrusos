package lib.graph {
	
	import flash.display.DisplayObject;
	import flash.geom.Point;
	import lib.utils.Utils;
	
	// Arco de círculo que conecta 2 nodes.
	public class QuadrantEdge extends Edge {

		private var _center:Point;
		private var _radius:Number = 0.0;
		private var _clockwise:Boolean = true;
		
		public function QuadrantEdge(clockwise:Boolean = true) {
			_clockwise = clockwise;
		}
		
		public override function connect(source: Node, target: Node):void {
			super.connect(source, target);

			var pSource:Point = new Point(source.x, source.y);
			var pTarget:Point = new Point(target.x, target.y);
			_radius = Point.distance(pSource, pTarget) / Math.SQRT2;
			setModulus(_radius * Math.PI / 2);

			var dx:int = targetNode.x - sourceNode.x;
			var dy:int = targetNode.y - sourceNode.y;
			var dist = Math.sqrt((Math.abs(dx * dx) + Math.abs(dy * dy)));
			
			_center = _clockwise ? 
				pSource.add(Point.polar(dist / Math.SQRT2, getAngle() + Math.PI / 4)) : 
				pSource.add(Point.polar(dist / Math.SQRT2, getAngle() - Math.PI / 4)); 
		}

		// Retorna a distancia que excedente ao comprimento do caminho 
		public override function walk(node:DisplayObject, distance:uint):Number {
			var distanceToWalk = (distance > modulus ? modulus : distance);
			var deltaTheta:Number = distanceToWalk / _radius;
			var complement:int = 0;
			if (!clockwise) {
				deltaTheta *= -1;
				complement = 180;
			}
			var walkedPoint:Point = Point.polar(_radius, getAngleAt(sourceNode.x, sourceNode.y) + deltaTheta);
			node.x = center.x + walkedPoint.x;
			node.y = center.y + walkedPoint.y;
			node.rotation = Utils.getDegree(getTangentAngleAt(node.x, node.y)) + complement;
			return distance - distanceToWalk;
		}

		// Getters e setters
		public override function getAngleAt(px:Number, py:Number):Number {
			return Math.atan2(py - center.y, px - center.x);
		}
		
		public function getTangentAngleAt(px:Number, py:Number):Number {
			return Math.atan2(px - center.x, center.y - py);
		}

		protected function get radius():Number {
			return _radius;
		}
		
		public function get center():Point {
			return _center;
		}
		
		public function get clockwise():Boolean {
			return _clockwise;
		}
		
	}
	
}
