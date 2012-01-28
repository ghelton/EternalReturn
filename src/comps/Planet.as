package comps
{
	import core.Element;
	
	import datas.PlanetData;
	
	import flash.geom.ColorTransform;

	public class Planet extends Element
	{
		private var _planetData:PlanetData;
		
		public function Planet($planetData:PlanetData)
		{
			_planetData = $planetData;
			super();
		}
		
		public function updateData($planetData:PlanetData):void
		{
			_planetData = $planetData;
		}
		
		override protected function draw():void
		{
			var size:int = 50;
			graphics.beginFill(0xFFFFFF);
			graphics.drawCircle(-size, -size, size);
			graphics.endFill();
			super.draw();
		}
	}
}