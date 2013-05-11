package org.ushan.marbles.views
{
	import com.greensock.TweenLite;
	import com.greensock.easing.Quad;
	
	import flash.display.BlendMode;
	import flash.display.Sprite;
	import flash.filters.BitmapFilterQuality;
	import flash.filters.DropShadowFilter;
	import flash.geom.Point;
	
	import org.ushan.marbles.controlers.Controller;
	import org.ushan.marbles.events.GamePlayEvent;
	import org.ushan.marbles.events.ModelBasketEvent;
	import org.ushan.marbles.events.ModelEvent;
	import org.ushan.marbles.models.Model;
	import org.ushan.marbles.models.ModelBasket;
	
	public class BasketBack extends Sprite
	{
		//----------------------------------------------------------------------
		//	instances pn the scene
		//----------------------------------------------------------------------
		public var basketArea	:Sprite;
		
		//----------------------------------------------------------------------
		//	private fields
		//----------------------------------------------------------------------
		private var model		:Model;
		private var controller	:Controller;
		
		private var modelBasket	:ModelBasket;
		
		//----------------------------------------------------------------------
		//
		//	constructor
		//
		//----------------------------------------------------------------------
		
		public function BasketBack()
		{
			super();
			init();

		}
		
		//----------------------------------------------------------------------
		//
		//	private methods
		//
		//----------------------------------------------------------------------
		
		private function init():void
		{
			initSingletons();
			initListeners();
			
		}
		
		private function initSingletons():void
		{
			model = Model.instance;
		}
		
		private function initListeners():void
		{
			model.addEventListener(ModelEvent.XML_WAS_INITED, 
				model_xmlWasInitedHandler, false, 0, true);
			model.addEventListener(GamePlayEvent.APPEAR_COMPLETE, 
				model_appearCompleteHandler, false, 0, true);
		}
		
		private function initModelBasket():void
		{
			modelBasket = model.basket;
			model.addEventListener(GamePlayEvent.START_GAME,
				model_startGameHandler, false, 0, true);
			modelBasket.addEventListener(ModelBasketEvent.MOVE,
				modelBasket_moveHandler, false, 0, true);
		}
		
		private function initVisual():void
		{
			alpha = 0;
			basketArea.visible = false;
			//blendMode = BlendMode.DARKEN;
			
			x = modelBasket.x;
			y = modelBasket.y;
			var visualSizeScale:Number = width / 100;
			scaleX = modelBasket.width / 100 * visualSizeScale;
			scaleY = modelBasket.height / 100 * visualSizeScale;
			
			width = Math.round(width);
			height = Math.round(height);
			
			var filter:Array = new Array();
			var shadow:DropShadowFilter = new DropShadowFilter();
			shadow.distance = 30;
			shadow.alpha = 0.3;
			shadow.blurX = 18;
			shadow.blurY = 18;
			shadow.quality = BitmapFilterQuality.HIGH;
			shadow.angle = 135;
			filter.push(shadow);
			filters = filter;
		}
		
		private function updatePosition(point:Point):void
		{
			x = point.x;
			y = point.y;
		}
		
		private function show():void
		{
			TweenLite.killTweensOf(this);
			TweenLite.to(this, 6, {alpha:1, ease:Quad.easeOut, 
				overwrite:true, useFrames:true});
		}
		private function hide():void
		{
			
			alpha = 0;
		}
		
		//----------------------------------------------------------------------
		//
		//	event handlers
		//
		//----------------------------------------------------------------------
		
		private function model_xmlWasInitedHandler(e:ModelEvent):void
		{
			initModelBasket();
			initVisual();
		}
		
		private function model_startGameHandler(e:GamePlayEvent):void
		{
			hide();
		}
		
		private function modelBasket_moveHandler(e:ModelBasketEvent):void
		{
			updatePosition(new Point(e.x, e.y));
		}
		
		private function model_appearCompleteHandler(e:GamePlayEvent):void
		{
			show();
		}
	}
}