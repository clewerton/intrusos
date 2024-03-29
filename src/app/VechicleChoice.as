﻿package src.app {
	
	import flash.display.MovieClip;
	import src.entidade.Convoy;
	import src.entidade.Vehicle;
	
	/**
	 * ...
	 * @author Clewerton Coelho
	 * Classe base de opções de veículos.
	 */
	
	public class VechicleChoice extends MovieClip {
		
		private var _pos:int;
		
		public function VechicleChoice(pos:int) {
			_pos = pos;
		}
		
		public function get pos():int {
			return _pos;
		}
		
		public function getVehicleType():Class {
			return null;
		}
	}
	
}
