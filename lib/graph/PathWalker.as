package lib.graph {

	import flash.events.Event;
	import flash.events.EventDispatcher;
	import lib.graph.event.EdgeEvent;
	import src.entidade.Vehicle;
	import src.evento.EventChannel;
	
	/**
	 * ...
	 * @author Clewerton Coelho
	 * Classe que itera sobre um caminho previamente criado
	 */
	public class PathWalker extends EventDispatcher {

		public static var countValue = 0;
		private var _path:Path;
		private var _currentEdgeIndex:int = -1;
		private var _edgeWalkedDistance:Number = 0.0;
		private var _vehicle: Vehicle;
		private var _active:Boolean = false;
		private var _offset:int;
		
		// true se o veiculo saiu do ponto de partida
		private var _started:Boolean = false;
		//private var _counter:int;
		
		
		
		public function PathWalker(path:Path, vehicle: Vehicle, offset:uint = 0) {
			_path = path;
			_vehicle = vehicle;
			reset();
			_offset = offset;
			//_counter = countValue++;
		}

		private function reset():void {
			_started = false;
			_active = false;
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
		
		public function step(delta:int): void {
			if((_path.edges.length <= 0) || finished() || (delta == 0) || !_active) {
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
						dispatchEvent(new Event(EventChannel.PATH_FINISHED));
						_currentEdgeIndex = _path.edges.length;
						//stopWalking();
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
	
		public function finished():Boolean {
			return (_currentEdgeIndex == _path.edges.length);
		}
		
		private function dispatchEdgeVisited(edge:Edge):void {
			dispatchEvent(new EdgeEvent(EventChannel.EDGE_VISITED, edge));
		}
	
		public function edgeAhead(edge:Edge):Boolean {
			var index:int = _path.edges.indexOf(edge);
			return (index > _currentEdgeIndex);
		}
		
		private function startWalking():void {
			_started = true;
			step(_offset);
		}
		
		public function walk():void {
			_active = true;
			if (!_started) {
				startWalking();
			}
		}
		
		public function stopWalking():void {
			_active = false;
		}
		
		public function get active():Boolean 
		{
			return _active;
		}
		
		public function set active(value:Boolean):void 
		{
			_active = value;
		}
		
		/*public function get counter():int 
		{
			return _counter;
		}*/
		
	}
	
}