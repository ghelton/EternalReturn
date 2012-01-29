package datas
{
	import flash.geom.Point;
	import flash.geom.Vector3D;

	public class PlanetData
	{
		private static var count:int = 0;
		public var uid:String;
		public var location:Point;
		public var screenPosition:Point;
		public var RGB:Vector3D;
		public var discovered:Boolean;
		
		public function PlanetData($startLocation:Point, $RGB:Vector3D, $discovered:Boolean, $screenPosition:Point)
		{
			count++;
//			trace("there are now this many Planet Datas" + count);
			location = $startLocation;
			RGB = $RGB;
			discovered = $discovered;
			screenPosition = $screenPosition; 
			uid = location.x.toString() + "_" + location.y.toString();
		}
	}
}