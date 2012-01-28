package datas
{
	import flash.geom.Point;

	public class PlanetQuadrantData
	{
		public var quad:Point;
		public var planets:Vector.<PlanetData>;
		public function PlanetQuadrantData($quad:Point, $planets:Vector.<PlanetData>)
		{
			quad = $quad;
			planets = $planets;
		}
	}
}