package src.entidade
{
	import lib.graph.Edge;
	import lib.graph.Node;
	import lib.graph.QuadrantEdge;
	import lib.utils.DrawingShapes;
	import lib.utils.Utils;
	import fl.motion.MatrixTransformer;
	import lib.graph.LinearEdge;
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author Clewerton Coelho
	 */
	public class StandardQuadrantEdge extends QuadrantEdge
	{

		private var _start:Point;
		private var _end:Point;
		private var _control:Point;
		private var _center:Point;
		private var localRadius:Number = 0;
		private var angleStart:Number = 0;
		private var angleEnd:Number = 0;
		private var arc:Number = 0;
		private var _command:String = "moveTo";
		private var _length:Number;
		

		public function StandardQuadrantEdge(clockwise:Boolean = true) {
			super(clockwise);
		}
		
		public override function connect(source:Node, target:Node):void
		{
			super.connect(source, target);
			graphics.lineStyle(2, 0x00FF00);
			//drawArc(center.x, center.y, radius, 90);
			
			var dx:int = sourceNode.x - center.x;
			var dy:int = sourceNode.y - center.y;
			var startAngle:Number  = Utils.getDegree(Math.atan2(dy, dx));
			if(clockwise) {
				startAngle = -startAngle;
			}
			
			var startPoint:Point = new Point(0, 0);
			var controlPoint:Point = new Point(0.0);
			var endPoint:Point = new Point(-100, -100);
			
			//drawArc(startPoint, controlPoint, endPoint);
			drawArc1(0, 0, radius, startAngle, -135, 0);

			drawArrow(modulus * 0.2);
			drawArrow(modulus * 0.9);
			rotation = Utils.getDegree(getAngle(0, 0));
		}
		
		private function drawArrow(distance:Number) {
			var arrowWidth = 4;
			graphics.moveTo(distance, 0);
			graphics.lineTo(distance - arrowWidth, -arrowWidth / 2);
			graphics.moveTo(distance, 0);
			graphics.lineTo(distance - arrowWidth, arrowWidth / 2);
		}
		
		private function drawArc(startPt:Point, controlPt:Point, endPt:Point):void {
			_start = startPt.clone();
			_end = _start;
			_end = endPt.clone();
			_control = controlPt.clone();
			_command = "circleTo";
			_center = getCircleCenter(_start, _control, _end);
			if (_center) {
				localRadius = lineLength(_start, _center);
				angleStart = Math.atan2(_start.y - _center.y, _start.x - _center.x);
				angleEnd = Math.atan2(_end.y - _center.y, _end.x - _center.x);
				if (angleEnd < angleStart) {
					angleEnd += Math.PI*2;
				}
				arc = angleEnd - angleStart;
			}
			if (!_center) {
				return;
			}
			var a1:Number = angleStart;
			var a2:Number;
			var n:int = Math.floor(arc/(Math.PI/4)) + 1;
			var span:Number = arc/(2*n);
			var spanCos:Number = Math.cos(span);
			var rc:Number = (spanCos) ? localRadius/spanCos : 0;
			var i:int;
			for (i=0; i<n; i++) {
				a2 = a1 + span;
				a1 = a2 + span;
				graphics.curveTo(
					_center.x + Math.cos(a2)*rc,
					_center.y + Math.sin(a2)*rc,
					_center.x + Math.cos(a1)*localRadius,
					_center.y + Math.sin(a1)*localRadius
				);
			}
		}

		private function getCircleCenter(p1:Point, p2:Point, p3:Point):Point {
			var tmp:Point;
			if (p1.x == p2.x || p1.y == p2.y) {
				tmp = p1;
				p1 = p3;
				p3 = tmp;
			}
			if (p2.x == p3.x) {
				tmp = p1;
				p1 = p2;
				p2 = tmp;
			}
			if (p1.x == p2.x || p2.x == p3.x) return null;
			var ma:Number = (p2.y - p1.y)/(p2.x - p1.x);
			var mb:Number = (p3.y - p2.y)/(p3.x - p2.x);
			if (ma == mb) return null;
			var x12:Number = p1.x + p2.x;
			var x23:Number = p2.x + p3.x;
			var x:Number = (ma*mb*(p1.y - p3.y) + mb*x12 - ma*x23)/(2*(mb - ma));
			var y:Number = (ma) ? (p1.y + p2.y)/2 - (x - x12/2)/ma : (p2.y + p3.y)/2 - (x - x23/2)/mb;
			return new Point(x,y);
		}

		private function lineLength(startPt:Point = null, endPt:Point = null):Number {
			if (!startPt) startPt = _start;
			if (!endPt) endPt = _end;
			var dx:Number = endPt.x - startPt.x;
			var dy:Number = endPt.y - startPt.y;
			return Math.sqrt(dx*dx + dy*dy);
		}



		private function drawArc1(x : Number, y : Number, radius : Number, arc : Number, startAngle : Number = 0, yRadius : Number = 0) : void {
			
			if (arguments.length < 4) {
				throw new ArgumentError( "DrawingShapes.drawArc() - too few parameters, need atleast 5." );
				return;
			}
			
			// if startAngle is undefined, startAngle = 0
			if( startAngle == 0 ) {
				startAngle = 0;
			}
			// if yRadius is undefined, yRadius = radius
			if (yRadius == 0) {
				yRadius = radius;
			}
			
			// Init vars
			var segAngle : Number, theta : Number, angle : Number, angleMid : Number, segs : Number, ax : Number, ay : Number, bx : Number, by : Number, cx : Number, cy : Number;
			// no sense in drawing more than is needed :)
			if (Utils.abs( arc ) > 360) {
				arc = 360;
			}
			// Flash uses 8 segments per circle, to match that, we draw in a maximum
			// of 45 degree segments. First we calculate how many segments are needed
			// for our arc.
			segs = Math.ceil( Utils.abs( arc ) / 45 );
			// Now calculate the sweep of each segment
			segAngle = arc / segs;
			// The math requires radians rather than degrees. To convert from degrees
			// use the formula (degrees/180)*Math.PI to get radians. 
			theta = -(segAngle / 180) * Math.PI;
			// convert angle startAngle to radians
			angle = -(startAngle / 180) * Math.PI;
			// find our starting points (ax,ay) relative to the secified x,y
			ax = x - Math.cos( angle ) * radius;
			ay = y - Math.sin( angle ) * yRadius;
			// if our arc is larger than 45 degrees, draw as 45 degree segments
			// so that we match Flash's native circle routines.
			if (segs > 0) {
				graphics.moveTo( x, y );
				// Loop for drawing arc segments
				for (var i : int = 0; i < segs; ++i) {
					// increment our angle
					angle += theta;
					// find the angle halfway between the last angle and the new
					angleMid = angle - (theta / 2);
					// calculate our end point
					bx = ax + Math.cos( angle ) * radius;
					by = ay + Math.sin( angle ) * yRadius;
					// calculate our control point
					cx = ax + Math.cos( angleMid ) * (radius / Math.cos( theta / 2 ));
					cy = ay + Math.sin( angleMid ) * (yRadius / Math.cos( theta / 2 ));
					// draw the arc segment
					graphics.curveTo( cx, cy, bx, by );
				}
			}
		}
		
	
	}

}