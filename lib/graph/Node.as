package lib.graph
{
	import flash.display.Shape;
	import src.app.Settings;
	
	/**
	 * ...
	 * @author Clewerton Coelho
	 */
	public class Node extends Shape
	{
		private static const NODE_COLOR:int = 0x0000FF;
		private static const NODE_RADIUS:int = 3;
		
		protected var _outEdges:Vector.<Edge>;
		protected var _inEdges:Vector.<Edge>;
		protected var _edges:Vector.<Edge>;
		
		public function Node(posX:int, posY:int)
		{
			x = posX;
			y = posY;
			_outEdges = new Vector.<Edge>();
			_inEdges = new Vector.<Edge>();
			_edges = new Vector.<Edge>();
			
			graphics.beginFill(NODE_COLOR);
			graphics.drawCircle(0, 0, NODE_RADIUS);
		}
		
		internal function addOutEdge(edge:Edge):void
		{
			_outEdges.push(edge);
			_edges.push(edge);
		}
		
		internal function addInEdge(edge:Edge):void
		{
			_inEdges.push(edge);
			_edges.push(edge);
		}
		
		internal function removeOutEdge(edge:Edge):void
		{
			delete _outEdges[edge];
			delete _edges[edge];
		}
		
		internal function removeInEdge(edge:Edge):void
		{
			delete _inEdges[edge];
			delete _edges[edge];
		}
		
		public function getOutEdgeByIndex(index:uint):Edge
		{
			if (index <= _outEdges.length - 1)
			{
				return _outEdges[index];
			}
			return null;
		}
		
		public function getInEdgeByIndex(index:uint):Edge
		{
			if (index <= _inEdges.length - 1)
			{
				return _inEdges[index];
			}
			return null;
		}
		
		public function getEdgeByIndex(index:uint):Edge
		{
			if (index <= _edges.length - 1)
			{
				return _edges[index];
			}
			return null;
		}
		
		public function getOutEdgesSize():uint
		{
			return _outEdges.length;
		}
		
		public function getInEdgesSize():uint
		{
			return _inEdges.length;
		}
		
		public function getEdgesSize():uint
		{
			return _edges.length;
		}
	
	}

}