package comps
{
	import core.Element;
	
	import datas.PlanetData;

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
			var size:int = 5;
			graphics.beginFill(0xFFFFFF);
			graphics.drawCircle(-size, -size, size);
			graphics.endFill();
			super.draw();
		}
	}
}