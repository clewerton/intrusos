package tela
{
	
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.events.Event;
	import tela.MenuItem;
	
	public class TelaInicial extends BaseScreen
	{
			var menuVar:MenuItem;
	
			protected override function init(e:Event = null):void
			{
				super.init(e);
				menuVar = new MenuItem("Teste", action);
				addChild(menuVar);
			}
			
			public function action(e:Event):void
			{
				trace("Botao clicado!!");
			}
	}
	
}
