package engine 
{
	import flash.display.MovieClip;
	import flash.events.Event;

	/**
	 * ...
	 * @author Clewerton Coelho
	 */
	public class GameObject extends MovieClip
	{
		
		public function GameObject() 
		{
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		// Método padrão a ser chamado para inicializar os filhos
		private function onAddedToStage(e:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			init();
		}
		
		public function init():void
		{			
		}
		
		// Atualiza o estado do elemento
		public function update():void {
		}

		// Libera recursos da classe
		public function dispose():void {
		}
		
	}

}