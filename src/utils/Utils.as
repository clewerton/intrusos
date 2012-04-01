package utils 
{
	/**
	 * ...
	 * @author Clewerton Coelho
	 */
	public final class Utils 
	{
		
		public static function getDegree(radian:Number):Number { 
			return radian * 180 / Math.PI;
		}

		public static function getRadian(degree:Number):Number { 
			return degree * Math.PI / 180;
		}
		
	}

}