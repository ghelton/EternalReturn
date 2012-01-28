package comps
{
	import core.Element;
	
	import datas.PlanetData;
	
	import flash.events.Event;
	import flash.geom.Point;
	import flash.utils.Dictionary;

	public class Starfield extends Element
	{
		private var _size:Point;
		private var _position:Point;
		private var _activePlanets:Dictionary = new Dictionary();
		private var _currentPlanetData:Vector.<PlanetData>;
		private var _pooledPlanets:Vector.<Planet> = Vector.<Planet>();
		
		public function Starfield($fieldWidth:uint, $fieldHeight:uint)
		{
			_size = new Point($fieldWidth, $fieldHeight);
			_position = new Point(0, 0);
			super();
		}
		
		override protected function init(e:Event):void 
		{
			super.init(e);
			addEventListener(Event.ENTER_FRAME, onFrame);
		}
		
		override protected function draw():void
		{
			var xLoc:int = _size.x / 2;
			var yLoc:int = _size.y / 2;
			graphics.beginFill(0x000000);
			graphics.drawRect(-xLoc, -yLoc, _size.x, _size.y);
			graphics.endFill();
			this.x = xLoc;
			this.y = yLoc;
			super.draw();
		}
		
		public function resize($fieldWidth:uint, $fieldHeight:uint):void
		{
			_size = new Point($fieldWidth, $fieldHeight);
			redraw();
		}
		
		override public function set rotation(value:Number):void
		{
			this.rotation = value; /// maybe tween this
		}
		
		override public function set x(value:Number):void
		{
			_position.x = value; /// maybe tween this
		}
		
		override public function set y(value:Number):void
		{
			_position.y = value; /// maybe tween this
		}
		
		private function onFrame(e:Event):void
		{
			var planets:Vector.<PlanetData> = new Vector.<PlanetData>();
			var planet:Planet;
			var planetData:PlanetData;
			
			if(_currentPlanetData == null)
				_currentPlanetData = planets;
			//get planets

			for each(planetData in _currentPlanetData)
			{
				if(_currentPlanetData.indexOf(planetData) == -1)
				{
					planet = _activePlanets[planetData];
					_pooledPlanets.push(planet);
					removeChild(planet);
					_activePlanets[planetData] = null;
					delete _activePlanets[planetData];
				}
			}
			
			
			//create new planets and update existing planets
			for each(planetData in planets)
			{
				planet = _activePlanets[planetData];
				if(planet == null)
				{
					if(_pooledPlanets.length > 0)
					{
						//use a pooled object if available
						planet.updateData(planetData);
					} else {
						//construct a new planet
						planet = _activePlanets[planetData] = new Planet(planetData);
					}
					addChild(planet);
				}
				planet.x = planetData.location.x - _position.x;
				planet.y = planetData.location.y - _position.y;
			}
			
		}
	}
}