package org.ushan.marbles.models
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import org.ushan.core.conveyor.ConveyorBranche;
	import org.ushan.core.mvc.interfaces.IActionInitiator;
	import org.ushan.core.mvc.interfaces.IModel;
	import org.ushan.geom.MathUtils;
	import org.ushan.geom.PointsUtils;
	import org.ushan.marbles.actions.AppearCompleteAction;
	import org.ushan.marbles.controlers.Controller;
	import org.ushan.marbles.events.GamePlayEvent;
	import org.ushan.marbles.events.ModelEvent;
	import org.ushan.marbles.models.configs.EConfigConstants;
	
	public class ModelBallManager extends EventDispatcher implements IModel, IActionInitiator
	{
		//----------------------------------------------------------------------
		//	read only
		//----------------------------------------------------------------------
		private var _balls				:Vector.<ModelBall>;
		public function get balls()		:Vector.<ModelBall> { return _balls };
		
		private var _selected			:ModelBall;
		public function get selected()	:ModelBall { return _selected };
		
		//----------------------------------------------------------------------
		//	private fields
		//----------------------------------------------------------------------
		private var model		:Model;
		private var controller	:Controller;
		private var scale		:Number;
		private var conveyor	:ConveyorBranche;
		//private var world		:b2World;
		
		//----------------------------------------------------------------------
		//
		//	constructor
		//
		//----------------------------------------------------------------------
		public function ModelBallManager()
		{
			super();
			init();
		}
		
		//----------------------------------------------------------------------
		//
		//	public methods
		//
		//----------------------------------------------------------------------
		
		internal function resetBalls(initiator:Model):void
		{
			removeAllBalls();
		}
		
		internal function createBalls(initiator:Model):void
		{
			var rect:Rectangle = new Rectangle(-300, -300, 1650, 1200);
			for (var i:uint =0; i< model.config.totalMarbles; i++)
			{
				var min:uint = model.config.marbleMin;
				var max:uint = model.config.marbleMax;
				var radius:uint = MathUtils.randRangeInt(min, max);
				var target:Point = new Point();
				
				do 
				{ 
					target.x = MathUtils.randRangeInt(max+10, model.config.sceneWidth - max-10);
					target.y = MathUtils.randRangeInt(max+10, model.config.sceneHeight - max-10 - 100);
				} 
				while (notValidTarget(target, radius));
				
				var start:Point = PointsUtils.getRandomRectanglePoint(rect, 0);
				var type:uint = MathUtils.randRangeInt(1, EConfigConstants.TYPES_COUNT);
				var ball:ModelBall = new ModelBall(radius, target, start, type);
				addBall(ball);
				var delim:uint = model.config.marblesAppearDelay;
				conveyor.addTask(this, runBall, delim, ball);
			}
			conveyor.addTask(this, sendAppearCompleteAction, delim + EConfigConstants.APPEAR_DURATION);
			
		}
		
		internal function getNextRandomType():uint
		{
			var ballsOnScene:Vector.<ModelBall> = new Vector.<ModelBall>();
			for (var i:uint = 0; i < _balls.length; i++)
			{
				if (!_balls[i].isFixed)
				{
					ballsOnScene.push(_balls[i]);
				}
			}
			if (ballsOnScene.length > 0)
			{
				var ballID:uint = MathUtils.randRangeInt(0, ballsOnScene.length - 1);
				return ballsOnScene[ballID].type;
			}
			else
			{
				return 0;
			}

			
		}
		
		internal function dragBall(initiator:Model, ball:ModelBall, point:Point):void
		{
			_selected = ball;
			ball.drag(this, point);
		}
		
		internal function dropBall(initiator:Model, ball:ModelBall):void
		{
			ball.drop(this);
			_selected = null;
		}
		
		internal function successDrop(initiator:Model, ball:ModelBall, point:Point):void
		{
			ball.successDrop(this, point);
		}
		
		internal function failedDrop(initiator:Model, ball:ModelBall, point:Point):void
		{
			ball.failedDrop(this, point);
		}

		//----------------------------------------------------------------------
		//
		//	private methods
		//
		//----------------------------------------------------------------------
		
		private function init():void
		{
			initSingletons();
			_balls = new Vector.<ModelBall>();
			//initListeners();
			//initBalls();
		}
		
		private function initSingletons():void
		{
			model = Model.instance;
			controller = Controller.instance;
			//world = model.world;
			scale = EConfigConstants.PH_SCALE;
			conveyor = new ConveyorBranche();
			
		}
		
		private function runBall(ball:ModelBall):void
		{
			ball.run(this);
		}
		
		private function addBall(ball:ModelBall):void
		{
			_balls.push(ball);
			var event:ModelEvent = new ModelEvent(ModelEvent.BALL_ADDED);
			event.setModelBall(ball);
			model.passEvent(this, event);
		}
		
		private function removeAllBalls():void
		{
			while (_balls.length > 0)
			{
				removeBall(_balls[0]);
			}
		}
		
		private function removeBall(ball:ModelBall):void
		{
			_balls.splice(_balls.indexOf(ball), 1);
			ball.clear(this);
			var event:ModelEvent = new ModelEvent(ModelEvent.BALL_REMOVED);
			event.setModelBall(ball);
			model.passEvent(this, event);
		}
		
		private function notValidTarget(point:Point, radius:Number):Boolean
		{
			for (var i:uint = 0; i < _balls.length; i++)
			{
				var ball:ModelBall = _balls[i]; 
				var currPoint:Point = ball.targetPoint;
				//trace (currPoint + point + "   "  + Point.distance(currPoint, point) + "   " +  (radius + ball.radius ));
				if (Point.distance(currPoint, point) < radius + ball.radius )
				{
					
					return true;
				}
			}
			if (model.config.movingBasket == false)
			{
				return model.basket.checkHit(point);
			}
			else
			{
				//if basket is moving we can wait while it free its place for picking balls. Target is not noValid
				return false;
			}
		}
		
		private function sendAppearCompleteAction():void
		{
			var action:AppearCompleteAction = new AppearCompleteAction(this);
			controller.accepModelAction(this, action);
		}
		
	}
}