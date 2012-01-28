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
		
		public function GuiJohnnyBar(color:uint, label:String) {
			_label = label;
			setValue(0);
			addChild(textField);
			var c:ColorTransform = new ColorTransform();
			c.color = color;
			(this as Sprite).transform.colorTransform = c;
			
		}
		
		public function setValue(value:Number):void {
			textField.text = _label + value;
		}
	}
	
}