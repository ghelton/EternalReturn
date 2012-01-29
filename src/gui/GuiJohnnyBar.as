package gui {

	import flash.display.Sprite;
	import flash.geom.ColorTransform;
	import flash.text.TextField;
	import flash.geom.Transform;
	
	public class GuiJohnnyBar extends Sprite {
		
		private var textField:TextField = new TextField();
		static public const expectedHeight:Number = 25;
		static public const expectedWidth:Number = 200;
		private var _label:String = "";
		private var backBar:Sprite = new Sprite();
		private var frontBar:Sprite = new Sprite();
		
		public function GuiJohnnyBar(color:uint, label:String) {
			_label = label;
			setValue(5,10);
			textField.textColor = 0xFFFFFF;
			addChild(textField);
			addChild(backBar);
			addChild(frontBar);
			
			var barSize:Number = 0.5;
			frontBar.graphics.beginFill(0xFFFFFF);
			backBar.graphics.beginFill(0x666666);
			frontBar.graphics.drawRect(0,0,barSize,8);
			backBar.graphics.drawRect(0,0,barSize,8);
			frontBar.graphics.endFill();		
			backBar.graphics.endFill();	
			
			frontBar.y = backBar.y = 5;
			frontBar.x = backBar.x = 45;
			
			var c:ColorTransform = new ColorTransform();
			c.color = color;
			var c2:ColorTransform = new ColorTransform(c.redOffset/255,c.greenOffset/255,c.blueOffset/255);
			(this as Sprite).transform.colorTransform = c2;
			
		}
		
		public function setValue(value:Number, maxValue:Number):void {
			textField.text = _label + value;
			frontBar.scaleX = value;
			backBar.scaleX = maxValue;
		}
	}
	
}