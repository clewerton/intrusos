package grafo
{
	import flash.display.Shape;
	
	/**
	 * ...
	 * @author Clewerton Coelho
	 */
	public class Node extends Shape
	{
		
		internal const viewRadius:uint = 4;
		private static var incr:int = 0;
		
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
			
			graphics.beginFill(0x0000FF);
			graphics.drawCircle(0, 0, viewRadius);
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