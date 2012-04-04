package grafo {

	import entidade.Vehicle;
	import flash.display.Stage;
	import grafo.Path;
	import evento.*
	import flash.events.EventDispatcher;
	import flash.events.Event;
	import utils.Utils;
	
	/**
	 * ...
	 * @author Clewerton Coelho
	 * Classe que itera sobre um caminho previamente criado
	 */
	public class PathWalker extends EventDispatcher {

		private var _path:Path;
		private var _currentEdgeIndex:int;
		private var _edgeWalkedDistance:Number;
		private var _vehicle: Vehicle;
		private var _active:Boolean = false;
		private var _offset:uint;
		
		public function PathWalker(path:Path, vehicle: Vehicle, offset:uint = 0) {
			_path = path;
			_vehicle = vehicle;
			reset();
			_offset = offset;
		}

		public function reset():void {
			_currentEdgeIndex = -1;
			_edgeWalkedDistance = 0.0;
			if (_path.edges.length >= 1) {
				_vehicle.x = _path.edges[0].x;
				_vehicle.y = _path.edges[0].y;
			}
		}

		public function update():void {
			if (_active) {
				step(_vehicle.speed);
			}
		}
		
		public function step(delta:uint): void {
			if((_path.edges.length <= 0) || finished() || (delta == 0)) {
				return;
			}
			if (_currentEdgeIndex < 0) {
				dispatchEdgeVisited(_path.edges[++_currentEdgeIndex]);
			}
			var newEdgeVisited:Boolean = false;
			var distanceToWalk:Number = delta;
			var ramainingInEdge:Number = _path.edges[_currentEdgeIndex].modulus - _edgeWalkedDistance;
			
			// Enquanto a distancia a ser percorrida ultrapassar o fim do segmento...
			while(distanceToWalk > ramainingInEdge){
				distanceToWalk -= ramainingInEdge;
				_edgeWalkedDistance = 0;
				++_currentEdgeIndex;
				// tratamento de possível ciclo no caminho
				if(_currentEdgeIndex >= _path.edges.length) {
					var lastNode:Node = _path.edges[_currentEdgeIndex - 1].targetNode;
					_currentEdgeIndex =  _path.getOutEdgeFrom(lastNode);
					if(_currentEdgeIndex == -1) {
						_currentEdgeIndex = _path.edges.length;
						dispatchEvent(new Event(EventChannel.PATH_FINISHED));
						stopWalking();
						return;
					}
				}
				ramainingInEdge = _path.edges[_currentEdgeIndex].modulus;
				newEdgeVisited = true;
			}
			// Nesse ponto a distancia a ser percorrida não ultrapassa o fim do segmento
			var currentEdge:Edge = _path.edges[_currentEdgeIndex];
			_edgeWalkedDistance += distanceToWalk;
			currentEdge.walk(_vehicle, _edgeWalkedDistance);
			
			if(newEdgeVisited) {
				dispatchEdgeVisited(currentEdge);
			}
		}
	
		private function finished():Boolean {
			return (_currentEdgeIndex == _path.edges.length);
		}
		
		private function dispatchEdgeVisited(edge:Edge):void {
			dispatchEvent(new EdgeEvent(EventChannel.EDGE_VISITED, edge));
		}
	
		public function edgeAhead(edge:Edge):Boolean {
			var index:int = _path.edges.indexOf(edge);
			return (index > _currentEdgeIndex);
		}
		
		public function startWalking():void {
			if(!_active) {
				_active = true;
				step(_offset);
				_offset = 0;
			}
		}
		
		public function stopWalking():void {
			_active = false;
		}
		
	}
	
}