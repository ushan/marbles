package org.ushan.marbles.views.balls
{
	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.geom.Matrix;
	import flash.utils.getDefinitionByName;
	
	import org.ushan.geom.MathUtils;
	import org.ushan.marbles.events.GamePlayEvent;
	import org.ushan.marbles.models.Model;
	import org.ushan.marbles.views.balls.bitmaps.*;
	
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
		private var textureID		:uint;
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
			this.textureID = textureID;
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
			
			initSingletons()
			initListeners();
			setTexture();
			updateVisual();
		}
		
		private function initSingletons():void
		{
			model = Model.instance;
		}
		
		private function initListeners():void
		{
			model.addEventListener(GamePlayEvent.STEP, model_stepHandler, 
				false, GamePlayEvent.$ORDER_STEP_BALLMATRIXTEXTURE, true);
		}
		
		private function setTexture():void
		{
			var textureClass:Class;
			switch (textureID)
			{
				case 1:
					textureClass = BitmapTexture1;	
					break;
				case 2:
					textureClass = BitmapTexture2;	
					break;
				case 3:
					textureClass = BitmapTexture3;	
					break;
				case 4:
					textureClass = BitmapTexture4;	
					break;
				case 5:
					textureClass = BitmapTexture5;	
					break;
				case 6:
					textureClass = BitmapTexture6;	
					break;
				case 7:
					textureClass = BitmapTexture7;	
					break;
				case 8:
					textureClass = BitmapTexture8;	
					break;
				default:
					throw new Error("UError. There is not a texture id " + textureID);
			}
			//var textureClass:Class = getDefinitionByName("BitmapTexture" + textureID) as Class;
			bitmapTexture = new textureClass(376, 376);
		}
		
		private function updateVisual():void
		{
			var matrix:Matrix = new Matrix();
			matrix.rotate(angle);
			var sc:Number =  4 * 2 * _radius / 376
			matrix.tx = _posX / sc;
			matrix.ty = _posY / sc;
			matrix.scale(sc, sc);
			
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