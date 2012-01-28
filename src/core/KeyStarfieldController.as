package core
{
	import comps.Starfield;
	
	import datas.KeyPressData;
	
	import flash.events.KeyboardEvent;
	
	/**
	 * This class handles the interface between the main player keyboard controls
	 * and the starfield in game -- mostly rotation, but room for more
	 * 
	 * author: alec
	 */
	
	public class KeyStarfieldController extends BasicStarfieldController
	{
		private var keymapper:KeyMapperEngine;

		public function KeyStarfieldController($starfield:Starfield)
		{
			trace('register keys');
			super($starfield);
			
			keymapper = new KeyMapperEngine();
			
			var vec:Vector.<KeyPressData> = new Vector.<KeyPressData>();
			
			vec.push( new KeyPressData( CONTROL_LAYER, KeyboardEvent.KEY_DOWN, onAKeyDown, KeyMapperEngine.A_KEY ) );
			vec.push( new KeyPressData( CONTROL_LAYER, KeyboardEvent.KEY_DOWN, onDKeyDown, KeyMapperEngine.D_KEY ) );
			vec.push( new KeyPressData( CONTROL_LAYER, KeyboardEvent.KEY_UP, onAKeyUp, KeyMapperEngine.A_KEY ) );
			vec.push( new KeyPressData( CONTROL_LAYER, KeyboardEvent.KEY_UP, onDKeyUp, KeyMapperEngine.D_KEY ) );
			
			keymapper.register(vec);
		}
		
		// INTERFACE WITH STUFFS HERE FOR STARFIELD
		// these functions are not set up to take params now, but we can add that if need
		// probably best to avoid the need though so that these 
		
		//LEFT MOVEMENT
		private function onAKeyDown(key:KeyPressData, e:KeyboardEvent):void
		{
			//A is the spaceship moving right
			trace('A Key Down: Rotate Ship Left');
			_starfield.rotation += Config.A_KEY_ROTATION_SPEED;
		}
		
		private function onAKeyUp(key:KeyPressData, e:KeyboardEvent):void
		{
			//A is the spaceship moving right
			
		}
		
		//RIGHT MOVEMENT
		private function onDKeyDown(key:KeyPressData, e:KeyboardEvent):void
		{
			//D is the spaceship moving left
			trace('D Key Down: Rotate Ship Left');
			_starfield.rotation -= Config.D_KEY_ROTATION_SPEED;
		}
		
		private function onDKeyUp(key:KeyPressData, e:KeyboardEvent):void
		{
			//D is the spaceship moving left
		}
	}
}