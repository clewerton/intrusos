package src.app
{
	
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import lib.engine.GameApp;
	import lib.engine.GameContext;
	import src.Main;
	
	public class ConvoyConfigContext extends GameContext
	{
		private var availableChoices:Vector.<VechicleChoice> = new Vector.<VechicleChoice>();
		private var selectedChoices:Array = new Array();
		
		public function ConvoyConfigContext(gameApp:GameApp)
		{
			super(gameApp);
		}
		
		protected override function onAddedToStage(e:Event = null):void
		{
			var menuVar:GameMenuItem;
			var vehicleChoice:VechicleChoice;
			
			super.onAddedToStage(e);
			
			// Adicionando opções de veículos
			vehicleChoice = new StandardVehicleChoice(0);
			configureAvailableChoice(vehicleChoice, 0);
			
			for (var counter:int = 0; counter < 4; counter++) {
				var newChoice:VechicleChoice = new VechicleChoice(counter);
				addSelectedChoice(newChoice, counter);
			}
			
		/*menuVar = new GameMenuItem("Adicionar veiculo", 0xFFFF00, function() {
			 gameApp.activeState = Main.BACK_TO_GAME;
			 });
			 menuVar.x = 350;
			 menuVar.y = 550;
			 addChild(menuVar);
		
			 menuVar = new GameMenuItem("Retirar veiculo", 0xFFFF00, function() {
			 gameApp.levelIndex = 2;
			 gameApp.activeState = Main.START_GAME;
			 });
			 menuVar.x = 450
			 menuVar.y = 550;
			 addChild(menuVar);
		 */
		}

		private function configureAvailableChoice(availableChoice:VechicleChoice, counter:int):void {
			availableChoices.push(availableChoice);
			addChildAt(availableChoice, 2);
			var choiceX = 75 + counter * 400;
			var choiceY = 220 + counter * 100;
			
			availableChoice.x = choiceX;
			availableChoice.y = choiceY;
			
			availableChoice.addEventListener(MouseEvent.MOUSE_OVER, function(event:MouseEvent):void {
				useHandCursor = true;
				buttonMode = true;
			});

			availableChoice.addEventListener(MouseEvent.MOUSE_OUT, function(event:MouseEvent):void {
				useHandCursor = false;
				buttonMode = false;
			});

			availableChoice.addEventListener(MouseEvent.MOUSE_DOWN, function(evt:MouseEvent):void {
				var obj:VechicleChoice = evt.target as VechicleChoice;
				obj.startDrag();
			});

			availableChoice.addEventListener(MouseEvent.MOUSE_UP, function(evt:MouseEvent):void {
				var obj:VechicleChoice = evt.target as VechicleChoice;
				obj.stopDrag();
				
				var selIndex:int = optionSelected(obj.dropTarget);
				if (selIndex > -1) {
					var selectedChoice:VechicleChoice = selectedChoices[selIndex];
					removeChild(selectedChoice);
					var pos:int = selectedChoice.pos;
					selectedChoice = new StandardVehicleChoice(pos);
					addSelectedChoice(selectedChoice, selIndex);
					obj.x = choiceX;
					obj.y = choiceY;
				}
			});
		}
		
		private function addSelectedChoice(obj:VechicleChoice, counter:int):void {
			selectedChoices[counter] = obj;
			obj.x = 100 + 200 * counter;
			obj.y = 500;
			addChildAt(obj, 1);
			obj.doubleClickEnabled = true;
			obj.addEventListener(MouseEvent.DOUBLE_CLICK, function(evt:MouseEvent):void {
				removeChild(obj);
				var pos:int = obj.pos;
				obj = new VechicleChoice(pos);
				addSelectedChoice(obj, pos);
			});
		}
			
		private function optionSelected(obj:DisplayObject):int {
			for (var counter:int = 0; counter < 4; counter++) {
				if (obj.parent == selectedChoices[counter]) {
					return counter;
				}
			}
			return -1;
		}
		
		public function getConvoyConfiguration():Vector.<String> {
			var result:Vector.<String> = new Vector.<String>();
			for (var counter:int = 0; counter < 4; counter++) {
				result.push(selectedChoices[counter]);
			}
			return result;
		}
		
	}
}
