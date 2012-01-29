package gui
{
	import core.Element;
	
	import flash.geom.Point;

	public class Arrow extends Element
	{
		private var start:Point = new Point();
		private var end:Point = new Point();
		private var curve:String = "None";
		private var headSideLength:Number;
		private var color:uint;
		private var lineThickness:Number;
		
		public function Arrow($start:Point=null, $end:Point=null, $color:uint=0xFFFFFF, $alpha:Number=1, $headSideLength:Number=12, $lineThickness:Number=2)
		{
			this.alpha = $alpha;
			headSideLength = $headSideLength;
			color = $color;
			lineThickness = $lineThickness;
			plot($start, $end);
		}
		
		/* Use null not overwrite a point */
		public function plot($start:Point=null, $end:Point=null, curveLeftRightOrNone:String="None"):void {
			if ($start)
				start = $start.clone();
			if ($end)
				end = $end.clone();
			
			switch (curveLeftRightOrNone) {
				case "None":
				case "Left":
				case "Right":
					curve = curveLeftRightOrNone;
					break;
				default:
					throw new Error("curveLeftRightOrNone must be of value 'Left', 'Right', or 'None'.  Got " + curveLeftRightOrNone + ".");
			}
			redraw();
		}
		
		override protected function draw():void {
			x = start.x;
			y = start.y;
			var dp:Point = end.clone().subtract(start);
			graphics.lineStyle(lineThickness,color,1);
			graphics.moveTo(0,0);
			switch (curve) {
				case "None":
					graphics.lineTo(dp.x, dp.y);
					break;
				case "Left":
					graphics.lineTo(dp.x, dp.y);
					break;
				case "Right":
					graphics.lineTo(dp.x, dp.y);
					break;
			}
			
			var headBackAngleFactor:Number = 0.82;
			var angle:Number = Math.atan2(dp.y,dp.x);
			var corner1:Point = Point.polar(headSideLength,angle-Math.PI*headBackAngleFactor).add(dp);
			var corner2:Point = Point.polar(headSideLength,angle+Math.PI*headBackAngleFactor).add(dp);
			graphics.lineTo(corner1.x, corner1.y);
			graphics.moveTo(dp.x,dp.y);
			graphics.lineTo(corner2.x, corner2.y);
			
		}
	}
}