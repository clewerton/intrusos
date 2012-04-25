package src.evento
{
	
	import flash.events.Event;
	import src.entidade.DestroyableObject;
	/**
	 * ...
	 * @author Clewerton Coelho
	 * Representa um evento de destruição de um item destrutítel.
	 */
	
	public class DestroyableEvent extends Event
	{
		
		private var _gameObject:DestroyableObject;
		
		public function DestroyableEvent(type:String, obj:DestroyableObject, bubbles:Boolean = false, cancelable:Boolean = false)
		{
			super(type, bubbles, cancelable);
			_gameObject = obj;
		}
		
		public function get gameObject():DestroyableObject
		{
			return _gameObject;
		}
	
	}
}
