package gui
{
	import core.Element;
	
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
		
		override protected function draw():void {
			var rotation:Number = _johnnyData.dgRotation ;
			var pos:Point = Point.polar(100,rotation);
			var dist:int = Math.floor(_johnnyData.position.length)
			label.text = dist + "p";
			label.textColor = 0xFFFFFF;
			label.x = pos.x + stage.stageWidth * 0.5;
			label.y = pos.y + stage.stageHeight * 0.5;
//			trace("rot: " + rotation + ", pos: " + pos + ", dist: " + dist);
			
			
//			var startScreenPoint:Point;
//			var endScreenPoint:Point;
//			var p:Point;
//			
//			graphics.lineStyle(2, 0xFFFFFF);
//			graphics.moveTo(startScreenPoint.x, startScreenPoint.y);
//			graphics.lineTo(endScreenPoint.x, endScreenPoint.y);
//			graphics.lineTo(p.x,p.y);
			
			
		}
	}
}