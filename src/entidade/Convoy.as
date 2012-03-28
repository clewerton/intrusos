package entidade 
{
	import entidade.Vehicle;
	import engine.GameObject;

	/**
	 * ...
	 * @author Clewerton Coelho
	 */
	public class Convoy extends GameObject {

		private var _vehicles:Vector.<Vehicle> = new Vector.<Vehicle>;
		
		public function Convoy() {
		}
		
		public override function init():void {
			
		}
		
		public override function dispose():void {
			
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
		
		public function set isVisible(val:Boolean):void {
			for each(var item:Vehicle in _vehicles) {
				item.visible = val;
			}
		}
		
		public override function update():void {
			for each(var item:Vehicle in _vehicles) {
				item.update();
			}
		}
		
	}

}