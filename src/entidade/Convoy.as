package src.entidade
{
	import flash.display.DisplayObject;
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.ColorTransform;
	import flash.utils.Dictionary;
	import lib.engine.GameContainer;
	import lib.graph.DirectedGraph;
	import lib.graph.Path;
	import lib.graph.Node;
	import src.app.Settings;
	import src.evento.EventChannel;
	import lib.graph.event.PathEvent;
	import lib.graph.Edge;
	import lib.graph.event.EdgeEvent;
	import lib.graph.PathWalker;
	import lib.utils.Utils;
	
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
		private var _vehicles:Vector.<Vehicle> = new Vector.<Vehicle>;
		
		private var _currentNode:Node;
		
		private var _moved:Boolean = false;
		
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
			_vehicles.push(vehicle);
			addGameObject(vehicle);
			var newPathWalker:PathWalker = new PathWalker(_path, vehicle, DISTANCE_BETWEEN_VEHICLES * (_vehicles.length - 1));
			newPathWalker.addEventListener(EventChannel.PATH_FINISHED, stopConvoyMoving, false, 0, true);
			_mapping[vehicle] = newPathWalker;
		}

		public function removeVehicle(vehicle:Vehicle):void {
			removeGameObject(vehicle);
			delete _mapping[vehicle];
			_vehicles.splice(_vehicles.indexOf(vehicle), 1);
			vehicle = null;
		}
		
		public function get vehicles():Vector.<Vehicle> {
			return _vehicles;
		}
		
		public override function set visible(val:Boolean):void {
			super.visible = val;
			for each (var item:Vehicle in _vehicles)
			{
				item.visible = val;
			}
		}
		
		public override function set active(val:Boolean):void {
			for each (var item:Vehicle in _vehicles) {
				item.active = val;
			}
		}
		
		public override function update():void {
			if (!active) {
				return;
			}
			for each (var item:Vehicle in _vehicles) {
				item.update();
				_mapping[item].update();
			}
		}
		
		public function startWalkingPath():void {
			if (_path.edges.length > 0) {
				active = true;
				visible = true;
				EventChannel.getInstance().addEventListener(EventChannel.EDGE_VISITED, showEdge, false, 0, true);
				startWalking();
				moved = true;
			}
		}
		
		/*public function resetWalking():void {
			for each (var item:Vehicle in _vehicles)
			{
				_mapping[item].reset();
			}
		}*/
		
		public function stopWalking():void {
			for each (var item:Vehicle in _vehicles) {
				_mapping[item].stopWalking();
			}
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
			
			for each (var _vehicle:Vehicle in _vehicles) {
				var pw:PathWalker = _mapping[_vehicle];
				if (!pw.edgeAhead(edge)) {
					resultado = false;
					break;
				}
			}
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
				for each (var item:Vehicle in _vehicles) {
					_mapping[item].startWalking();
				}
			}
		}
		
		private function firstFinished():Boolean {
			var pw:PathWalker = _mapping[_vehicles[_vehicles.length - 1]];
			if(pw.finished()) {
				return true;
			}
			return false;
		}
		
		public function get moved():Boolean 
		{
			return _moved;
		}
		
		public function set moved(value:Boolean):void 
		{
			_moved = value;
		}
		
	}

}