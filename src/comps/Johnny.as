package comps
{
	import core.Element;
	
	import datas.JohnnyData;
	import datas.PlanetData;
	
	import events.JohnnyEvent;
	
	import flash.geom.ColorTransform;
	import flash.geom.Point;
	import flash.geom.Vector3D;

	public class Johnny extends Element
	{
		private var _data:JohnnyData;
		private var _presentation:JohnnySwc;
		
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
			
			//this is our guy -- replace with swc?
			/*graphics.clear();
			var size:int = _resources.
			graphics.beginFill(0x000000);
			graphics.drawCircle(0, 0, 100);
			graphics.endFill();
			transform.colorTransform = new ColorTransform(1,1,1,1,_data.resources.x/max*255, _data.resources.y/max*255, _data.resources.z/max*255);
			*/
			
			_presentation = new JohnnySwc();
			addChild(_presentation);
			_presentation.scaleX = _presentation.scaleY = 0.3;
			
			_presentation.transform.colorTransform = new ColorTransform(1,1,1,1,_data.resources.x/max*255, _data.resources.y/max*255, _data.resources.z/max*255);
			
			rotation = -90;
			super.draw();
		}
		
		public function move():void
		{
//			trace("Move some shiz");
			burnRed(_data.magnitude);
		}
		
		public function burnRed(amount:Number):void {
			var lessRed:Vector3D = new Vector3D(-amount, 0, 0);
			_data.addResources(lessRed);
			if (_data.red < 0) {
				// die?
			}
		}
		
		// returns false if not enough green material to burn in which case, amount is not subtracted.
		public function burnGreen(amount:Number):Boolean {
			if ( amount >= _data.green) {
				var lessGreen:Vector3D = new Vector3D(0, -amount, 0);
				_data.addResources(lessGreen);
				return true;
			}
			return false;
		}
		
		public function moveLeft(e:JohnnyEvent):void {
			var dd:Number = Config.FRAME_FREQUENCY * Config.JOHNNY_DGROTATE_SPEED;
			_data.dgRotation -= dd;
			var burn:Number = Config.FRAME_FREQUENCY * Config.JOHNNY_GREEN_RESOURCE_PER_SECOND;
			if (burnGreen(burn)) {
				trace("Rotate Ship Left:  " + _data.dgRotation + "(-" + dd + " degrees, burn " + burn + ")" );
			}
			else {
				trace("Rotate Ship Left:  not enough fuel.");
			}
		}
		
		public function moveRight(e:JohnnyEvent):void {
			var dd:Number = Config.FRAME_FREQUENCY * Config.JOHNNY_DGROTATE_SPEED;
			_data.dgRotation += dd;
			var burn:Number = Config.FRAME_FREQUENCY * Config.JOHNNY_GREEN_RESOURCE_PER_SECOND;
			if (burnGreen(burn)) {
				trace("Rotate Ship Right:  " + _data.dgRotation + "(+" + dd + " degrees, burn " + burn + ")" );
			}
			else {
				trace("Rotate Ship Right:  not enough fuel.");
			}
		}
		
		public function activateSonar(e:JohnnyEvent):void {
			trace("Activate Sonar");
		}
	}
}