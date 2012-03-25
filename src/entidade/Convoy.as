package entidade 
{
	import entidade.Vehicle;
	/**
	 * ...
	 * @author Clewerton Coelho
	 */
	public class Convoy {

		private var _vehicles:Vector.<Vehicle> = new Vector.<Vehicle>;
		
		public function Convoy() {
		}
		
		public function addVehicle(vehicle:Vehicle):void {
			_vehicles.push(vehicle);
		}

		public function removeVehicle(vehicle:Vehicle):void {
			_vehicles.splice(_vehicles.indexOf(vehicle), 1);
		}
		

		public function get vehicles():Vector.<Vehicle> {
			return _vehicles;
		}
		
		public function set visible(val:Boolean):void {
			for each(var item:Vehicle in _vehicles) {
				item.visible = val;
			}
		}
		
		public function update():void {
			for each(var item:Vehicle in _vehicles) {
				item.update();
			}
		}
		
	}

}