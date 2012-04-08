package src.app 
{
	import src.app.level.level1.World1;

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
				default:
					throw new Error("Id do mundo nao identificado");
			}
			return obj;
		}
			
	}

}