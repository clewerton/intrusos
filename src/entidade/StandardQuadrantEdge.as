package src.entidade
{
	import flash.geom.Point;
	import lib.graph.Node;
	import lib.graph.QuadrantEdge;
	import lib.utils.Utils;
	import src.app.Settings;
	
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
			graphics.lineStyle(Settings.EDGE_THICKNESS, Settings.EDGE_COLOR);

			var startAngle:Number = getAngleAt(sourceNode.x, sourceNode.y);
			var sign:int = clockwise ? -1 : 1;
			Utils.drawArc(graphics, 0, 0, radius, sign * Math.PI / 2);

			//drawArrow(sign * Math.PI / 4);
			//drawArrow(Math.PI / 2 * 0.9);

			rotation = Utils.getDegree(startAngle);
		}
		
		private function drawArrow(angle:Number) {
			var sign:int = clockwise ? 1 : -1;
			var arrowWidth = 6;
			var initPoint:Point = Point.polar(radius, -angle);
			var arrow1:Point = initPoint.add(Point.polar(arrowWidth / 5, -angle - Math.PI / 4));
			trace(initPoint.x, initPoint.y, radius);
			graphics.moveTo(initPoint.x - radius, initPoint.y);
			graphics.lineTo(arrow1.x, arrow1.y);
			//graphics.moveTo(initPoint.x - radius, initPoint.y);
			//graphics.lineTo(- arrowWidth, arrowWidth / 2);
		}
	
	}

}