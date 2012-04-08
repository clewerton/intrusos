package src.evento 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Humberto Anjos
	 */
	public class TelaEvent extends Event 
	{
		
		private var _status:int;
		public static const ENTRADA_TELA:String = "TelaEvent:EntradaTela";
		public static const SAIDA_TELA:String = "TelaEvent:SaidaTela";
		
		public function TelaEvent(type:String, status:int = -1, bubbles:Boolean=false, cancelable:Boolean=false) 
		{
			super(type, bubbles, cancelable);
			_status = status;
		}
		
		public function get option():int
		{
			return _status;
		}
		
	
	}

}