package datas
{
	import flash.geom.Point;
	import flash.geom.Vector3D;

	public class PlanetData
	{
		public var location:Point;
		public var RGB:Vector3D;
		public var discovered:Boolean;
		
		public function PlanetData($startLocation:Point, $RGB:Vector3D, $discovered)
		{
			location = $startLocation;
			RGB = $RGB;
			discovered = $discovered;
		}
	}
}