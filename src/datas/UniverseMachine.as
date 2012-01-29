package datas
{
	import comps.Planet;
	
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.geom.Vector3D;
	import flash.utils.getTimer;
	
	import flashx.textLayout.formats.Float;

	public class UniverseMachine
	{
		private const lifeTimeOfItAll:int = 60000;
		private const quadrantSize:int = 500;
		private const distanceBetweenPlanetCornerSpots:int = 40;
		private var _quadrantCachePoolSize:int = 10000;
		private var _universeSeed:Number = 12345;
		private var _planetsDiscovered:Object;
		private var _cachedPlanetQuadrants:Vector.<PlanetQuadrantData> = new Vector.<PlanetQuadrantData>;
		private var _theBeginning:Number;
		private var _johnnyData:JohnnyData;
		
		public var spacialEntropyAdjustment:Number = 1;
		
		public function UniverseMachine(seed:int, johnnyData:JohnnyData)
		{
			_theBeginning = getTimer();
			_universeSeed = seed;
			_johnnyData = johnnyData;
			//fetch shared object, set _planetsDiscovered to object sharedObject.seedName
		}
		
		public function markPlanetAsDiscovered(uid:String):void
		{
//			sharedObject._universeSeed.uid = true;			
		}
		
		
		
		
		public function getPlanetDatasForFrame(frame:Rectangle) : Vector.<PlanetData>
		{
			var xQuad:Number;
			var yQuad:Number;
			var localCoordinate:Point;
			var planet:PlanetData;
			var returnPlanets:Vector.<PlanetData> = new Vector.<PlanetData>;
			var planetsFromQuad:Vector.<PlanetData> = new Vector.<PlanetData>;

			var midPoint:Point = new Point((frame.right + frame.left) / 2, (frame.top + frame.bottom) / 2);
			var distanceEntropyFactor:Number = .5 + (1 / (2 + (midPoint.length / 10000)));
//OLD
			var timeEntropyFactor:Number = .75 + (.5 * Math.cos((getTimer() - _theBeginning) / 10000));
			spacialEntropyAdjustment = timeEntropyFactor * distanceEntropyFactor + _johnnyData.entropyModifier;
//			trace(spacialEntropyAdjustment);
//NEW
//			var timeEntropyFactor:Number = 3 * Math.sin((getTimer() - _theBeginning) / lifeTimeOfItAll);
//			spacialEntropyAdjustment = Math.abs(timeEntropyFactor * distanceEntropyFactor + _johnnyData.entropyModifier);
			

			var adjustedFrame:Rectangle = dialateSpaceWithTimeAndFrame(frame, spacialEntropyAdjustment);
			var count:Number = 0;
			var quad:Point;
//			trace(timeEntropyFactor);
//			trace(adjustedFrame.left + "   " + adjustedFrame.top + "   " + adjustedFrame.right +  "   " + adjustedFrame.bottom);
			for(xQuad = Math.floor(adjustedFrame.left / quadrantSize); xQuad <= Math.ceil(adjustedFrame.right / quadrantSize); xQuad++)
			{
//				if(Math.abs(xQuad * quadrantSize) > 10000) continue;
				for(yQuad = Math.floor(adjustedFrame.top / quadrantSize); yQuad <= Math.ceil(adjustedFrame.bottom / quadrantSize); yQuad++)
				{
//					if(Math.abs(yQuad * quadrantSize) > 10000) continue;

					quad = new Point(xQuad, yQuad);
					count++;
					planetsFromQuad = getPlanetsInQuadrant(quad);
					for each(planet in planetsFromQuad)
					{
						if(planet.location.x >= adjustedFrame.left && planet.location.x <= adjustedFrame.right && planet.location.y >= adjustedFrame.top && planet.location.y <= adjustedFrame.bottom)
							returnPlanets.push(planet);
					}
				}
			}
			_quadrantCachePoolSize = count * 3;
			
			midPoint = new Point((adjustedFrame.right + adjustedFrame.left) / 2, (adjustedFrame.top + adjustedFrame.bottom) / 2);
			for each(planet in returnPlanets)
			{
				localCoordinate = planet.location.subtract(midPoint);
				planet.screenPosition = new Point(localCoordinate.x * (1 / spacialEntropyAdjustment), localCoordinate.y * (1 / spacialEntropyAdjustment));
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
			for(x = quadrantSize * quad.x; x < quadrantSize * (quad.x + 1); x += distanceBetweenPlanetCornerSpots)
			{
				for(y = quadrantSize * quad.y; y < quadrantSize * (quad.y + 1); y += distanceBetweenPlanetCornerSpots)
				{
					returnPlanet = getPlanetAtPixel(new Point(x, y));
					if(returnPlanet != null)
						returnPlanets.push(returnPlanet);
				}
			}
			planetQuadrantData = new PlanetQuadrantData(quad, returnPlanets);
			for(var index:int = 0; index < _cachedPlanetQuadrants.length; index++)
			{
				if(_cachedPlanetQuadrants[index].quad.equals(quad))
				{
					_cachedPlanetQuadrants.splice(index, 1);
					break;
				}
			}
			_cachedPlanetQuadrants.push(planetQuadrantData);
			if(_cachedPlanetQuadrants.length > _quadrantCachePoolSize)
			{
				trace("had to throw some out");
				_cachedPlanetQuadrants.splice(0, Math.floor(_quadrantCachePoolSize * 2/3));
			}
				
				
			return returnPlanets;
		}
		
		private function getPlanetAtPixel(pixel:Point) : PlanetData
		{
//			if(pixel.length >= 10000) return null;
			var rValue:int = (_universeSeed + pixel.x) % 3 + 1;
			var gValue:int = (_universeSeed + pixel.y) % 3 + 1;
			var bValue:int = (_universeSeed + pixel.x + pixel.y) % 3 + 1;
			if(Math.abs(noise(pixel)) % 97 == 0)
				return new PlanetData(pixel, new Vector3D(rValue, gValue, bValue), Math.random() > .5, new Point());
			else
				return null;
//			magic function to determine IF a planet is there, the RGB value if so, and return
		}
		
		private function dialateSpaceWithTimeAndFrame(frame:Rectangle, entropyFactor:Number) : Rectangle
		{
			var newFrame:Rectangle = new Rectangle();
			newFrame.left = frame.left * entropyFactor;
			newFrame.top = frame.top * entropyFactor;
			newFrame.right = frame.right * entropyFactor;
			newFrame.bottom = frame.bottom * entropyFactor;
			return newFrame;
		}
		
		private function hash32shift(key:Number) : Number
		{
			key = ~key + (key << 15);
			key = key ^ (key >>> 12);
			key = key + (key << 2);
			key = key ^ (key >>> 4);
			key = key * 2057;
			key = key ^ (key >>> 16);
			return key;
		}
		
		private function noise(pixel:Point) : Number
		{
			return hash32shift(_universeSeed + hash32shift(pixel.x + hash32shift(pixel.y)));
		}
	}
}