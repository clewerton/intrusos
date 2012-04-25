package src.entidade
{
	import lib.graph.LinearEdge;
	import lib.graph.Node;
	import lib.utils.Utils;
	import src.app.Settings;
	
	/**
	 * ...
	 * @author Clewerton Coelho
	 * Representação visual de uma aresta reta.
	 */
	public class StandardLinearEdge extends LinearEdge
	{
		
		public override function connect(source:Node, target:Node):void
		{
			super.connect(source, target);
			graphics.lineStyle(Settings.EDGE_THICKNESS, Settings.EDGE_COLOR);
			graphics.lineTo(modulus, 0);

			drawArrow(modulus * 0.2);
			drawArrow(modulus * 0.9);
			rotation = Utils.getDegree(getAngle());
		}
		
		private function drawArrow(distance:Number) {
			var arrowWidth = 8;
			graphics.moveTo(distance, 0);
			graphics.lineTo(distance - arrowWidth, -arrowWidth / 2);
			graphics.moveTo(distance, 0);
			graphics.lineTo(distance - arrowWidth, arrowWidth / 2);
		}
	
	}

}