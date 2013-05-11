package org.ushan.marbles.models
{
	import Box2D.Collision.Shapes.b2CircleDef;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.Joints.b2MouseJointDef;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2BodyDef;
	import Box2D.Dynamics.b2World;
	
	import com.greensock.TweenLite;
	import com.greensock.easing.Back;
	import com.greensock.easing.Elastic;
	import com.greensock.easing.Linear;
	import com.greensock.easing.Quad;
	
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.geom.Point;
	
	import org.ushan.core.mvc.interfaces.IActionInitiator;
	import org.ushan.core.mvc.interfaces.IModel;
	import org.ushan.geom.MathUtils;
	import org.ushan.marbles.actions.DropFinishedAction;
	import org.ushan.marbles.actions.FailedDropAction;
	import org.ushan.marbles.actions.SuccessDropAction;
	import org.ushan.marbles.controlers.Controller;
	import org.ushan.marbles.events.GamePlayEvent;
	import org.ushan.marbles.events.ModelBallEvent;
	import org.ushan.marbles.models.configs.EConfigConstants;
	
	public class ModelBall extends EventDispatcher implements IActionInitiator, IModel
	{
		//----------------------------------------------------------------------
		//	read only
		//----------------------------------------------------------------------
		private var _ballB2D				:b2Body;
		public function get ballB2D()		:b2Body { return _ballB2D };
		
		private var _defenition				:b2CircleDef;
		public function get defenition()	:b2CircleDef { return _defenition };
		
		private var _radius					:Number;
		public function get radius()		:Number { return _radius };
		
		private var _type					:uint;
		public function get type()			:uint { return _type };
		
		private var _targetPoint			:Point;
		public function get targetPoint()	:Point { return _targetPoint };
		
		private var _startPoint				:Point;
		public function get startPoint()	:Point { return _startPoint };
		
		private var _dragDisplace			:Point;
		public function get dragDisplace()	:Point { return _dragDisplace };
		
		private var _fixedDisplace			:Point;
		public function get fixedDisplace()	:Point { return _fixedDisplace };
		
		private var _isFixed				:Boolean = false;
		public function get isFixed()		:Boolean { return _isFixed };
		
		
		//----------------------------------------------------------------------
		//	private getters / setters
		//----------------------------------------------------------------------
		private var _x			:Number;
		private var _y			:Number;
		private var _h			:Number;
		private var _status					:uint;
		
		//----------------------------------------------------------------------
		//	private fields
		//----------------------------------------------------------------------
		private var model		:Model;
		private var controller	:Controller;
		private var scale		:Number;
		
		private var isPhysics	:Boolean;
		private var world		:b2World;
		private var space		:Space;
		private var body		:b2BodyDef;
		
		
		//----------------------------------------------------------------------
		//
		//	constructor
		//
		//----------------------------------------------------------------------
		
		public function ModelBall(radius		:Number, 
								  targetPoint	:Point,
								  startPoint	:Point,
								  type			:uint)
		{
			super();
			_radius = radius;
			_targetPoint = targetPoint;
			_startPoint = startPoint;
			_type = type;
			init();
		}
		
		//----------------------------------------------------------------------
		//
		//	public methods
		//
		//----------------------------------------------------------------------
		
		internal function run(initiator:ModelBallManager):void
		{
			start();
		}
		
		private function addToWorld(initiator:ModelBallManager):void
		{
			_ballB2D = _ballB2D
			body.position.Set(startPoint.x / scale, startPoint.y / scale);
			_ballB2D = world.CreateDynamicBody(body);
			_ballB2D.CreateShape(defenition);
			_ballB2D.SetLinearVelocity(new b2Vec2(- Math.random()*12 + 24, - Math.random()*12 + 24));
			_ballB2D.SetMassFromShapes();
			isPhysics = true;
		}
		
		internal function drag(initiator:ModelBallManager, point:Point):void
		{
			stratDrag(point);
		}
		
		internal function drop(initiator:ModelBallManager):void
		{
			stopDrag();
		}
		
		internal function successDrop(initiator:ModelBallManager, point:Point):void
		{
			_fixedDisplace = new Point (_x - model.basket.x, _y - model.basket.y);
			_isFixed = true;
			animationToBasketCenter();
		}
		
		internal function failedDrop(initiator:ModelBallManager, point:Point):void
		{
			animateToTarget();
		}
		
		internal function clear(initiator:ModelBallManager):void
		{
			TweenLite.killTweensOf(this);
		}
		
		//----------------------------------------------------------------------
		//
		//	getters / setters
		//
		//----------------------------------------------------------------------
		
		public function get x():Number
		{
			if (isPhysics)
			{
				return _ballB2D.GetPosition().x * scale;
			}
			return _x;
		}
		
		public function set x(value:Number):void
		{
			_x = value;
		}
		
		public function get y():Number
		{
			if (isPhysics)
			{
				return _ballB2D.GetPosition().y * scale;
			}
			return _y;
		}
		
		public function set y(value:Number):void
		{
			_y = value;
		}
		
		public function get h():Number
		{
			return _h;
		}
		
		public function set h(value:Number):void
		{
			_h = value;
		}
		
		
		//----------------------------------------------------------------------
		//
		//	private methods
		//
		//----------------------------------------------------------------------
		
		private function init():void
		{
			initSingletons();
			//initListeners();
			//initB2D();
			initPosition();
		}
		
		private function initSingletons():void
		{
			model = Model.instance;
			controller = Controller.instance;
			world = model.world;
			space = model.space;
			scale = EConfigConstants.PH_SCALE;
			
		}
		
		private function initPosition():void
		{
			x = _startPoint.x;
			y = _startPoint.y;
			h = 1;
		}
		
		//Box2d is disabled now
		private function initB2D():void
		{
			_defenition  = new b2CircleDef();
			_defenition.radius = _radius/scale;
			_defenition.localPosition.Set(0.0, 0.0);
			_defenition.density = 5.0;
			
			body = new b2BodyDef();
		}
		
		private function stratDrag(point:Point):void
		{
			//space.attachMouseToBall(this, point, _ballB2D); 
			_dragDisplace = new Point(point.x - x, point.y - y);
			TweenLite.killTweensOf(this);
			var duration:uint = EConfigConstants.DRAGUP_DURATION;
			var upScale:Number = EConfigConstants.DRAGUP_SCALE;
			TweenLite.to(this, duration, {h:upScale, ease:Back.easeOut, 
				overwrite:true, useFrames:true});
			
			model.addEventListener(GamePlayEvent.HAND_MOVE, 
				model_moveHandEvent, false, 0, true);
		}
		
		private function stopDrag():void
		{
			//space.destroyJoint(this);
			TweenLite.killTweensOf(this);
			TweenLite.to(this, 6, {h:1, ease:Back.easeIn, 
				overwrite:true, onComplete:onDropAnimationComlete, useFrames:true});
			
			model.removeEventListener(GamePlayEvent.HAND_MOVE, 
				model_moveHandEvent);
		}
		
		private function onDropAnimationComlete():void
		{
			var action:DropFinishedAction = new DropFinishedAction(this, this, new Point (x, y));
			controller.accepModelAction(this, action);
		}
		
		private function start():void
		{
			animateToTarget();
			dispatchStart();
		}
		
		private function animateToTarget():void
		{
			TweenLite.killTweensOf(this);
			var duration:uint = EConfigConstants.APPEAR_DURATION;
			TweenLite.to(this, duration, {x:_targetPoint.x, ease:Quad.easeOut, 
				overwrite:true, onComplete:onAnimateToTargetComlete, useFrames:true});
			TweenLite.to(this, duration, {y:_targetPoint.y, ease:Quad.easeOut, 
				overwrite:false, useFrames:true});
			TweenLite.to(this, duration, {h:1, ease:Quad.easeIn, 
				overwrite:false, useFrames:true});
			dispatchAnimationToTarget();
		}
		
		private function dispatchStart():void
		{
			var event:ModelBallEvent = new ModelBallEvent(ModelBallEvent.START);
			dispatchEvent(event);
		}
		
		private function dispatchGameEnabled():void
		{
			var event:ModelBallEvent = new ModelBallEvent(ModelBallEvent.GAME_ENABLED);
			dispatchEvent(event);
		}
		
		private function dispatchAnimationToTarget():void
		{
			var event:ModelBallEvent = new ModelBallEvent(ModelBallEvent.ANIMATION_TO_TARGET);
			dispatchEvent(event);
		}
		
		private function onAnimateToTargetComlete():void
		{
			dispatchGameEnabled();
		}
		
		private function animationToBasketCenter():void
		{
			var p:Point = new Point();
			p.x = _fixedDisplace.x * 0.6;
			p.y = _fixedDisplace.y * 0.6;
			TweenLite.to(_fixedDisplace, 12, {x:p.x, y:p.y, ease:Quad.easeOut, 
				overwrite:true, onComplete:onAnimateToTargetComlete, useFrames:true});
		}
		
		private function ease1 (t:Number, b:Number, c:Number, d:Number):Number 
		{
			var ts:Number=(t/=d)*t;
			var tc:Number=ts*t;
			return b+c*(-1*ts*ts + 4*tc + -6*ts + 4*t);
		}
		
		
		//----------------------------------------------------------------------
		//
		//	event handlers
		//
		//----------------------------------------------------------------------
		
		private function model_moveHandEvent(e:GamePlayEvent):void
		{
			x = e.point.x - _dragDisplace.x;
			y = e.point.y - _dragDisplace.y;
		}
	}
}