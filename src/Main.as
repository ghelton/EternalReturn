package
{
	import comps.Johnny;
	import comps.Starfield;
	
	import core.BasicController;
	import core.JohnnyKeyController;
	import core.Lapse;
	
	import datas.JohnnyData;
	import datas.PlanetData;
	import datas.UniverseMachine;
	
	import events.JohnnyEvent;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.FullScreenEvent;
	import flash.geom.Rectangle;
	import flash.geom.Vector3D;
	
	import gui.GuiCurvatureIndicator;
	import gui.GuiDistanceGauge;
	import gui.GuiOverlay;
	
	[SWF(width="760", height="630", version_major="10", frameRate="24")]
	public class Main extends Sprite
	{		
		private var _starfield:Starfield;
		private var _universeMachine:UniverseMachine;
		private var _keyController:JohnnyKeyController;
		private var _johnny:Johnny;
		private var _johnnyData:JohnnyData;
		private var _guiOverlay:GuiOverlay;
		private var _guiDistanceGauge:GuiDistanceGauge;
		private var _guiCurvatureIndicator:GuiCurvatureIndicator;
		
		public function Main()
		{
			trace('Eternal Return Bitches! Global Game Jam 2012! Best Game Out of 50 Cubes!');
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, appAdded);
			BasicController.setControlLayer(this.stage);
		}
		
		private function appAdded(e:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, appAdded);
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			stage.addEventListener(FullScreenEvent.FULL_SCREEN, onFullScreen);
			
			_johnnyData = new JohnnyData(Config.STARTING_POINT, Config.STARTING_RESOURCES, Config.BASE_MAGNITUDE);
			_johnny = new Johnny(_johnnyData);
			_universeMachine = new UniverseMachine(1234567, _johnnyData);
			_starfield = new Starfield(stage.stageWidth, stage.stageHeight, _universeMachine, _johnnyData);
			
			_johnny.x = stage.stageWidth / 2;
			_johnny.y = stage.stageHeight / 2;

			_keyController = new JohnnyKeyController();
			_keyController.addEventListener(JohnnyEvent.JOHNNY_LEFT, _johnny.moveLeft);
			_keyController.addEventListener(JohnnyEvent.JOHNNY_RIGHT, _johnny.moveRight);
			_keyController.addEventListener(JohnnyEvent.JOHNNY_LAUNCH, _johnny.launch);
			_keyController.addEventListener(JohnnyEvent.JOHNNY_BLUE_POWER, _johnny.bluePower);
			_starfield.addEventListener(JohnnyEvent.JOHNNY_OPEN_MAW, _johnny.openMaw);
			_starfield.addEventListener(JohnnyEvent.JOHNNY_CLOSE_MAW, _johnny.closeMaw);
			_guiOverlay = new GuiOverlay(_johnnyData);
			_guiDistanceGauge = new GuiDistanceGauge(_johnnyData);
			_guiCurvatureIndicator = new GuiCurvatureIndicator(stage.stageWidth, stage.stageHeight, _johnnyData);
			
			//add children
			addChild(_starfield);
			addChild(_johnny);
			addChild(_guiOverlay); // overlay goes on top
			addChild(_guiDistanceGauge);
			addChild(_guiCurvatureIndicator);
			
			// end init stuff //
			
			//at the end of the function
			stage.addEventListener(Event.RESIZE, resizeStage);
			stage.addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		private function onEnterFrame(e:Event):void
		{
			//delta time should be calculated before even johnny makes his move
			Lapse.calculateTime();
			
			//check keys also before moving johnny
			_keyController.checkKeys();
			
			//Johnny should move before anything else happens
			_johnny.onFrame();
			_guiOverlay.updateScreen();
			_guiDistanceGauge.update();
			_guiCurvatureIndicator.update();
			
			if(_johnnyData.red > 0)
				_starfield.updateField();
			else
				endGame();
		}
		
		private function endGame():void
		{
			stage.removeEventListener(Event.ENTER_FRAME, onEnterFrame);
			_keyController.pauseKeys();
		}
		
		private function resizeStage(e:Event):void {
			//do something
			_starfield.resize(stage.stageWidth, stage.stageHeight);
			_guiOverlay.resize(stage.stageWidth, stage.stageHeight);
		}
		
		private function onFullScreen(e:Event):void {
			//do something here too
		}
	}
}