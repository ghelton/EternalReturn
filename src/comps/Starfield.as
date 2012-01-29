package comps
{
	import core.ChunkyBitmap;
	import core.Element;
	
	import datas.JohnnyData;
	import datas.PlanetData;
	import datas.UniverseMachine;
	
	import flash.display.BitmapData;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.Dictionary;

	public class Starfield extends Element
	{
		private var _johnnyData:JohnnyData;
		private var _size:Point;
		private var _bufferedSize:Number;
		private var _maxViewArea:Number;
		private var _universeMachine:UniverseMachine;
		private var _lastPos:Point;
		private var _activePlanets:Dictionary = new Dictionary();
		private var _currentPlanetData:Vector.<PlanetData>;
		private var _pooledPlanets:Vector.<Planet> = new Vector.<Planet>();
		private var _parallaxLayers:Vector.<ChunkyBitmap>;
		
		public function Starfield($fieldWidth:Number, $fieldHeight:Number, $universeMachine:UniverseMachine, $johnnyData:JohnnyData)
		{
			_johnnyData = $johnnyData;
			updateSizes($fieldWidth, $fieldHeight);
			_universeMachine = $universeMachine;
			super();
		}
		
		override protected function init(e:Event):void
		{
			super.init(e);
			_parallaxLayers = new Vector.<ChunkyBitmap>();
			var bitmaps:Vector.<BitmapData> = new <BitmapData>[new StarMap1(), new StarMap2(), new StarMap3(), new StarMap4()];
			var cb:ChunkyBitmap;
			var bd:BitmapData;
			var bufferedLocOffset:Number = _bufferedSize / 2;
			var rect:Rectangle = new Rectangle(-bufferedLocOffset, -bufferedLocOffset, _bufferedSize, _bufferedSize);
			for each(bd in bitmaps)
			{
				cb = new ChunkyBitmap(rect, bd);
				addChild(cb);
			}
		}
		
		override protected function draw():void
		{
			var locOffset:Number = _maxViewArea / 2;
			var bufferedLocOffset:Number = _bufferedSize / 2;
			graphics.beginFill(0x000000);
			graphics.drawRect(-bufferedLocOffset, -bufferedLocOffset, _bufferedSize, _bufferedSize);
			graphics.endFill();
			super.x = _size.x / 2;
			super.y = _size.y / 2;
		}
		
		private function updateSizes($fieldWidth:uint, $fieldHeight:uint):void
		{
			_size = new Point($fieldWidth, $fieldHeight);
			_maxViewArea = Math.max(_size.x, _size.y); 
			_bufferedSize = Math.SQRT2 * _maxViewArea;
			var cb:ChunkyBitmap;
			for each(cb in _parallaxLayers)
			{
				cb.setSize(_bufferedSize, _bufferedSize);
			}
		}
		
		public function resize($fieldWidth:uint, $fieldHeight:uint):void
		{
			updateSizes($fieldWidth, $fieldHeight);
			redraw();
			updateField();
		}
		
		override public function set rotation(value:Number):void
		{
			super.rotation = value; /// maybe tween this
		}
		
		public function updateField():void
		{
			_lastPos = _johnnyData.position.clone();
			var position:Point = _johnnyData.position;
			rotation = _johnnyData.dgRotation * (180 / Math.PI) - 90;
			//update parallax
			var cb:ChunkyBitmap;
			var multiplier:int = 1;
			for each(cb in _parallaxLayers)
			{
				cb.x = position.x * multiplier;
				cb.y = position.y * multiplier;
				multiplier++;
			}
//			return;
			// update planets
			var xPos:Number = position.x - (_maxViewArea / 2) - Config.STARFIELD_BUFFER;
			var yPos:Number = position.y - (_maxViewArea / 2) - Config.STARFIELD_BUFFER;
			var planets:Vector.<PlanetData> = _universeMachine.getPlanetDatasForFrame(new Rectangle(xPos, yPos, _bufferedSize, _bufferedSize));
			var planet:Planet;
			var planetData:PlanetData;
			
			//remove planets that are no longer in the list and put them in the pool
			var foundPlanet:Boolean = false;
			for(var key:String in _activePlanets)
			{
				foundPlanet = false;
				for each(planetData in planets)
				{
					if(planetData.uid == key)
					{
						foundPlanet = true;
						break;
					}
				}
				if(!foundPlanet)
				{
					planet = _activePlanets[key];
					_pooledPlanets.push(planet);
					removeChild(planet);
					_activePlanets[key] = null;
					delete _activePlanets[key];
				}
			}
			
			//create new planets and update existing planets
			for each(planetData in planets)
			{
				planet = _activePlanets[planetData.uid];
				if(planet == null)
				{
					if(_pooledPlanets.length > 0)
					{
						planet = _pooledPlanets.pop();
						planet.updateData(planetData);
					} else {
						planet = new Planet(planetData);
					}
					_activePlanets[planetData.uid] = planet;
					addChild(planet);
				}
				planet.x = planetData.screenPosition.x;
				planet.y = planetData.screenPosition.y;
			}
		}
	}
}