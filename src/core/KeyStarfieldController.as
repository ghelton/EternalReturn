package core
{
	import comps.Starfield;
	
	import datas.KeyPressData;
	
	import flash.events.KeyboardEvent;
	
	public class KeyStarfieldController extends BasicStarfieldController
	{
		private var keymapper:KeyMapperEngine;

		public function KeyStarfieldController($starfield:Starfield)
		{
			super($starfield);
			
			keymapper = new KeyMapperEngine();
			
			var vec:Vector.<KeyPressData> = new Vector.<KeyPressData>();
			
			vec.push( new KeyPressData( CONTROL_LAYER, KeyboardEvent.KEY_DOWN, onAKeyDown, KeyMapperEngine.A_KEY ) );
			vec.push( new KeyPressData( CONTROL_LAYER, KeyboardEvent.KEY_DOWN, onAKeyDown, KeyMapperEngine.D_KEY ) );
			vec.push( new KeyPressData( CONTROL_LAYER, KeyboardEvent.KEY_UP, onDKeyDown, KeyMapperEngine.A_KEY ) );
			vec.push( new KeyPressData( CONTROL_LAYER, KeyboardEvent.KEY_UP, onDKeyDown, KeyMapperEngine.D_KEY ) );
			
			keymapper.register(vec);
		}
		
		// INTERFACE WITH STUFFS HERE FOR STARFIELD
		// these functions are not set up to take params now, but we can add that if need
		// probably best to avoid the need though so that these 
		
		//LEFT MOVEMENT
		private function onAKeyDown():void
		{
			//A is the spaceship moving right
			_starfield.rotation += 15;
		}
		
		private function onAKeyUp():void
		{
			//A is the spaceship moving right
		}
		
		//RIGHT MOVEMENT
		private function onDKeyDown():void
		{
			//D is the spaceship moving left
			_starfield.rotation -= 15;
		}
		
		private function onDKeyUp():void
		{
			//D is the spaceship moving left
		}
		
		//register the correct keycodes w/ functions to abstract the whole shebang
		//just push more keys into the vectors to create more interfaces
		private function registerMyHandsARRGH():void
		{
			
		}
	}
}