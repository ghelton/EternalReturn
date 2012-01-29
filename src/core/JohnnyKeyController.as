package core
{
	import comps.Johnny;
	import comps.Starfield;
	
	import datas.KeyPressData;
	
	import events.JohnnyEvent;
	
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	
	/**
	 * This class handles the interface between the main player keyboard controls
	 * and the starfield in game -- mostly rotation, but room for more
	 * 
	 * author: alec
	 */
	
	public class JohnnyKeyController extends BasicController
	{
		private var keymapper:KeyMapperEngine;
		
		public function JohnnyKeyController()
		{
			super();
			
			keymapper = new KeyMapperEngine();
			
			var vec:Vector.<KeyPressData> = new Vector.<KeyPressData>();
			
			vec.push( new KeyPressData( CONTROL_LAYER, KeyboardEvent.KEY_DOWN, onSpaceDown, KeyMapperEngine.SPACE_KEY ) );
			vec.push( new KeyPressData( CONTROL_LAYER, KeyboardEvent.KEY_DOWN, onAKeyDown, KeyMapperEngine.A_KEY ) );
			vec.push( new KeyPressData( CONTROL_LAYER, KeyboardEvent.KEY_DOWN, onDKeyDown, KeyMapperEngine.D_KEY ) );
			vec.push( new KeyPressData( CONTROL_LAYER, KeyboardEvent.KEY_DOWN, onWKeyDown, KeyMapperEngine.W_KEY ) );
			vec.push( new KeyPressData( CONTROL_LAYER, KeyboardEvent.KEY_UP, onAKeyUp, KeyMapperEngine.A_KEY ) );
			vec.push( new KeyPressData( CONTROL_LAYER, KeyboardEvent.KEY_UP, onDKeyUp, KeyMapperEngine.D_KEY ) );
			
			keymapper.register(vec);
		}
		
		public function checkKeys():void {
			if (stateAKeyDown)
				whileAKeyDown();
			if (stateDKeyDown)
				whileDKeyDown();
		}
		
		private var stateAKeyDown:Boolean = false;
		private var stateDKeyDown:Boolean = false;
		
		// INTERFACE WITH STUFFS HERE FOR STARFIELD
		// these functions are not set up to take params now, but we can add that if need
		// probably best to avoid the need though so that these 
		
		//LEFT MOVEMENT
		private function onAKeyDown(key:KeyPressData, e:KeyboardEvent):void
		{
//			dispatchEvent(new JohnnyEvent(JohnnyEvent.JOHNNY_LEFT)); 
//			this.addEventListener(Event.ENTER_FRAME, whileAKeyDown,false,0,true);
			stateAKeyDown = true;
		}

		private function onAKeyUp(key:KeyPressData, e:KeyboardEvent):void
		{
			//A is the spaceship moving right
//			this.removeEventListener(Event.ENTER_FRAME, whileAKeyDown);
			stateAKeyDown = false;
//			trace("push");
//			if (!Config.HOLD_FOR_TURN)
				dispatchEvent(new JohnnyEvent(JohnnyEvent.JOHNNY_LEFT)); 
		}
		
		private function whileAKeyDown(...skip):void {
//			trace("pressing");
//			if (Config.HOLD_FOR_TURN)
				dispatchEvent(new JohnnyEvent(JohnnyEvent.JOHNNY_LEFT));
		}
		
		
		//RIGHT MOVEMENT
		private function onDKeyDown(key:KeyPressData, e:KeyboardEvent):void
		{
//			dispatchEvent(new JohnnyEvent(JohnnyEvent.JOHNNY_RIGHT)); 	
//			this.addEventListener(Event.ENTER_FRAME, whileDKeyDown,false,0,true);
			stateDKeyDown = true;
		}
		
		private function onDKeyUp(key:KeyPressData, e:KeyboardEvent):void
		{
			//D is the spaceship moving left
//			this.removeEventListener(Event.ENTER_FRAME, whileDKeyDown);
			stateDKeyDown = false;
//			if (!Config.HOLD_FOR_TURN)
				dispatchEvent(new JohnnyEvent(JohnnyEvent.JOHNNY_RIGHT)); 
		}
		
		private function whileDKeyDown(...skip):void
		{
//			if (Config.HOLD_FOR_TURN)
				dispatchEvent(new JohnnyEvent(JohnnyEvent.JOHNNY_RIGHT));
		}
		
		// Launch button
		
		private function onWKeyDown(key:KeyPressData, e:KeyboardEvent):void
		{
			dispatchEvent(new JohnnyEvent(JohnnyEvent.JOHNNY_LAUNCH)); 
		}
		
		private function onSpaceDown(key:KeyPressData, e:KeyboardEvent):void
		{
			dispatchEvent(new JohnnyEvent(JohnnyEvent.JOHNNY_BLUE_POWER));
			this.addEventListener(Event.ENTER_FRAME, whileSpaceKeyDown,false,0,true);
		}
		
		private function whileSpaceKeyDown(e:Event):void
		{
			dispatchEvent(new JohnnyEvent(JohnnyEvent.JOHNNY_BLUE_POWER));
		}
	}
}