package comps
{
	import core.Element;
	import core.Lapse;
	
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
			trace("rotation speed = " + _data.rotationSpeed);
			_data.dgRotation += _data.rotationSpeed*Math.PI/180;
			
			var rotationalFriction:Number = Config.JOHNNY_DGROTATE_DECEL*Lapse.dt;
			if (_data.rotationSpeed > rotationalFriction)
				_data.rotationSpeed -= rotationalFriction;
			if (_data.rotationSpeed < -rotationalFriction)
				_data.rotationSpeed += rotationalFriction;
			if (_data.rotationSpeed <= rotationalFriction && _data.rotationSpeed >= -rotationalFriction)
				_data.rotationSpeed = 0;
			
			var velocity:Point = new Point(Math.cos(_data.dgRotation), -Math.sin(_data.dgRotation));
			velocity.normalize(_data.magnitude);
			_data.position = _data.position.add(velocity);
			burnRed(Config.FRAME_FREQUENCY*Config.JOHNNY_RED_RESOURCE_PER_SECOND);
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
			if ( amount < _data.green) {
				var lessGreen:Vector3D = new Vector3D(0, -amount, 0);
				_data.addResources(lessGreen);
//				_data.resources.y -= amount;
				return true;
			}
			return false;
		}
		
		public function moveLeft(e:JohnnyEvent):void {
			_data.rotationSpeed += Config.JOHNNY_DGROTATE_ACCEL * Lapse.dt;
			var burn:Number = Lapse.dt * Config.JOHNNY_GREEN_RESOURCE_PER_SECOND;
			if (burnGreen(burn)) {
				trace("Rotate Ship Left:  " + _data.dgRotation + "(" + _data.rotationSpeed + " degrees)" );
			}
			else {
//				trace("Rotate Ship Left:  not enough fuel.");
			}
		}
		
		public function moveRight(e:JohnnyEvent):void {
			_data.rotationSpeed -= Config.JOHNNY_DGROTATE_ACCEL * Lapse.dt;
			var burn:Number = Lapse.dt * Config.JOHNNY_GREEN_RESOURCE_PER_SECOND;
			if (burnGreen(burn)) {
				trace("Rotate Ship Right:  " + _data.dgRotation + "(" + _data.rotationSpeed + " degrees)" );
			}
			else {
//				trace("Rotate Ship Right:  not enough fuel.");
			}
		}
		
		public function activateSonar(e:JohnnyEvent):void {
			trace("Activate Sonar");
		}
	}
}