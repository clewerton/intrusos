package entidade
{
	import engine.GameObject;
	import entidade.Vehicle;
	import flash.utils.Dictionary;
	import grafo.Path;
	import grafo.PathWalker;
	import grafo.DirectedGraph;
	import grafo.Node;
	import grafo.Edge;
	import flash.events.Event;
	import evento.PathEvent;
	import evento.EventChannel;
	import flash.geom.ColorTransform;
	import flash.events.MouseEvent;
	import evento.EdgeEvent;
	import engine.GameContainer;
	
	/**
	 * ...
	 * @author Clewerton Coelho
	 */
	public class Convoy extends GameContainer
	{
		
		// Grafo com os possíveis caminhos a serem percorridos
		private var _graph:DirectedGraph;
		
		// Caminho a ser percorrido pelo comboio
		private var _path:Path;
		
		// Mapa que relaciona um veículo com um guia <Vehicle, PathWalker>
		private var _mapping = new Dictionary();
		private var _vehicles:Vector.<Vehicle> = new Vector.<Vehicle>;
		
		public function Convoy(graph:DirectedGraph, sourceNode:Node, canModify:Boolean = true, continuousPath:Boolean = false)
		{
			_path = new Path(sourceNode, canModify, continuousPath);
			_path.addEventListener(EventChannel.EDGE_ADDED, edgeAdded, false, 0, true);
			_path.addEventListener(EventChannel.EDGE_REMOVED, edgeRemoved, false, 0, true);
			
			_graph = graph;
			_graph.forEachEdge(handleClick);
			active = false;
		}
		
		private function edgeAdded(e:PathEvent):void
		{
			var theEdge:Edge = e.edge;
			var myColor:ColorTransform = theEdge.transform.colorTransform;
			myColor.color = 0x00FFFF;
			theEdge.transform.colorTransform = myColor;
			//trace(theEdge.name);
		}
		
		private function edgeRemoved(e:PathEvent):void
		{
			var theEdge:Edge = e.edge;
			var myColor:ColorTransform = theEdge.transform.colorTransform;
			myColor.color = 0x00FF00;
			theEdge.transform.colorTransform = myColor;
			//trace(theEdge.name);
		}
		
		private function handleClick(item:Edge, index:int, vector:Vector.<Edge>):void
		{
			item.addEventListener(MouseEvent.CLICK, configurePath, false, 0, true);
		}
		
		private function configurePath(e:Event):void
		{
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
		
		private function isRemovable(edge:Edge):Boolean
		{
			var resultado:Boolean = true;
			
			for each (var _vehicle:Vehicle in _vehicles)
			{
				var pw:PathWalker = _mapping[_vehicle];
				if (!pw.edgeAhead(edge)) {
					resultado = false;
					break;
				}
			}
			return resultado;
		}
		
		public function addVehicle(vehicle:Vehicle):void
		{
			_vehicles.push(vehicle);
			addGameObject(vehicle);
			_mapping[vehicle] = new PathWalker(_path, vehicle, 50);
		}
		
		public function removeVehicle(vehicle:Vehicle):void
		{
			removeGameObject(vehicle);
			delete _mapping[vehicle];
			_vehicles.splice(_vehicles.indexOf(vehicle), 1);
			vehicle = null;
		}
		
		public function get vehicles():Vector.<Vehicle>
		{
			return _vehicles;
		}
		
		public override function set visible(val:Boolean):void
		{
			super.visible = val;
			for each (var item:Vehicle in _vehicles) {
				item.visible = val;
			}
		}
		
		public override function set active(val:Boolean):void
		{
			for each (var item:Vehicle in _vehicles) {
				item.active = val;
			}
		}
		
		public override function update():void
		{
			if(!active) {
				return;
			}
			for each (var item:Vehicle in _vehicles) {
				item.update();
				_mapping[item].update();
			}
		}
		
		public function startWalkingPath():void
		{
			if (_path.edges.length > 0) {
				this.active = true;
				this.visible = true;
				EventChannel.getInstance().addEventListener(EventChannel.EDGE_VISITED, showEdge, false, 0, true);
				startWalking();
			}
		}
		
		private function showEdge(event:EdgeEvent):void
		{
			trace("Edge: " + event.edge.name);
		}
		
		private function startWalking():void
		{
			for each (var item:Vehicle in _vehicles) {
				_mapping[item].startWalking();
			}
		}
		
		public function resetWalking():void
		{
			for each (var item:Vehicle in _vehicles) {
				_mapping[item].reset();
			}
		}
		
		public function stopWalking():void
		{
			for each (var item:Vehicle in _vehicles) {
				_mapping[item].stopWalking();
			}
		}
	
	}

}