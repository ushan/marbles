package org.ushan.marbles.views.balls
{
	import flash.display.Sprite;
	
	import org.ushan.marbles.controlers.Controller;
	import org.ushan.marbles.events.GamePlayEvent;
	import org.ushan.marbles.events.ModelEvent;
	import org.ushan.marbles.models.Model;
	import org.ushan.marbles.models.ModelBall;
	import org.ushan.marbles.views.BasketBack;
	import org.ushan.marbles.views.View;
	
	public class BallsManager extends Sprite
	{
		//----------------------------------------------------------------------
		//	read only
		//----------------------------------------------------------------------
		private var _balls				:Vector.<ViewBall>;
		public function get balls()		:Vector.<ViewBall> { return _balls };
		
		//----------------------------------------------------------------------
		//	private fields
		//----------------------------------------------------------------------
		private var model			:Model;
		private var controller		:Controller;
		private var view			:View;
		
		private var basket			:BasketBack;
		private var backContainer	:Sprite;
		private var upperContainer	:Sprite;
		
		
		//----------------------------------------------------------------------
		//
		//	constructor
		//
		//----------------------------------------------------------------------
		
		public function BallsManager()
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
			initVisual();
			
		}
		
		private function initSingletons():void
		{
			model = Model.instance;
			controller = Controller.instance;
			view = View.instance;
			_balls = new Vector.<ViewBall>();
			basket = view.basketBack;
		}
		
		private function initVisual():void
		{
			backContainer = new Sprite();
			addChild(backContainer);
			
			addChild(basket);
			
			upperContainer = new Sprite();
			addChild(upperContainer);
			
		}

		private function initListeners():void
		{
			model.addEventListener(ModelEvent.BALL_ADDED, model_ballAddedHandler, false, 0, true);
			model.addEventListener(GamePlayEvent.DRAGED_ELEMENT,
				model_dragedElementHandler, false, 0, true);
			model.addEventListener(GamePlayEvent.FAILED_DROP,
				model_failedDropHandler, false, 0, true);
			model.addEventListener(ModelEvent.BALL_REMOVED,
				model_ballRemovedHandler, false, 0, true);
		}
		
		private function addBall(modelBall:ModelBall):void
		{
			var ball:ViewBall = new ViewBall(modelBall);
			backContainer.addChild(ball);
			_balls.push(ball);
		}
		
		private function setOnTop(modelBall:ModelBall):void
		{
			var ball:ViewBall = getViewBallByModel(modelBall);
			//backContainer.removeChild(ball);
			//upperContainer.addChild(ball);
			
			if (backContainer.contains(ball))
			{
				backContainer.removeChild(ball);
				upperContainer.addChild(ball);
			}
			
		}
		
		private function setOnBack(modelBall:ModelBall):void
		{
			var ball:ViewBall = getViewBallByModel(modelBall);
			upperContainer.removeChild(ball);
			backContainer.addChild(ball);
		}
		
		private function getViewBallByModel(modelBall:ModelBall):ViewBall
		{
			for (var i:uint = 0; i < _balls.length; i++)
			{
				if (_balls[i].modelBall == modelBall)
				{
					return _balls[i];
				}
			}
			return null
		}
		
		private function removeElement(modelBall:ModelBall):void
		{
			var ball:ViewBall = getViewBallByModel(modelBall);
			_balls.splice(_balls.indexOf(ball), 1);
			if (upperContainer.contains(ball))
			{
				upperContainer.removeChild(ball);	
			}
			else
			{
				if (backContainer.contains(ball))
				{
					backContainer.removeChild(ball);
				}
				else
				{
					throw new Error("UError. ball is not child of upper or lower conainer");

				}
			}
			
		}
		
		private function replaceToUp(modelBall:ModelBall):void
		{
			
		}
		
		private function replaceToBack(modelBall:ModelBall):void
		{
			
		}
		
		//----------------------------------------------------------------------
		//
		//	event handlers
		//
		//----------------------------------------------------------------------
		
		private function model_ballAddedHandler(e:ModelEvent):void 
		{
			addBall(e.modelBall);
		}
		
		private function model_dragedElementHandler(e:GamePlayEvent):void 
		{
			setOnTop(e.element);
		}
		
		private function model_failedDropHandler(e:GamePlayEvent):void 
		{
			setOnBack(e.element);
		}
		
		private function model_ballRemovedHandler(e:ModelEvent):void 
		{
			removeElement(e.modelBall);
		}
	}
}