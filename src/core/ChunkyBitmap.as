package core
{
	import core.Element;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	
	/**
	 * [Description]
	 *
	 * @author G$
	 * @since Oct 22, 2011
	 */
	public class ChunkyBitmap extends Element
	{
		
		//--------------------------------------
		// CONSTANTS
		//--------------------------------------
		private static const MAX_REPEAT:uint = 3;
		private static const MIN_REPEAT:uint = 2;
		
		//--------------------------------------
		// VARIABLES
		//--------------------------------------
		private var _bitmap:BitmapData;
		private var _size:Rectangle;
		private var _transform:Matrix = new Matrix();
		private var _tiles:Vector.<Shape> = new Vector.<Shape>();
		private var _sourceSize:Point;
		private var _tileSize:Point;
		private var _tileRepeats:Point;
		
		//--------------------------------------
		// CONSTRUCTOR
		//--------------------------------------
		public function ChunkyBitmap(size:Rectangle, bitmapData:BitmapData)
		{
			super();
			_size = size;
			_bitmap = bitmapData;
			chunkBitmap();
			super.x = _size.x;
			super.y = _size.y;
		}
		
		//--------------------------------------
		// PROTECTED & PRIVATE METHODS
		//--------------------------------------
		
		private function chunkBitmap():void
		{
			graphics.clear();
			
			_sourceSize = new Point(_bitmap.width * _transform.a, _bitmap.height * _transform.d);
			_tileRepeats = new Point();
			_tileSize = new Point();
			
			_tileRepeats.x = _size.width / _sourceSize.x;
			if(_tileRepeats.x < MAX_REPEAT)
			{
				_tileRepeats.x = Math.max(Math.floor(_tileRepeats.x) + 1, MIN_REPEAT);
				_tileSize.x = _sourceSize.x;
			} else {
				_tileRepeats.x = MAX_REPEAT;
				_tileSize.x = Math.ceil(_size.width / _sourceSize.x / _tileRepeats.x) * _sourceSize.x;
			}
			
			_tileRepeats.y = _size.height / _sourceSize.y;
			if(_tileRepeats.y < MAX_REPEAT)
			{
				_tileRepeats.y = Math.max(Math.floor(_tileRepeats.y) + 1, MIN_REPEAT);
				_tileSize.y = _sourceSize.y;
			} else {
				_tileRepeats.y = MAX_REPEAT;
				_tileSize.y = Math.ceil(_size.height / _sourceSize.y / _tileRepeats.y) * _sourceSize.y;
			}
			
			//cleanup
//			sweepChildren(this);
			
			//build tiles
			var tile:Shape;
			var tiles:uint = _tileRepeats.x * _tileRepeats.y;
			for(var i:uint = 0; i < tiles; i++)
			{
				tile = new Shape();
				tile.graphics.beginBitmapFill(_bitmap, _transform, true, true);
				tile.graphics.drawRect(0, 0, _tileSize.x, _tileSize.y);
				tile.graphics.endFill();
				//				tile.alpha = Math.random();
				_tiles[i] = tile;
				addChild(tile);
			}
			trace("chunkBitmap:", _tileSize.x, _tileRepeats.x, _sourceSize.x);
			reposition();
		}
		
		//--------------------------------------
		// PUBLIC METHODS
		//--------------------------------------
		override public function set x(value:Number):void
		{
			_transform.tx = value;
		}
		
		override public function set y(value:Number):void
		{
			_transform.ty = value;
		}
		
		public function setSize( $width:Number, $height:Number ):void
		{
			_size.width = $width;
			_size.height = $height;
			chunkBitmap();
		}
		
		public function setScale(value:Number):void
		{
			_transform.a = _transform.d = value;
			chunkBitmap();
		}
		
		override public function get scaleX():Number
		{
			return _transform.a;
		}
		
		override public function get scaleY():Number
		{
			return _transform.d;
		}
		
		//--------------------------------------
		// EVENT HANDLERS
		//--------------------------------------							
		
		public function reposition():void
		{
			if(_bitmap != null)
			{
				var offset:Point = new Point(
					(_transform.tx % _sourceSize.x) - _sourceSize.x
					, (_transform.ty % _sourceSize.y) - _sourceSize.y); 
				var containerWidth:Number = _tileSize.x * _tileRepeats.x;
				var containerHeight:Number = _tileSize.x * _tileRepeats.y;
				var maxRows:int = _tileRepeats.x;
				var maxColumns:int = _tileRepeats.y;
				
				var contentWidth:Number = ((_tiles[0].width) * (maxColumns));
				var contentHeight:Number = ((_tiles[0].height) * (maxRows));
				var columnsCreated:int = 1;
				
				for(var k:uint = 1; k < _tiles.length; k++)
				{				
					if(columnsCreated < maxColumns)
					{
						_tiles[k].x = _tiles[k - 1].x + _tiles[k - 1].width;
						_tiles[k].y = _tiles[k - 1].y;
						columnsCreated++;
					}
					else
					{
						_tiles[k].x = offset.x;
						_tiles[k].y = _tiles[k - 1].y + _tiles[k - 1].height;
						columnsCreated = 1;
					}
				}
			}
		}
		
	}
}