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
		private const lifeTimeOfItAll:int = 40000;
		private const quadrantSize:int = 500;
		private const distanceBetweenPlanetCornerSpots:int = 50;
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
			var distanceEntropyFactor:Number = 1 + (1 / (4 + (Math.sqrt(midPoint.length) / 100)));
//			var timeEntropyFactor:Number = 5 + (.25 * Math.cos((getTimer() - _theBeginning) / 5000)); //oscillating universe
			var timeEntropyFactor:Number = 1 / Math.log(Math.E + ((getTimer() - (_theBeginning + _johnnyData.timeShift)) / lifeTimeOfItAll));
			spacialEntropyAdjustment = timeEntropyFactor * distanceEntropyFactor;// * (1 + _johnnyData.entropyModifier);
//			trace("T: " + timeEntropyFactor.toFixed(3) + "   distance: " + distanceEntropyFactor.toFixed(3) + " mod: " + _johnnyData.entropyModifier.toFixed(3) + " (t X d X mod):" + (timeEntropyFactor * distanceEntropyFactor * (1 + _johnnyData.entropyModifier)).toFixed(3));

			var adjustedFrame:Rectangle = dialateSpaceWithTimeAndFrame(frame, spacialEntropyAdjustment);
			var count:Number = 0;
			var quad:Point;
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
//			returnPlanets.push(getPlanetAtPixel(new Point(0,0))); //"CENTER POINT" 
			
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
				_cachedPlanetQuadrants.splice(0, Math.floor(_quadrantCachePoolSize * 2/3));
			}
				
				
			return returnPlanets;
		}
		
		private function getPlanetAtPixel(pixel:Point) : PlanetData
		{
			var rValue:int = 0;
			var gValue:int = 0;
			var bValue:int = 0;
			var scale:int = (_universeSeed + pixel.x) % 3 + 1;
			switch((_universeSeed + pixel.y) % 7)
			{
				case 0:
					rValue = gValue = bValue = scale;
					break;
				case 1:
					rValue = gValue = scale;
					break;
				case 2:
					rValue = bValue = scale;
					break;
				case 3:
					gValue = bValue = scale;
					break;
				case 4:
					rValue = 2 * scale;
					break;
				case 5:
					gValue = 2 * scale;
					break;
				case 6:
					bValue = 2 * scale;
					break;
			}
			if(Math.abs(noise(pixel)) % 97 == 0 || (pixel.x == 0 && pixel.y == 0))
				return new PlanetData(pixel, new Vector3D(rValue, gValue, bValue), false, new Point());
			else
				return null;
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