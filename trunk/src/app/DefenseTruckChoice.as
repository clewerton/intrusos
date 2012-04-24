package src.app {
	
	import flash.display.MovieClip;
	import src.entidade.Convoy;
	import src.entidade.DefenseTruck;
	import src.entidade.Vehicle;
	
	
	public class DefenseTruckChoice extends VechicleChoice {
		
		
		public function DefenseTruckChoice(pos:int) {
			super(pos);
		}
		
		public override function getVehicleType():Class {
			return DefenseTruck;
		}
		
	}
	
}
