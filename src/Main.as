package
{
	import comps.Johnny;
	import comps.Starfield;
	
	import core.BasicStarfieldController;
	import core.KeyStarfieldController;
	
	import datas.PlanetData;
	import datas.UniverseMachine;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.FullScreenEvent;
	import flash.geom.Rectangle;
	import flash.geom.Vector3D;
	
	import gui.GuiOverlay;
	
	[SWF(width="760", height="630", version_major="10", frameRate="24")]
	public class Main extends Sprite
	{		
		private var _starfield:Starfield;
		private var _universeMachine:UniverseMachine;
		private var _keyController:KeyStarfieldController;
		private var _johnny:Johnny;
		
		public function Main()
		{
			trace('Eternal Return Bitches! Global Game Jam 2012! Best Game Out of 50 Cubes!');
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, appAdded);
			BasicStarfieldController.setControlLayer(this.stage);
		}
		
		private function appAdded(e:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, appAdded);
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			stage.addEventListener(FullScreenEvent.FULL_SCREEN, onFullScreen);
			
			_universeMachine = new UniverseMachine(1234567);
			_starfield = new Starfield(stage.stageWidth, stage.stageHeight, _universeMachine);
			_johnny = new Johnny(new Vector3D(10, 10, 0));
			
			addChild(_starfield);
			addChild(_johnny);
			_johnny.x = 500;
			_johnny.y = 500;

			_keyController = new KeyStarfieldController(_starfield);
			
			// overlay goes on top
			addChild(new GuiOverlay(_johnny));
			
			// end init stuff //
			
			//at the end of the function
			stage.addEventListener(Event.RESIZE, resizeStage);
		}
		
		private function resizeStage(e:Event):void {
			//do something
			_starfield.resize(stage.stageWidth, stage.stageHeight);
		}
		
		private function onFullScreen(e:Event):void {
			//do something here too
		}
	}
}