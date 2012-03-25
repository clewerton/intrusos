package grafo {
	import evento.*;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.ColorTransform;
	import grafo.DirectedGraph;
	import grafo.Edge;
	import grafo.Path;
	import grafo.PathWalker;
	import flash.display.Stage;
	import entidade.Vehicle;
	
	public class Map extends Sprite {

		private var _stage:Stage;
		private var _graph:DirectedGraph;
		
		// Para o jogo, 1 caminho só basta
		private var _path:Path;
		
		private var _pathWalkers:Vector.<PathWalker> = new Vector.<PathWalker>();
		
		public function Map(stageRef:Stage, graph:DirectedGraph, path:Path) {
			_stage = stageRef;
			_path = path;

			_graph = graph;
			_graph.forEachEdge(handleClick);
			addChild(_graph);
		}

		public function get path():Path {
			return _path;
		}
		
		public function set path(val:Path):void {
				_path = val;
		}

		public function addPathWalker(pathWalker:PathWalker):void {
			_pathWalkers.push(pathWalker);
		}
		
		private function handleClick(item:Edge, index:int, vector:Vector.<Edge>):void {
			item.addEventListener(MouseEvent.CLICK, configurePath, false, 0, true);
		}
		
		private function configurePath(e:Event):void {
			var theEdge:Edge = e.target as Edge;
			if (!_path.inPath(theEdge)) {
				_path.addEdge(theEdge);
			}
			else {
				if (isRemovable(theEdge)) {
					_path.separate(theEdge);
				}
			}
		}
		
		private function isRemovable(edge:Edge):Boolean {
			var resultado:Boolean = true;
			var walkersIndex:uint = 0;
			
			while (resultado && (walkersIndex < _pathWalkers.length)) {
				if (!_pathWalkers[walkersIndex++].edgeAhead(edge)) {
					resultado = false;
				}
			}
			return resultado;
		}
		
	}
	
}
