package src.entidade {
	import src.app.BaseWorld;
	
	/**
	 * ...
	 * @author Clewerton Coelho
	 * Veículo de defesa.
	 */
	
	public class DefenseTruck extends Vehicle {
		
		public function DefenseTruck(world:BaseWorld) {
			super(world, 800, 2, 12, new GunCannon(world, this));
			
			_hitRegion.graphics.beginFill(0xCCCCCC, 0);
			_hitRegion.graphics.drawRect( -12, -6, 25, 13);
			_hitRegion.graphics.endFill();
		}
	}
	
}
