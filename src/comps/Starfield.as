package comps
{
	import core.Element;
	
	import datas.PlanetData;
	import datas.UniverseMachine;
	
	import flash.events.Event;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.Dictionary;

	public class Starfield extends Element
	{
		private var _size:Number;
		private var _position:Point;
		private var _universeMachine:UniverseMachine;
		private var _lastPos:Point;
		private var _activePlanets:Dictionary = new Dictionary();
		private var _currentPlanetData:Vector.<PlanetData>;
		private var _pooledPlanets:Vector.<Planet> = new Vector.<Planet>();
		
		public function Starfield($fieldWidth:Number, $fieldHeight:Number, $universeMachine:UniverseMachine)
		{
			_size = Math.max($fieldWidth, $fieldHeight);
			_position = new Point(0, 0);
			_universeMachine = $universeMachine;
			super();
		}
		
		override protected function init(e:Event):void 
		{
			super.init(e);
			addEventListener(Event.ENTER_FRAME, onFrame);
		}
		
		override protected function draw():void
		{
			var locOffset:Number = _size / 2;
			var bufferedLocOffset:Number = locOffset + Config.STARFIELD_BUFFER;
			var fieldSize:Number = _size + Config.STARFIELD_BUFFER * 2;
			graphics.beginFill(0x000000);
			graphics.drawRect(-bufferedLocOffset, -bufferedLocOffset, fieldSize, fieldSize);
			graphics.endFill();
			super.x = locOffset;
			super.y = locOffset;
		}
		
		public function resize($fieldWidth:uint, $fieldHeight:uint):void
		{
			_size = Math.max($fieldWidth, $fieldHeight);
			redraw();
		}
		
		override public function set rotation(value:Number):void
		{
			super.rotation = value; /// maybe tween this
//			this.transform.matrix.rotate(value);
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
			if(_lastPos == null || _position.x != _lastPos.x || _position.y != _lastPos.y)
			{
				_lastPos = _position;
				var xPos:Number = _position.x - (_size / 2) - Config.STARFIELD_BUFFER;
				var yPos:Number = _position.y - (_size / 2) - Config.STARFIELD_BUFFER;
				var fieldSize:Number = _size + Config.STARFIELD_BUFFER * 2;
				var planets:Vector.<PlanetData> = _universeMachine.getPlanetDatasForFrame(new Rectangle(xPos, yPos, fieldSize, fieldSize));
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
}