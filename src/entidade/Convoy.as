﻿package src.entidade
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
		
		private var _previousNode:Node;
		
		public function Convoy(graph:DirectedGraph, sourceNode:Node, canModify:Boolean = true, continuousPath:Boolean = false) {
			_path = new Path(sourceNode, canModify, continuousPath);
			_path.addEventListener(EventChannel.EDGE_ADDED, edgeAdded, false, 0, true);
			_path.addEventListener(EventChannel.EDGE_REMOVED, edgeRemoved, false, 0, true);
			paint(sourceNode, Settings.FIRST_NODE_COLOR);
			_graph = graph;
			_graph.forEachEdge(handleClick);
			active = false;
		}

		public function addVehicle(vehicle:Vehicle):void {
			_vehicles.push(vehicle);
			addGameObject(vehicle);
			var newPathWalker:PathWalker = new PathWalker(_path, vehicle, 40 * (_vehicles.length - 1));
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
				this.active = true;
				this.visible = true;
				EventChannel.getInstance().addEventListener(EventChannel.EDGE_VISITED, showEdge, false, 0, true);
				startWalking();
			}
		}
		
		public function resetWalking():void {
			for each (var item:Vehicle in _vehicles)
			{
				_mapping[item].reset();
			}
		}
		
		public function stopWalking():void {
			for each (var item:Vehicle in _vehicles)
			{
				_mapping[item].stopWalking();
			}
		}
	
		private function paint(obj:DisplayObject, color:int):void {
				var objColor:ColorTransform = obj.transform.colorTransform;
				objColor.color = color;
				obj.transform.colorTransform = objColor;
		}
		
		private function edgeAdded(e:PathEvent):void {
			var theEdge:Edge = e.edge;
			paint(theEdge, Settings.EDGE_HIGHLIGHTED_COLOR);
			if (_previousNode != null) {
				paint(_previousNode, Node.NODE_COLOR);
			}
			_previousNode = theEdge.targetNode;
			paint(theEdge.targetNode, Node.NODE_SELECTED_COLOR);
		}
		
		private function edgeRemoved(e:PathEvent):void {
			var theEdge:Edge = e.edge;
			paint(theEdge, Settings.EDGE_COLOR);
			paint(_previousNode, Node.NODE_COLOR);
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
			for each (var item:Vehicle in _vehicles) {
				_mapping[item].startWalking();
			}
		}
		
	}

}