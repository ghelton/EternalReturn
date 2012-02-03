package gui
{
	import core.Element;
	import flash.text.TextFieldAutoSize;
	
	import datas.JohnnyData;
	
	import flash.events.Event;
	import flash.geom.Point;
	import flash.text.TextField;

	public class GuiDistanceGauge extends Element
	{
		
		private var _johnnyData:JohnnyData; 
		private var label:TextField = new TextField();
		
		public function GuiDistanceGauge($johnnyData:JohnnyData)
		{
			_johnnyData = $johnnyData;
			addChild(label);
		}
		
		public function update(...skip):void {
			redraw();
		}
		
		private function stringify(item:*):String {
			if (item is Point)
				return "(" + int(item.x) + ", " + int(item.y) +")";
				
			if (item is Number) {
				var i:int = item;
				return i + "." + Math.abs((int(Math.round((item - i) * 100))));
			}
				
				
			return String(item);
		}
		private function strace(...values):String {
			var str:String = "";
			for each (var value:* in values) {
				str += stringify(value);
			}
			trace(str);
			return str;
		}
		
		override protected function draw():void {
			var rotation:Number = _johnnyData.dgRotation ;  // up is 1.57.  right is 0.
			var spaceCoord:Point = _johnnyData.position;  			// up is -1.57.  right is 0.
			//var angleToOrigin:Number = Math.asin(spaceCoord.y / spaceCoord.length);
			var dist:int = _johnnyData.position.length;
			
			//var originScreenPos:Point = Point.polar(spaceCoord.length, Math.atan2(spaceCoord.y, spaceCoord.x) - rotation - Math.PI * 0.5);
			var angleToOrigin:Number = Math.atan2(spaceCoord.y, spaceCoord.x) + rotation + Math.PI * 0.5;
			
			var gaugePos:Point = Point.polar(100,angleToOrigin);  // down is 1.57.  right is 0.  up is -1.57
			
			label.text = dist + "p";
			label.autoSize = TextFieldAutoSize.CENTER;
			label.textColor = 0xFFFFFF;
			label.x = gaugePos.x + stage.stageWidth * 0.5 - label.width*0.5;
			label.y = gaugePos.y + stage.stageHeight * 0.5 - label.height*0.5;
			
			
			//strace("origin screen coord: ", originScreenPos );
			//strace("ship rot: ", rotation, ", dist: ", dist, ", pos: ", spaceCoord, "(", angleToOrigin, ")");
//			trace("rot: " + rotation + ", pos: " + pos + ", dist: " + dist);
			
		}
	}
}