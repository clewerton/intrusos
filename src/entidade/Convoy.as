package entidade 
{
	import engine.GameObject;
	import entidade.Vehicle;

	/**
	 * ...
	 * @author Clewerton Coelho
	 */
	public class Convoy extends GameObject {

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
		
		public override function set visible(val:Boolean):void {
			super.visible = val;
			for each(var item:Vehicle in _vehicles) {
				item.visible = val;
			}
		}

		public override function set active(val:Boolean):void {
			for each(var item:Vehicle in _vehicles) {
				item.active = val;
			}
		}

		public override function update():void {
			for each(var item:Vehicle in _vehicles) {
				item.update();
			}
		}
		
	}

}