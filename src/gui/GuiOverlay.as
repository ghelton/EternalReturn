package gui
{
	import core.Element;
	
	import datas.JohnnyData;
	
	public class GuiOverlay extends Element
	{
		
		private var _johnnyData:JohnnyData;
		private var _red:GuiJohnnyBar = new GuiJohnnyBar(0xFF0000, "r: ");
		private var _blue:GuiJohnnyBar = new GuiJohnnyBar(0x00FF00, "b: ");
		private var _green:GuiJohnnyBar = new GuiJohnnyBar(0x0000FF, "g: ");
		
		public function GuiOverlay($johnnyData:JohnnyData)
		{
			super();
			
			_johnnyData = $johnnyData;
			
			
			addChild(_red);
			addChild(_blue);
			addChild(_green);
			
			var offset:Number = 5;
			_red.x = _blue.x = _green.x = offset;
			_red.y = offset;
			_green.y = GuiJohnnyBar.expectedHeight + offset;
			_blue.y = GuiJohnnyBar.expectedHeight*2 + offset;
			updateScreen();
		}
		
		public function updateScreen(...skip):void {
			_red.setValue(_johnnyData.red, _johnnyData.maxResourcesRGB.x);
			_blue.setValue(_johnnyData.blue, _johnnyData.maxResourcesRGB.y);
			_green.setValue(_johnnyData.green, _johnnyData.maxResourcesRGB.z);
		}
		
		public function resize($newWidth:uint, $newHeight:uint):void
		{
			_red.y = stage.stageHeight - GuiJohnnyBar.expectedHeight *3;
			_green.y = stage.stageHeight - GuiJohnnyBar.expectedHeight *2;
			_blue.y = stage.stageHeight - GuiJohnnyBar.expectedHeight *1;
			_red.x = _blue.x = _green.x = stage.stageWidth - GuiJohnnyBar.expectedWidth;
		}
	}
}

