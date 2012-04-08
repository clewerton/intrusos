package src.entidade
{
	import lib.graph.Edge;
	import lib.graph.Node;
	import lib.utils.Utils;
	import fl.motion.MatrixTransformer;
	import lib.graph.LinearEdge;
	
	/**
	 * ...
	 * @author Clewerton Coelho
	 */
	public class StandardEdge extends LinearEdge
	{
		
		public override function connect(source:Node, target:Node):void
		{
			super.connect(source, target);
			graphics.lineStyle(2, 0x00FF00);
			graphics.lineTo(modulus, 0);

			drawArrow(modulus * 0.2);
			drawArrow(modulus * 0.9);
			rotation = Utils.getDegree(getAngle(0, 0));
		}
		
		private function drawArrow(distance:Number) {
			var arrowWidth = 4;
			graphics.moveTo(distance, 0);
			graphics.lineTo(distance - arrowWidth, -arrowWidth);
			graphics.moveTo(distance, 0);
			graphics.lineTo(distance - arrowWidth, arrowWidth);
		}
	
	}

}