package comps
{
	import core.Element;
	
	import datas.JohnnyData;
	import datas.PlanetData;
	import datas.UniverseMachine;
	
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
		
		public function Starfield($fieldWidth:Number, $fieldHeight:Number, $universeMachine:UniverseMachine, $johnnyData:JohnnyData)
		{
			_johnnyData = $johnnyData;
			updateSizes($fieldWidth, $fieldHeight);
			_universeMachine = $universeMachine;
			super();
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
			
			var xPos:Number = position.x - (_maxViewArea / 2) - Config.STARFIELD_BUFFER;
			var yPos:Number = position.y - (_maxViewArea / 2) - Config.STARFIELD_BUFFER;
			var planets:Vector.<PlanetData> = _universeMachine.getPlanetDatasForFrame(new Rectangle(xPos, yPos, _bufferedSize, _bufferedSize));
			var planet:Planet;
			var planetData:PlanetData;
			
			//get planets
			
			if(_currentPlanetData == null)
				_currentPlanetData = planets;
			else {
				for each(planetData in planets)
				{
					if(_currentPlanetData.indexOf(planetData) == -1)
					{
						planet = _activePlanets[planetData];
						_pooledPlanets.push(planet);
						if(contains(planet))
							removeChild(planet);
						_activePlanets[planetData] = null;
						delete _activePlanets[planetData];
					}
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
				planet.x = planetData.location.x;
				planet.y = planetData.location.y;
			}
		}
	}
}