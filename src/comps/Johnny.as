package comps
{
	import core.Element;
	
	import datas.PlanetData;
	
	import flash.geom.ColorTransform;
	import flash.geom.Vector3D;

	public class Johnny extends Element
	{
		private var _resources:Vector3D;
		public function Johnny(startingValues:Vector3D)
		{
			_resources = startingValues;
		}
		
		public function devourPlanet(planetData:PlanetData):void {
			_resources.add(planetData.RGB);
		}		
		
		override protected function draw():void
		{
			var max:Number = Math.max(_resources.x, _resources.y, _resources.z);
			_resources.scaleBy(20);
//			var size:int = _resources.
			graphics.clear();
			graphics.beginFill(0x000000);
			graphics.drawCircle(0, 0, 100);
			graphics.endFill();
			transform.colorTransform = new ColorTransform(1,1,1,1,_resources.x/max*255, _resources.y/max*255, _resources.z/max*255);
			super.draw();
		}

		public function get green():Number
		{
			return _resources.y;
		}

		public function get red():Number
		{
			return _resources.x;
		}

		public function get blue():Number
		{
			return _resources.z;
		}
	}
}