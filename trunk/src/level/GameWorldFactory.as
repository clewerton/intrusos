package level 
{
	import entidade.BaseWorld;
	import level.level1.World1;
	import engine.GameApp;
	import context.GameLevel;

	/**
	 * ...
	 * @author Clewerton Coelho
	 */
	public class GameWorldFactory 
	{
		
		public function GameWorldFactory() {}
		
		public static function createWorld(gameLevel:GameLevel, contextId:int):BaseWorld
		{
			var obj:BaseWorld = null;
			switch (contextId)
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