package comps
{
	import core.Element;
	
	import flash.events.Event;
	import flash.geom.Point;

	public class Starfield extends Element
	{
		private var _size:Point;
		public function Starfield($fieldWidth:uint, $fieldHeight:uint)
		{
			_size = new Point($fieldWidth, $fieldHeight);
			super();
		}
		
		override protected function init(e:Event):void 
		{
			super.init(e);
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
	}
}