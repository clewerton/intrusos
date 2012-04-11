package src.entidade
{
	import lib.graph.Node;
	import lib.graph.QuadrantEdge;
	import lib.utils.Utils;
	import flash.geom.Point;
	import flash.display.Graphics;
	
	/**
	 * ...
	 * @author Clewerton Coelho
	 */
	public class StandardQuadrantEdge extends QuadrantEdge
	{

		public function StandardQuadrantEdge(clockwise:Boolean = true) {
			super(clockwise);
		}
		
		public override function connect(source:Node, target:Node):void
		{
			super.connect(source, target);
			graphics.lineStyle(2, 0xFF0000);

			var startAngle:Number;
			var sign:int = clockwise ? -1 : 1;
			if(clockwise) {
				sign = -1;
				startAngle = getAngle(sourceNode.x, sourceNode.y);
			}
			else {
				sign = 1;
				startAngle = -getAngle(sourceNode.x, sourceNode.y);
			}
			//var startAngle:Number = getAngle(sourceNode.x, sourceNode.y);
			//Utils.drawLinedArc(graphics, radius, Math.PI / 2);
			Utils.drawArc(graphics, 0, 0, radius, sign * Math.PI / 2, startAngle);
			//rotation = Utils.getDegree(getAngle(sourceNode.x, sourceNode.y));
			trace(name, startAngle);
			
			//drawArrow(Math.PI / 2 * 0.2);
			//drawArrow(Math.PI / 2 * 0.9);
		}
		
		private function drawArrow(angle:Number) {
			var arrowWidth = 4;
			var initPoint:Point = Point.polar(radius, angle);
			trace(initPoint.x, initPoint.y);
			graphics.moveTo(initPoint.x - radius, initPoint.y);
			graphics.lineTo(- arrowWidth, -arrowWidth / 2);
			graphics.moveTo(initPoint.x - radius, initPoint.y);
			graphics.lineTo(- arrowWidth, arrowWidth / 2);
		}
	
	}

}