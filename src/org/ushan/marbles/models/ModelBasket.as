package org.ushan.marbles.models
{
	import com.greensock.TweenLite;
	import com.greensock.easing.Elastic;
	import com.greensock.easing.Linear;
	
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.geom.Point;
	
	import org.ushan.marbles.controlers.Controller;
	import org.ushan.marbles.events.GamePlayEvent;
	import org.ushan.marbles.events.ModelBasketEvent;
	import org.ushan.marbles.models.configs.EConfigConstants;
	import org.ushan.marbles.models.configs.EGameMode;
	
	public class ModelBasket extends EventDispatcher
	{
		//----------------------------------------------------------------------
		//	read only
		//----------------------------------------------------------------------
		private var _x					:Number;
		public function get x()			:Number { return _x};
		
		private var _y					:Number;
		public function get y()			:Number { return _y};
		
		private var _width				:Number;
		public function get width()		:Number { return _width};
		
		private var _height				:Number;
		public function get height()	:Number { return _height};
		
		private var _startPoint			:Point;
		public function get startPoint():Point { return _startPoint	};
		
		private var _speed				:Number;
		public function get speed()		:Number { return _speed	};
		
		//----------------------------------------------------------------------
		//	private fields
		//----------------------------------------------------------------------
		private var model		:Model;
		private var controller	:Controller;
		
		private var t			:Number = 0;
		
		//----------------------------------------------------------------------
		//
		//	constructor
		//
		//----------------------------------------------------------------------
		
		public function ModelBasket()
		{
			super();
			init();
		}
		
		//----------------------------------------------------------------------
		//
		//	getters / setters
		//
		//----------------------------------------------------------------------
		public function set x (value:Number):void
		{
			_x = value;
			dispatchMove();
		}
		
		public function set y (value:Number):void
		{
			_y = value;
			dispatchMove();
		}
		
		//----------------------------------------------------------------------
		//
		//	internal methods
		//
		//----------------------------------------------------------------------
		
		internal function checkHit (point:Point):Boolean
		{
			var k:Number = _width / _height;
			var dx:Number = point.x - _x;
			var dy:Number = (point.y - _y) * k; //ellepse scale
			return Math.sqrt(dx * dx + dy * dy) < width * 1;
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
			initStartPosition();
			//beginTween();
			
		}
		
		private function initSingletons():void
		{
			model = Model.instance;
		}
		
		private function initListeners():void
		{
			model.addEventListener(GamePlayEvent.START_GAME,
				model_startGameHandler, false, 0, true);
			model.addEventListener(GamePlayEvent.APPEAR_COMPLETE,
				model_AppearCompleteHandler, false, 0, true);
			model.addEventListener(GamePlayEvent.WIN,
				model_winHandler, false, 0, true);

		}
		
		private function initStartPosition():void
		{
			var basketXML:XML = model.config.xml.Config.Basket[0];
			
			_x = parseFloat(basketXML.@startX);
			_y = parseFloat(basketXML.@startY);
			_startPoint = new Point(_x, _y);
			_width = parseFloat(basketXML.@width);
			if (basketXML.@heigth)
			{
				_height = parseFloat(basketXML.@height);
			}
			else
			{
				_height = _width;
			}
			if (basketXML.@speed && model.config.movingBasket)
			{
				_speed = parseFloat(basketXML.@speed) / 1000;
			}
			else
			{
				_speed = 0;
			}
		}
		
		private function initStepListener():void
		{
			model.addEventListener(GamePlayEvent.STEP, 
				model_stepHandler, false, 0, true);
		}
		
		private function toFunctionPosition():void
		{
			var point:Point = getXYByFunctionT();
			var duration:uint = 45 *  0.01 / _speed;
			TweenLite.to(this, duration, {x:point.x, y:point.y, ease:Linear.easeOut, 
				overwrite:true, onComplete:onToFunctionPositionComlete, useFrames:true});
		}
		
		private function onToFunctionPositionComlete():void
		{
			initStepListener();
		}
		
		private function dispatchMove():void
		{
			var event:ModelBasketEvent = new ModelBasketEvent(ModelBasketEvent.MOVE, _x, _y);
			dispatchEvent(event);
		}
		
		private function getXYByFunctionT():Point
		{
			var w:Number = model.config.sceneWidth - _width * 1.5 ;
			var h:Number = model.config.sceneHeight - _height * 1.5;
			var point:Point = new Point();
			point.x = Math.sin (2 * t) * w / 2 + model.config.sceneWidth /2;
			point.y = Math.cos (3 * t) * h * 0.40 + model.config.sceneHeight / 2 - 20;
			return point;
			
		}
		
		private function moveBasket():void
		{
			if (model.config.movingBasket)
			{
				t += _speed
				var point:Point = getXYByFunctionT();
				x = point.x;
				y = point.y;
			}
			else
			{
				dispatchMove();
			}
		}
		
		//----------------------------------------------------------------------
		//
		//	event handlers
		//
		//----------------------------------------------------------------------
		
		private function model_stepHandler(e:GamePlayEvent):void
		{
			moveBasket();
		}
		
		private function model_startGameHandler(e:GamePlayEvent):void
		{

		}
		
		private function model_AppearCompleteHandler(e:GamePlayEvent):void
		{

			if (model.config.movingBasket)
			{
				toFunctionPosition();
			}
			else
			{
				initStepListener();
			}
		}
		
		private function model_winHandler(e:GamePlayEvent):void
		{
			model.removeEventListener(GamePlayEvent.STEP, 
				model_stepHandler);
		}
	}
}