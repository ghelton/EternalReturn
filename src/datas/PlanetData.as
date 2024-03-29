package datas
{
	import flash.geom.Point;
	import flash.geom.Vector3D;

	public class PlanetData
	{
		public var uid:String;
		public var location:Point;
		public var screenPosition:Point;
		public var RGB:Vector3D;
		public var RGBOG:Vector3D;
		public var discovered:Boolean;
		
		public function PlanetData($startLocation:Point, $RGB:Vector3D, $discovered:Boolean, $screenPosition:Point)
		{
			location = $startLocation;
			RGB = RGBOG = $RGB;
			discovered = false;
			screenPosition = $screenPosition; 
			uid = location.x.toString() + "_" + location.y.toString();
		}
	}
}