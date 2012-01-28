package datas
{
	import comps.Planet;
	
	import flash.geom.Point;
	import flash.geom.Rectangle;

	public class UniverseMachine
	{
		private var _planetsDiscoveredSeed:String = '';
		private var _planetsDiscovered:Object;
		
		public function UniverseMachine(seed:String)
		{
			_planetsDiscoveredSeed = seed;
			//fetch shared object, set _planetsDiscovered to object sharedObject.seedName
		}
		
		public function markPlanetAsDiscovered(location:Point):void
		{
			//set sharedObject.seedName.(Point.x + "_" + Point.y) = true;			
		}
		
		public function getPlanetDataForFrame(frame:Rectangle) : Vector<PlanetData>
		{
			
		}
	}
}