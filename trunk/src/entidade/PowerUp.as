package src.entidade {
	
	import flash.display.MovieClip;
	import lib.engine.GameObject;
	import src.app.BaseWorld;
	
	
	public class PowerUp extends DestroyableObject {
		
		public function PowerUp(world:BaseWorld, maxHealth:int, endurance:uint) {
			super(world, maxHealth, endurance);
		}
		
		public function apply(obj:Vehicle):void {}
	}
	
}
