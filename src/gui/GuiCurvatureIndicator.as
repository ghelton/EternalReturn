package gui
{
	import core.Element;
	
	import datas.JohnnyData;
	import flash.geom.Point;

	public class GuiCurvatureIndicator extends Element
	{
		private var arrow:Arrow;
		private var stageWidth:Number;
		private var stageHeight:Number;
		private var johnnyData:JohnnyData;
		private var leftStart:Point;
		private var rightStart:Point;
		private var screenY:Number;
		private var lengthPerRadian:Number = 3;
		
		public function GuiCurvatureIndicator($stageWidth:Number, $stageHeight:Number, $johnnyData:JohnnyData) {
			stageWidth = $stageWidth;
			stageHeight = $stageHeight;
			johnnyData = $johnnyData;
			
			screenY = stageHeight*0.5-50
			var screenX:Number = stageWidth*0.5;
			var offX:Number = 50;
			leftStart = new Point(screenX - offX, screenY);
			rightStart = new Point(screenX + offX, screenY);
			
			arrow = new Arrow(null,null,0xFFFFFF,0.7,8,1);
			arrow.visible = false;
			addChild(arrow);
		}
		
		public function update():void {
			draw();
		}
		
		override protected function draw():void {
			var da:Number = johnnyData.rotationChange;  
			if (da <= Math.PI*0.1 && da >= Math.PI*-0.1) {
				arrow.visible = false;
				return;
			}
			arrow.visible = true;
			if (da > 0) {
				arrow.plot(leftStart, new Point(leftStart.x - da*lengthPerRadian, leftStart.y));
			}
			else {
				arrow.plot(rightStart, new Point(rightStart.x - da*lengthPerRadian, rightStart.y));
			}
		}
	}
}