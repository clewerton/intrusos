package src.entidade
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.utils.Dictionary;
	import lib.engine.GameContainer;
	import lib.engine.GameObject;
	import lib.graph.DirectedGraph;
	import lib.graph.Edge;
	import lib.graph.event.EdgeEvent;
	import lib.graph.event.PathEvent;
	import lib.graph.Node;
	import lib.graph.Path;
	import lib.graph.PathWalker;
	import lib.utils.Utils;
	import src.app.Settings;
	import src.evento.EventChannel;
	
	/**
	 * ...
	 * @author Clewerton Coelho
	 */
	public class Convoy extends GameContainer
	{
		private const DISTANCE_BETWEEN_VEHICLES:uint = 30;
		
		// Grafo com os possíveis caminhos a serem percorridos
		private var _graph:DirectedGraph;
		
		// Caminho a ser percorrido pelo comboio
		private var _path:Path;
		
		// Mapa que relaciona um veículo com um guia <Vehicle, PathWalker>
		private var _mapping = new Dictionary();
		//private var _vehicles:Vector.<Vehicle> = new Vector.<Vehicle>;
		
		private var _currentNode:Node;
		
		private var _startedMoving:Boolean = false;
		private var _stopped:Boolean = true;
		
		public function Convoy(graph:DirectedGraph, sourceNode:Node, canModify:Boolean = true, continuousPath:Boolean = false) {
			_path = new Path(sourceNode, canModify, continuousPath);
			_path.addEventListener(EventChannel.EDGE_ADDED, edgeAdded, false, 0, true);
			_path.addEventListener(EventChannel.EDGE_REMOVED, edgeRemoved, false, 0, true);
			Utils.paint(sourceNode, Settings.FIRST_NODE_COLOR, true);
			_graph = graph;
			_graph.forEachEdge(handleClick);
			active = false;
		}

		public function addVehicle(vehicle:Vehicle):void {
			//_vehicles.push(vehicle);
			addGameObject(vehicle);
			var newPathWalker:PathWalker = new PathWalker(_path, vehicle, DISTANCE_BETWEEN_VEHICLES * (this.size - 1));
			newPathWalker.addEventListener(EventChannel.PATH_FINISHED, stopConvoyMoving, false, 0, true);
			if(size == 1) {
				newPathWalker.addEventListener(EventChannel.EDGE_VISITED, checkPath, false, 0, true);
			}
			_mapping[vehicle] = newPathWalker;
			vehicle.index = size - 1;
		}

		public function removeVehicle(vehicle:Vehicle):void {
			removeGameObject(vehicle);
			delete _mapping[vehicle];
			//_vehicles.splice(_vehicles.indexOf(vehicle), 1);
			vehicle = null;
		}
		
		public override function update():void {
			if (!active) {
				return;
			}
			forEachGameObject(function(item:GameObject, index:int, vector:Vector.<GameObject>):void { 
				item.update();
				var pw:PathWalker = _mapping[item];
				pw.update();
			});
		}
		
		public function startWalkingPath():void {
			if (_path.edges.length > 0) {
				visible = true;
				EventChannel.getInstance().addEventListener(EventChannel.EDGE_VISITED, showEdge, false, 0, true);
				startWalking();
				startedMoving = true;
				_stopped = false;
			}
		}
		
		/*public function resetWalking():void {
			for each (var item:Vehicle in _vehicles)
			{
				_mapping[item].reset();
			}
		}*/
		
		public function stopWalking():void {
			_stopped = true;
			forEachGameObject(function(item:GameObject, index:int, vector:Vector.<GameObject>):void {
				if(index < vector.length - 1) {
					var vehicle:Vehicle = item as Vehicle;
					var nextVehicle:Vehicle = vector[index+ 1] as Vehicle;

					var dx:Number = nextVehicle.x - vehicle.x;
					var dy:Number = nextVehicle.y - vehicle.y;
					var dist = Math.sqrt(dx * dx + dy * dy);
					if(dist != DISTANCE_BETWEEN_VEHICLES && (vehicle.rotation == nextVehicle.rotation)) {
						var pw:PathWalker = _mapping[item];
						pw.step(dist - DISTANCE_BETWEEN_VEHICLES);
					}
				}
				_mapping[item].stopWalking();
			});
		}
	
		private function edgeAdded(e:PathEvent):void {
			var theEdge:Edge = e.edge;
			Utils.paint(theEdge, Settings.SELECTED_EDGE_COLOR, true);
			if (_currentNode != null && _currentNode != _path.firstNode) {
				Utils.paint(_currentNode, Node.NODE_COLOR, false);
			}
			_currentNode = theEdge.targetNode;
			Utils.paint(theEdge.targetNode, Node.NODE_SELECTED_COLOR, true);
		}
		
		private function edgeRemoved(e:PathEvent):void {
			var theEdge:Edge = e.edge;
			Utils.paint(_currentNode, Node.NODE_COLOR, false);
			_currentNode = theEdge.sourceNode;
			Utils.paint(theEdge, Settings.EDGE_COLOR, true);
			if (_currentNode != _path.firstNode) {
				Utils.paint(_currentNode, Node.NODE_SELECTED_COLOR, true);
			}
			else {
				Utils.paint(_currentNode, Settings.FIRST_NODE_COLOR, true);
			}
		}
		
		private function handleClick(item:Edge, index:int, vector:Vector.<Edge>):void {
			item.addEventListener(MouseEvent.CLICK, configurePath, false, 0, true);
		}
		
		private function configurePath(e:Event):void {
			var theEdge:Edge = e.target as Edge;
			if (!_path.inPath(theEdge)) {
				_path.addEdge(theEdge);
			}
			else if (isRemovable(theEdge)) {
				_path.separate(theEdge);
			}
		}
		
		private function isRemovable(edge:Edge):Boolean {
			var resultado:Boolean = true;
			
			forEachGameObject(function(item:GameObject, index:int, vector:Vector.<GameObject>):void {
				if(resultado) {
					var pw:PathWalker = _mapping[item];
					if (!pw.edgeAhead(edge)) {
						resultado = false;
					}
				}
			});
			return resultado;
		}
		
		private function stopConvoyMoving(e:Event) {
			stopWalking();
		}
		
		private function showEdge(event:EdgeEvent):void {
			trace("Edge: " + event.edge.name);
		}
		
		private function startWalking():void {
			if(!firstFinished()) {
				forEachGameObject(function(item:GameObject, index:int, vector:Vector.<GameObject>):void { _mapping[item].walk(); });
			}
		}
		
		private function checkPath(e:EdgeEvent) {
			var theEdge:Edge = e.edge;
			var pw0:PathWalker = _mapping[firstElement];
			theEdge.marked = true;
			_path.unMarkEdges(pw0.currentEdgeIndex + 1);
		}
		
		private function firstFinished():Boolean {
			var pw:PathWalker = _mapping[lastElement];
			return pw.finished();
		}
		
		public function get startedMoving():Boolean 
		{
			return _startedMoving;
		}
		
		public function set startedMoving(value:Boolean):void 
		{
			_startedMoving = value;
		}
		
		public function get stopped():Boolean 
		{
			return _stopped;
		}
		
	}

}