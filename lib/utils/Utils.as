package lib.utils 
{
	import flash.display.Graphics;
	import flash.geom.Point;

	/**
	 * ...
	 * @author Clewerton Coelho
	 */
	public final class Utils 
	{
		
		public static function getDegree(radian:Number):Number { 
			return radian * 180 / Math.PI;
		}

		public static function getRadian(degree:Number):Number { 
			return degree * Math.PI / 180;
		}
		
		public static function abs( value : Number ) : Number {
			return value < 0 ? -value : value;
		}
		
		public static function drawLinedArc(target:Graphics, radius:Number, sweep:Number, startAngle:Number = 0):void {
			var numberOfSegments = Math.ceil((radius * sweep) / 8);
			var stepAngle:Number = sweep / numberOfSegments;
			
			var nextPoint:Point = null;
			var initPoint:Point = Point.polar(radius, startAngle);
			target.moveTo(initPoint.x - radius, initPoint.y);
			for(var nextAngle = startAngle; nextAngle <= sweep; nextAngle += stepAngle) {
				nextPoint = Point.polar(radius, nextAngle);
				target.lineTo(nextPoint.x - radius, nextPoint.y);
			}
		}
		
		
		/**
		 * Draws an arc from the starting position of x,y.
		 * 
		 * @param target the Graphics Class that the Arc is drawn on.
		 * @param x x coordinate of the starting pen position
		 * @param y y coordinate of the starting pen position 
		 * @param radius radius of Arc.
		 * @param arc = sweep of the arc. Negative values draw clockwise.
		 * @param startAngle = [optional] starting offset angle in degrees.
		 * @param yRadius = [optional] y radius of arc. if different than 
		 * radius, then the arc will draw as the arc of an oval.  
		 * default = radius.
		 *
		 * Based on mc.drawArc by Ric Ewing.
		 * the version by Ric assumes that the pen is at x:y before this
		 * method is called.  I explictily move the pen to x:y to be 
		 * consistent with the behaviour of the other methods.
		 */
		public static function drawArc(target : Graphics, x : Number, y : Number, radius : Number, arc : Number, startAngle : Number = 0, yRadius : Number = 0) : void {
			
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
			if (Utils.abs( arc ) > Math.PI * 2) {
				arc = Math.PI * 2;
			}
			// Flash uses 8 segments per circle, to match that, we draw in a maximum
			// of 45 degree segments. First we calculate how many segments are needed
			// for our arc.
			segs = Math.ceil( 4 * Utils.abs( arc ) / Math.PI );
			// Now calculate the sweep of each segment
			segAngle = arc / segs;
			// find our starting points (ax,ay) relative to the secified x,y
			ax = x - Math.cos( startAngle ) * radius;
			ay = y + Math.sin( startAngle ) * yRadius;
			// if our arc is larger than 45 degrees, draw as 45 degree segments
			// so that we match Flash's native circle routines.
			if (segs > 0) {
				target.moveTo( x, y );
				// Loop for drawing arc segments
				for (var i : int = 0; i < segs; ++i) {
					startAngle += segAngle;
					// find the angle halfway between the last angle and the new
					angleMid = (segAngle / 2) - startAngle;
					// calculate our end point
					bx = ax + Math.cos( startAngle ) * radius;
					by = ay - Math.sin( startAngle ) * yRadius;
					// calculate our control point
					cx = ax + Math.cos( angleMid ) * (radius / Math.cos( segAngle / 2 ));
					cy = ay + Math.sin( angleMid ) * (yRadius / Math.cos( segAngle / 2 ));
					// draw the arc segment
					target.curveTo( cx, cy, bx, by );
				}
			}
		}
		
		
	}

}