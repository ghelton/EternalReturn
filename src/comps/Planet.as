package comps
{
	import core.Element;
	
	import datas.PlanetData;
	
	import flash.events.Event;
	import flash.geom.ColorTransform;

	public class Planet extends Element
	{
		private var _planetData:PlanetData;
		private var _planetSWC:PlanetSWC;
		
		public function Planet($planetData:PlanetData)
		{
			_planetData = $planetData;
			super();
		}
		
		public function updateData($planetData:PlanetData):void
		{
			_planetData = $planetData;
			draw();
		}
		
		override protected function init(e:Event):void
		{
			super.init(e);
			_planetSWC = new PlanetSWC();
		}
		
		override protected function addedToStage(e:Event):void
		{
			super.addedToStage(e);
			addChild(_planetSWC);
		}

		override protected function removedFromStage(e:Event):void
		{
			super.removedFromStage(e);
			removeChild(_planetSWC);
		}
		

		override protected function draw():void
		{
			var max:Number = Math.max(_planetData.RGB.x, _planetData.RGB.y, _planetData.RGB.z);
			var size:int = _planetData.RGB.x + _planetData.RGB.y + _planetData.RGB.z;
			_planetSWC.scaleX = _planetSWC.scaleY = size/12;
			_planetSWC.transform.colorTransform = new ColorTransform(1,1,1,1,_planetData.RGB.x/max*255, _planetData.RGB.y/max*255, _planetData.RGB.z/max*255);
			super.draw();
		}
	}
}