package comps
{
	import core.Element;
	
	import datas.PlanetData;
	
	import events.JohnnyEvent;
	
	import flash.geom.ColorTransform;
	import flash.geom.Point;
	import flash.geom.Vector3D;

	public class Johnny extends Element
	{
		private var _resources:Vector3D;
		public var maxResourcesRGB:Vector3D = new Vector3D(600,600,600);
		public var magnitude:uint = 5;
		public var starfieldCoord:Point;  	// coordinates of johnny relative to the starfield
		public var dgRotation:Number; 		// rotation of johnny relative to the starfield
//		public var direction

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
		
		public function burnRed(amount:Number):void {
			_resources.x -= amount;
			if (_resources.x < 0) {
				// die?
			}
		}
		
		// returns false if not enough green material to burn in which case, amount is not subtracted.
		public function burnGreen(amount:Number):Boolean {
			if ( amount >= _resources.y) {
				_resources.y -= amount;
				return true;
			}
			return false;
		}
		
		public function moveLeft(e:JohnnyEvent):void {
			var dd:Number = Config.FRAME_FREQUENCY * Config.JOHNNY_DGROTATE_SPEED;
			dgRotation -= dd;
			var burn:Number = Config.FRAME_FREQUENCY * Config.JOHNNY_GREEN_RESOURCE_PER_SECOND;
			if (burnGreen(burn)) {
				trace("Rotate Ship Left:  " + dgRotation + "(-" + dd + " degrees, burn " + burn + ")" );
			}
			else {
				trace("Rotate Ship Left:  not enough fuel.");
			}
		}
		
		public function moveRight(e:JohnnyEvent):void {
			var dd:Number = Config.FRAME_FREQUENCY * Config.JOHNNY_DGROTATE_SPEED;
			dgRotation += dd;
			var burn:Number = Config.FRAME_FREQUENCY * Config.JOHNNY_GREEN_RESOURCE_PER_SECOND;
			if (burnGreen(burn)) {
				trace("Rotate Ship Right:  " + dgRotation + "(+" + dd + " degrees, burn " + burn + ")" );
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