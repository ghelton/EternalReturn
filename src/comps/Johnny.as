package comps
{
	import core.AnimationEvent;
	import core.Element;
	import core.Lapse;
	
	import datas.JohnnyData;
	import datas.PlanetData;
	
	import events.JohnnyEvent;
	
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.geom.ColorTransform;
	import flash.geom.Point;
	import flash.geom.Vector3D;

	public class Johnny extends Element
	{
		private var _data:JohnnyData;
		private var _pulse:MovieClip;
		private var _presentation:JohnnySprite;
		
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
			
			_presentation = new JohnnySprite();
			addChild(_presentation);
			_presentation.scaleX = _presentation.scaleY = 0.3;
			

			rotation = -90;
			super.draw();
		}
		
		public function move():void
		{
			if(_data.magnitude != 0)
			{
//				trace("_data.rotationChange",_data.rotationChange);
				_data.dgRotation += _data.rotationChange / 100;
				var velocity:Point = new Point(Math.cos(_data.dgRotation), -Math.sin(_data.dgRotation));
				velocity.normalize(_data.magnitude);
				_data.position = _data.position.add(velocity);
				burnRed(Config.FRAME_FREQUENCY*Config.JOHNNY_RED_RESOURCE_PER_SECOND);
				var speed:Number;
				if(_data.red > 300)
					speed = 20;
				if(_data.red > 100 && _data.red <= 300)
					speed = 15;
				if(_data.red <= 100)
					speed = 10;
				_data.magnitude = speed;
				//_presentation.move();
			}
			
			var rgb:Vector3D = _data.resources.clone();
			var max:Number = Math.max(rgb.x,rgb.y,rgb.z);

			_presentation.transform.colorTransform = new ColorTransform(0.5,0.5,0.5,1,rgb.x/max*64+64, rgb.y/max*64+64, rgb.z/max*64+64);
		}
		
		public function setSprite():void
		{
			
				
		}
		
		public function openMaw(e:Event):void
		{
			_presentation.openMaw();
		}
		
		public function closeMaw(e:Event):void
		{
			_presentation.closeMaw();
		}
		
		public function onFrame():void
		{
			move();
			if(_data.entropyModifier > 0)
			{
				_data.entropyModifier -= 0.001;
				if(_data.entropyModifier < 0)
					_data.entropyModifier = 0;
			}
		}

		public function launch(e:Event):void
		{
			if(_data.red > 0)
				_data.magnitude = Math.sqrt(_data.red);
		}
		
		public function bluePower(e:Event):void
		{
			if(_data.blue >= Config.JOHNNY_BLUE_RESOURCE_PER_SECOND)
			{
				_data.addResources(new Vector3D(0, 0, -1 * Config.JOHNNY_BLUE_RESOURCE_PER_SECOND));
				_data.entropyModifier += 0.1;
				activateSonar();
			}
		}
		
		private function activateSonar():void {
			if(_pulse == null)
			{
				_pulse = new PulseProbe();
				addChild(_pulse);
				_pulse.addEventListener(AnimationEvent.ANIMATION_KILL, onKillPulse);
			}
		}
		
		private function onKillPulse(e:Event):void
		{
			removeChild(_pulse);
			_pulse = null;
		}
		
		public function burnRed(amount:Number):void {
			
			
			trace("_data.red",_data.red);
			if (_data.red <= 1) {
				trace("death");
				_data.magnitude = 0;
				amount = _data.red;
				_presentation.die();
				activateSonar();
			}
			var lessRed:Vector3D = new Vector3D(-amount, 0, 0);
			_data.addResources(lessRed);
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

			
			if(_data.rotationChange <= Config.MAX_ROTATION)
			{
				var burn:Number = Config.FRAME_FREQUENCY * Config.JOHNNY_GREEN_RESOURCE_PER_SECOND;
				if (_data.rotationChange <= 0.01)
					burn *= 0.5;
				
				var hasEnoughFuel:Boolean = burnGreen(burn);
			
				// no fuel, reduce turn by half
				var multiplier:Number = (hasEnoughFuel ? 1 : 0.5);
				
				// on planet, double turn speed(and hence also efficiency, total 4x w/ other efficiency tweak)
				if (_data.rotationChange <= 0.01)
					multiplier *= 2;
				
				_data.rotationChange += Config.FRAME_FREQUENCY * Config.JOHNNY_DGROTATE_ACCEL * multiplier;
				_presentation.turn(_data.rotationChange);
			}
		}
		
		public function moveRight(e:JohnnyEvent):void {
			if(_data.rotationChange >= -Config.MAX_ROTATION)
			{
				var burn:Number = Config.FRAME_FREQUENCY * Config.JOHNNY_GREEN_RESOURCE_PER_SECOND;
				if (_data.rotationChange <= 0.01)
					burn *= 0.5;
				
				var hasEnoughFuel:Boolean = burnGreen(burn);
				
				// no fuel, reduce turn by half
				var multiplier:Number = (hasEnoughFuel ? 1 : 0.5);
				
				// on planet, double turn speed(and hence also efficiency)
				if (_data.rotationChange <= 0.01)
					multiplier *= 2;
				
				_data.rotationChange -= Config.FRAME_FREQUENCY * Config.JOHNNY_DGROTATE_ACCEL * multiplier;
				_presentation.turn(_data.rotationChange);

			}
		}
	}
}