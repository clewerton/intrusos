﻿package src.app
{
	
	import flash.events.Event;
	import lib.engine.GameApp;
	import lib.engine.GameContext;
	import src.Main;
	
	public class VictoryContext extends GameContext
	{

			public function VictoryContext(parentContext:GameContext)
			{
				super(parentContext);
			}
			
		protected override function onAddedToStage(e:Event = null):void
		{
			var gameApp:GameApp = parentContext as GameApp;
			var menuVar:GameMenuItem;

			super.onAddedToStage(e);
			
			menuVar = new GameMenuItem("Reiniciar Partida", 0xFFFF00, function() { 
				gameApp.activeState = Main.RESTART_GAME;
			});
			menuVar.x = 400;
			menuVar.y = 400;
			addChild(menuVar);
			
			menuVar = new GameMenuItem("Abortar Partida", 0xFFFF00, function() { 
				gameApp.activeState = Main.GAME_OVER;
			});
			menuVar.x = 400;
			menuVar.y = 450;
			addChild(menuVar);

			if (gameApp.levelIndex < GameLevel.MAX_LEVEL) {
				menuVar = new GameMenuItem("Próxima fase", 0xFFFF00, function() { 
					gameApp.activeState = Main.NEXT_LEVEL;
				});
				menuVar.x = 400;
				menuVar.y = 500;
				addChild(menuVar);
			}
		}
	}
	
}
