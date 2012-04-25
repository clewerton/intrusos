package src.app {
	
	import flash.display.MovieClip;
	import src.entidade.Convoy;
	import src.entidade.DefenseTruck;
	import src.entidade.Vehicle;
	
	/**
	 * ...
	 * @author Clewerton Coelho
	 * Representa a opção de veículo de defesa.
	 */
	
	public class DefenseTruckChoice extends VechicleChoice {
		
		
		public function DefenseTruckChoice(pos:int) {
			super(pos);
		}
		
		public override function getVehicleType():Class {
			return DefenseTruck;
		}
		
	}
	
}
