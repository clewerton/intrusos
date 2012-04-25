package src.app 
{
	import src.app.level.level1.World1;
	import src.app.level.level2.World2;
	import src.app.level.level3.World3;

	/**
	 * ...
	 * @author Clewerton Coelho
	 */
	public class GameWorldFactory 
	{
		
		public function GameWorldFactory() {}
		
		public static function createWorld(gameLevel:GameLevel, levelId:int):BaseWorld
		{
			var obj:BaseWorld = null;
			switch (levelId)
			{
				case 1: 
					obj = new World1(gameLevel);
					break;
				case 2: 
					obj = new World2(gameLevel);
					break;
				case 3: 
					obj = new World3(gameLevel);
					break;
				default:
					throw new Error("Id do mundo nao identificado");
			}
			return obj;
		}
			
	}

}