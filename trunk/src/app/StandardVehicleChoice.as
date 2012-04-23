package src.app {
	
	import flash.display.MovieClip;
	import src.entidade.Convoy;
	import src.entidade.StandardTruck;
	
	
	public class StandardVehicleChoice extends VechicleChoice {
		
		
		public function StandardVehicleChoice(pos:int) {
			super(pos);
		}
		
		public override function getVehicleType():String {
			return "StandardTruck";
		}
		
	}
	
}
