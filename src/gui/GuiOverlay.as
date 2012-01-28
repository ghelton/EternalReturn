package gui
{
	import comps.Johnny;
	
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class GuiOverlay extends Sprite
	{
		
		private var _johnny:Johnny;
		private var _red:GuiJohnnyBar = new GuiJohnnyBar(0xFF0000, "r: ");
		private var _blue:GuiJohnnyBar = new GuiJohnnyBar(0x00FF00, "b: ");
		private var _green:GuiJohnnyBar = new GuiJohnnyBar(0x0000FF, "g: ");
		
		public function GuiOverlay()
		{
//			graphics.beginFill(0x123123);
//			graphics.drawRect(0,0,100,100);
//			graphics.endFill();
			super();
			
			_johnny = Johnny.me;
			addEventListener(Event.ADDED_TO_STAGE, updateSize, false, 0, true);
			addEventListener(Event.ENTER_FRAME, updateScreen, false, 0, true);
			
			addChild(_red);
			addChild(_blue);
			addChild(_green);
			
			_green.y = GuiJohnnyBar.expectedHeight;
			_blue.y = GuiJohnnyBar.expectedHeight*2;
		}
		
		public function updateScreen(...skip):void {
			_red.setValue(_johnny.red);
			_blue.setValue(_johnny.blue);
			_green.setValue(_johnny.green);
		}
		
		private function updateSize(...skip):void {
//			_red.y = stage.stageHeight - GuiJohnnyBar.expectedHeight *3;
//			_green.y = stage.stageHeight - GuiJohnnyBar.expectedHeight *2;
//			_blue.y = stage.stageHeight - GuiJohnnyBar.expectedHeight *1;
//			_red.x = _blue.x = _green.x = stage.stageWidth - GuiJohnnyBar.expectedWidth;
		}
	}
}
