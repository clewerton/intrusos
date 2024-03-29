﻿package src.app {
	
	import flash.display.MovieClip;
	import src.entidade.AttackTruck;
	import src.entidade.Convoy;
	import src.entidade.Vehicle;
	
	/**
	 * ...
	 * @author Clewerton Coelho
	 * Representa a opção de veículo de ataque.
	 */
	
	public class AttackTruckChoice extends VechicleChoice {
		
		
		public function AttackTruckChoice(pos:int) {
			super(pos);
		}
		
		public override function getVehicleType():Class {
			return AttackTruck;
		}
		
	}
	
}
