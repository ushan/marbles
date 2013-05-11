package org.ushan.marbles.views.balls
{
	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.geom.Matrix;
	
	import org.ushan.geom.MathUtils;
	import org.ushan.marbles.events.GamePlayEvent;
	import org.ushan.marbles.models.Model;
	import org.ushan.marbles.views.balls.bitmaps.BitmapTexture1;
	
	public class BallMatrixTexture extends Shape
	{
		//----------------------------------------------------------------------
		//	getters / setters
		//----------------------------------------------------------------------
		private var  		_posX		:Number = 0;
		public function get posX()		:Number { return _posX };
		public function set posX(value	:Number):void
		{
			_posX = value;
			isUpdated = true;
		}
		
		private var  		_posY		:Number = 0;
		public function get posY()		:Number { return _posY };
		public function set posY(value	:Number):void
		{
			_posY = value;
			isUpdated = true;
		}
		
		private var  		_radius		:Number;
		public function get radius()	:Number { return _radius };
		public function set radius(value:Number):void
		{
			_radius = value;
			isUpdated = true;
		}
		
		
		//----------------------------------------------------------------------
		//	private fields
		//----------------------------------------------------------------------
		private var model			:Model;
		private var bitmapTexture	:BitmapData;
		private var isUpdated		:Boolean = false;
		private var angle			:Number = MathUtils.random(0, Math.PI/2);
		
		//----------------------------------------------------------------------
		//
		//	constructor
		//
		//----------------------------------------------------------------------
		
		public function BallMatrixTexture(radius:Number, textureID:uint = 1)
		{
			super();
			_radius = radius;
			init();
		}
		
		//----------------------------------------------------------------------
		//
		//	public methods
		//
		//----------------------------------------------------------------------
		
		//----------------------------------------------------------------------
		//
		//	private methods
		//
		//----------------------------------------------------------------------
		private function init():void
		{
			bitmapTexture = new BitmapTexture1(376, 376);
			initSingletons()
			initListeners();
			updateVisual();
		}
		
		private function initSingletons():void
		{
			model = Model.instance;
		}
		
		private function initListeners():void
		{
			model.addEventListener(GamePlayEvent.STEP, model_stepHandler, false, 0, true);
		}
		
		private function updateVisual():void
		{
			var matrix:Matrix = new Matrix();
			matrix.rotate(angle);
			matrix.tx = _posX;
			matrix.ty = _posY;
			
			graphics.clear();
			graphics.beginBitmapFill(bitmapTexture, matrix, true, true);
			graphics.drawCircle(0, 0, _radius);
			
			isUpdated = false;
		}
		
		//----------------------------------------------------------------------
		//
		//	event handlers
		//
		//----------------------------------------------------------------------
		
		private function model_stepHandler(e:GamePlayEvent):void 
		{
			if (isUpdated) updateVisual();
			
		}
	}
}