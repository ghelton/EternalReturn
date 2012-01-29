package comps
{
	import core.Element;
	
	import datas.JohnnyData;
	import datas.PlanetData;
	
	import events.JohnnyEvent;
	
	import flash.geom.ColorTransform;
	import flash.geom.Vector3D;

	public class Johnny extends Element
	{
		private var _data:JohnnyData;
		
		public function Johnny($data:JohnnyData)
		{
			_data = $data;
		}
		
		public function devourPlanet(planetData:PlanetData):void {
			_data.addResources(planetData.RGB);
		}		

		override protected function draw():void
		{
			var max:Number = Math.max(_data.red, _data.green, _data.blue);
			_data.resources.scaleBy(20);
//			var size:int = _resources.
			graphics.clear();
			graphics.beginFill(0x000000);
			graphics.drawCircle(0, 0, 100);
			graphics.endFill();
			transform.colorTransform = new ColorTransform(1,1,1,1,_data.resources.x/max*255, _data.resources.y/max*255, _data.resources.z/max*255);
			super.draw();
		}
		
		public function move():void
		{
			trace("Move some shiz");
		}
		
		public function moveLeft(e:JohnnyEvent):void {
			trace("Rotate Ship Left");
		}
		
		public function moveRight(e:JohnnyEvent):void {
			trace("Rotate Ship Right");
		}
		
		public function activateSonar(e:JohnnyEvent):void {
			trace("Activate Sonar");
		}
	}
}