package
{
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
	
	[SWF(width="760", height="630", version_major="10", frameRate="24")]
	public class Main extends Sprite
	{		
		private var _starfield:Starfield;
		private var _universeMachine:UniverseMachine;
		private var _keyController:KeyStarfieldController;
		
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
			
			//add your init stuff here			
			//init stuff here
			_starfield = new Starfield(stage.stageWidth, stage.stageHeight);
			addChild(_starfield);
			
			//planet generator
			_universeMachine = new UniverseMachine("XXX");
			var planetsAndStuff:Vector.<PlanetData> = _universeMachine.getPlanetDatasForFrame(new Rectangle(100, 100, 200, 200));

			_keyController = new KeyStarfieldController(_starfield);
			
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