package datas
{
	import comps.Planet;
	
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.geom.Vector3D;

	public class UniverseMachine
	{
		private const quadrantSize:int = 1000;
		private var _universeSeed:Number = 12345;
		private var _planetsDiscovered:Object;
		private var _cachedPlanetQuadrants:Vector.<PlanetQuadrantData>;
		
		public function UniverseMachine(seed:int)
		{
			_universeSeed = seed;
			_cachedPlanetQuadrants = new Vector.<PlanetQuadrantData>;
			//fetch shared object, set _planetsDiscovered to object sharedObject.seedName
		}
		
		public function markPlanetAsDiscovered(location:Point):void
		{
			//set sharedObject.seedName.(Point.x).(Point.y) = true;			
		}
		
		public function getPlanetDatasForFrame(frame:Rectangle) : Vector.<PlanetData>
		{
			var xQuad:Number;
			var yQuad:Number;
			
			var planet:PlanetData;
			var returnPlanets:Vector.<PlanetData> = new Vector.<PlanetData>;
			var planetsFromQuad:Vector.<PlanetData> = new Vector.<PlanetData>;
			
			for(xQuad = Math.floor(frame.left / quadrantSize); xQuad <= Math.ceil(frame.right / quadrantSize); xQuad++)
			{
				for(yQuad = Math.floor(frame.top / quadrantSize); yQuad <= Math.ceil(frame.bottom / quadrantSize); yQuad++)
				{
					planetsFromQuad = getPlanetsInQuadrant(new Point(xQuad, yQuad));
					for each(planet in planetsFromQuad)
					{
						if(planet.location.x >= frame.left && planet.location.x <= frame.right && planet.location.y >= frame.top && planet.location.y <= frame.bottom)
							returnPlanets.push(planet);
					}
				}
			}
			return returnPlanets;
		}
		
		private function getPlanetsInQuadrant(quad:Point) : Vector.<PlanetData>
		{
			var returnPlanet:PlanetData;
			var returnPlanets:Vector.<PlanetData> = new Vector.<PlanetData>();
			var planetQuadrantData:PlanetQuadrantData;
			var x:Number;
			var y:Number;
			
			for each(planetQuadrantData in _cachedPlanetQuadrants)
			{
				if(planetQuadrantData.quad.equals(quad))
					return planetQuadrantData.planets;
			}
			for(x = quadrantSize * quad.x; x < quadrantSize * (quad.x + 1); x++)
			{
				for(y = quadrantSize * quad.y; y < quadrantSize * (quad.y + 1); y++)
				{
					if((x * quadrantSize + y) % 99 == 0)
					{
						returnPlanet = getPlanetAtPixel(new Point(x, y));
						if(returnPlanet != null)
							returnPlanets.push(returnPlanet);
					}
				}
			}
			planetQuadrantData = new PlanetQuadrantData(quad, returnPlanets);
			for(var index:int = 0; index < _cachedPlanetQuadrants.length; index++)
			{
				if(_cachedPlanetQuadrants[index].quad == quad)
				{
					_cachedPlanetQuadrants.splice(index, 1);
					break;
				}
			}
			_cachedPlanetQuadrants.push(planetQuadrantData);
			if(_cachedPlanetQuadrants.length > 15)
				_cachedPlanetQuadrants.shift();
				
				
			return returnPlanets;
		}
		
		private function getPlanetAtPixel(pixel:Point) : PlanetData
		{
			if(Math.abs(noise(pixel)) % 100 == 0 || (pixel.x == 0 && pixel.y == 0))
				return new PlanetData(pixel, new Vector3D(0.2, 0.3, 0.4), Math.random() > .5);
			else
				return null;
//			magic function to determine IF a planet is there, the RGB value if so, and return
		}
		private function hash32shift(key:Number) : Number
		{
			key = ~key + (key << 15); // key = (key << 15) - key - 1;
			key = key ^ (key >>> 12);
			key = key + (key << 2);
			key = key ^ (key >>> 4);
			key = key * 2057; // key = (key + (key << 3)) + (key << 11);
			key = key ^ (key >>> 16);
			return key;
		}
		
		private function noise(pixel:Point) : Number
		{
			return hash32shift(_universeSeed + hash32shift(pixel.x + hash32shift(pixel.y)));
		}
	}
}