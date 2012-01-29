package comps
{
	import core.Element;
	
	import datas.PlanetData;
	
	import flash.geom.ColorTransform;
	import flash.geom.Vector3D;

	public class Planet extends Element
	{
		private var _planetData:PlanetData;
		private var _planetSWC:PlanetSWC;
		
		public function Planet($planetData:PlanetData)
		{
			updateData($planetData);
			super();
		}
		
		public function updateData($planetData:PlanetData):void
		{
			_planetData = $planetData;
			draw();
		}
		
		override protected function draw():void
		{
			var max:Number = Math.max(_planetData.RGB.x, _planetData.RGB.y, _planetData.RGB.z);
			var size:int = _planetData.RGB.x + _planetData.RGB.y + _planetData.RGB.z;
			
			var rgb:Vector3D = _planetData.RGB.clone();
			rgb.x = (rgb.x < max * 0.75) ? 0 : 1;
			rgb.y = (rgb.y < max * 0.75) ? 0 : 1;
			rgb.z = (rgb.z < max * 0.75) ? 0 : 1;
			
			
			/*graphics.clear();
			graphics.beginFill(0x000000);
			graphics.drawCircle(0, 0, size);
			graphics.endFill();*/
			
			_planetSWC = new PlanetSWC();
			addChild(_planetSWC);
			_planetSWC.scaleX = _planetSWC.scaleY = size/12;
			
			// scaled just a bit darker than if used baseline y*0.5 + x*255 - 128
			_planetSWC.transform.colorTransform = new ColorTransform(0.4,0.4,0.4,1,rgb.x*204-102, rgb.y*204-102, rgb.z*204-102);
			super.draw();
		}
	}
}