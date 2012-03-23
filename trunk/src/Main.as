package
{
	import entidade.*;
	import evento.*;
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.geom.ColorTransform;
	import flash.ui.Keyboard;
	import grafo.*;
	import entidade.Engine;
	import terrain.Soil2;
	
	/**
	 * ...
	 * @author Clewerton Coelho
	 */
	public class Main extends Sprite
	{
		private var _engine:EngineImpl;
		private var _world:GameWorld;
		private var _map:Map;
		private var _path:Path;
		private var _graph:DirectedGraph;
		private	var _truck:Vehicle;
		private	var _pathWalker:PathWalker;
		private var _vehicleScoreHUD:HudValue;
		private var _vehicleHealthHUD:HudValue;

		public function Main():void
		{
			if (stage)
				init();
			else
				addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			_engine = new EngineImpl(stage);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, handleKeyboard, false, 0, true);
			
			_world.start();
		}

		private function createTerreno():void {
			var terreno:Bitmap = new Bitmap(new Soil2());
			stage.addChild(terreno);
		}
		
		private function handleKeyboard(event:KeyboardEvent):void {
			switch (event.keyCode) {
				case Keyboard.E:
					if (_path.edges.length > 0) {
						_truck.visible = true;
						_pathWalker.addEventListener(EventChannel.EDGE_VISITED, showEdge, false, 0 , true);
						_pathWalker.start();
					}
				break;
				case Keyboard.R:
					_pathWalker.reset();
				break;
				case Keyboard.Q:
					_pathWalker.stop();
				break;
			}
		}

		private function showEdge(event:EdgeEvent):void {
			trace("Edge: " + event.edge.name);
		}

	}

}