package lib.graph {
	
	import flash.display.DisplayObject;
	import flash.geom.Point;
	import lib.utils.Utils;
	
	// Arco de círculo que conecta 2 nodes.
	public class QuadrantEdge extends Edge {

		private var _target: Node;
		private var _source: Node;
		private var _modulus:Number;
		private var _marked:Boolean = false;
		
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
			setModulus(_radius * Math.PI / 4);
			
			// Esse só vale para quadrantes ortogonais!
			_center = _clockwise ? new Point(target.x, source.y) : new Point(source.x, target.y);
		}

		// Retorna a distancia que excedente ao comprimento do caminho 
		public override function walk(node:DisplayObject, distance:uint):Number {
			var distanceToWalk = (distance > _modulus ? _modulus : distance);
			var deltaTheta:Number = distanceToWalk / radius;
			var walkedPoint:Point = new Point(radius * Math.cos(deltaTheta), radius * Math.sin(deltaTheta));
			
			node.x = x + walkedPoint.x;
			node.y = y + walkedPoint.y;
			node.rotation = Utils.getDegree(getTangentAngle(walkedPoint.x, walkedPoint.y));
			return distance - distanceToWalk;
		}

		// Getters e setters
		public override function getAngle(px:Number, py:Number):Number {
			return _clockwise ? Math.atan2(py - sourceNode.y, px - targetNode.x) : Math.atan2(py - targetNode.y, px - sourceNode.x);
			//return Math.atan2(py - sourceNode.y, px - targetNode.x);
		}
		
		public function getTangentAngle(px:Number, py:Number):Number {
			return _clockwise ? Math.atan2(px - targetNode.x, sourceNode.y - py) : Math.atan2(px - sourceNode.x, targetNode.y - py);
			//return Math.atan2(px - targetNode.x, sourceNode.y - py);
		}

		protected function get radius():Number 
		{
			return _radius;
		}
		
		public function get center():Point 
		{
			return _center;
		}
		
		public function get clockwise():Boolean 
		{
			return _clockwise;
		}
		
	}
	
}
