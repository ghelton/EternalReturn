package
{
	import comps.Starfield;
	
	import core.BasicStarfieldController;
	import core.KeyMapperEngine;
	
	import datas.KeyPressData;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.FullScreenEvent;
	import flash.events.KeyboardEvent;
	
	[SWF(width="760", height="630", version_major="10", frameRate="24")]
	public class Main extends Sprite
	{
		public static var A_KEY:uint = 65;
		public static var D_KEY:uint = 68;
				
		private var keymapper:KeyMapperEngine;
		private var starfield:Starfield;
		
		public function Main()
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, appAdded);
			BasicStarfieldController.setControlLayer(this);
		}
		
		private function appAdded(e:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, appAdded);
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			stage.addEventListener(FullScreenEvent.FULL_SCREEN, onFullScreen);
			
			//add your init stuff here
			registerMyHandsARRGH();
			
			//init stuff here
			starfield = new Starfield(stage.stageWidth, stage.stageHeight);
			addChild(starfield);
			
			
			// end init stuff //
			
			//at the end of the function
			stage.addEventListener(Event.RESIZE, resizeStage);
		}
		
		private function resizeStage(e:Event):void {
			//do something
			starfield.resize(stage.stageWidth, stage.stageHeight);
		}
		
		private function onFullScreen(e:Event):void {
			//do something here too
		}
		
		
		// INTERFACE WITH STUFFS HERE FOR STARFIELD
		// these functions are not set up to take params now, but we can add that if need
		// probably best to avoid the need though so that these 
		private function onAKeyDown():void
		{
			
		}
		
		private function onAKeyUp():void
		{
			
		}
		
		private function onDKeyDown():void
		{
			
		}
		
		private function onDKeyUp():void
		{
			
		}
		
		//register the correct keycodes w/ functions to abstract the whole shebang
		//just push more keys into the vectors to create more interfaces
		private function registerMyHandsARRGH():void
		{
			keymapper = new KeyMapperEngine();
			
			var vec:Vector.<KeyPressData>;
			
			vec.push( new KeyPressData( this, KeyboardEvent.KEY_DOWN, onAKeyDown, A_KEY ) );
			vec.push( new KeyPressData( this, KeyboardEvent.KEY_DOWN, onAKeyDown, D_KEY ) );
			vec.push( new KeyPressData( this, KeyboardEvent.KEY_UP, onDKeyDown, A_KEY ) );
			vec.push( new KeyPressData( this, KeyboardEvent.KEY_UP, onDKeyDown, D_KEY ) );
			
			keymapper.register(vec);
		}
		
		
	}
}