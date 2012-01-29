package comps
{
	import datas.PlanetData;

	public class Johnny
	{
		
		private static var _me:Johnny;
		
		public function get maxGreen():Number
		{
			return _maxGreen;
		}

		public function set maxGreen(value:Number):void
		{
			_maxGreen = value;
		}

		public function get maxRed():Number
		{
			return _maxRed;
		}

		public function set maxRed(value:Number):void
		{
			_maxRed = value;
		}

		public function get maxBlue():Number
		{
			return _maxBlue;
		}

		public function set maxBlue(value:Number):void
		{
			_maxBlue = value;
		}

		public static function get me():Johnny {
			if (!_me) _me = new Johnny();
			return _me;
		}
		
		public function Johnny()
		{
		}
		
		
		public function devourPlanet(planetData:PlanetData):void {
			red = planetData.RGB.x;
			green = planetData.RGB.y;
			blue = planetData.RGB.z;
		}
		
		private var _green:Number = 5;
		private var _red:Number = 5;
		private var _blue:Number = 5;
		
		private var _maxGreen:Number = 10;
		private var _maxRed:Number = 10;
		private var _maxBlue:Number = 10;

		public function get green():Number
		{
			return _green;
		}

		public function set green(value:Number):void
		{
			_green = value;
		}

		public function get red():Number
		{
			return _red;
		}

		public function set red(value:Number):void
		{
			_red = value;
		}

		public function get blue():Number
		{
			return _blue;
		}

		public function set blue(value:Number):void
		{
			_blue = value;
		}

	}
}