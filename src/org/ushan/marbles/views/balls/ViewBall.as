package  org.ushan.marbles.views.balls
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Matrix;
	import flash.geom.Point;
	
	import org.ushan.core.mvc.interfaces.IActionInitiator;
	import org.ushan.core.mvc.interfaces.IView;
	import org.ushan.geom.MathUtils;
	import org.ushan.marbles.actions.DragedElementAction;
	import org.ushan.marbles.actions.DropedElementAction;
	import org.ushan.marbles.actions.FailedDropAction;
	import org.ushan.marbles.actions.SuccessDropAction;
	import org.ushan.marbles.controlers.Controller;
	import org.ushan.marbles.events.ControllerEvent;
	import org.ushan.marbles.events.GamePlayEvent;
	import org.ushan.marbles.events.ModelBallEvent;
	import org.ushan.marbles.events.ModelBasketEvent;
	import org.ushan.marbles.events.ModelEvent;
	import org.ushan.marbles.models.Model;
	import org.ushan.marbles.models.ModelBall;
	import org.ushan.marbles.views.View;
	
	import su.silin.filters.FishEyeMap;

	public class ViewBall extends Sprite implements IActionInitiator, IView
	{
		//----------------------------------------------------------------------
		//	read only
		//----------------------------------------------------------------------
		private var _modelBall			:ModelBall;
		public function get modelBall()	:ModelBall { return _modelBall };
		
		//----------------------------------------------------------------------
		//	private fields
		//----------------------------------------------------------------------
		private var model		:Model;
		private var controller	:Controller;
		private var view		:View;
		
		private var _draged		:Boolean;
		private var fixed		:Boolean;
		private var hChanged	:Boolean;
		
		private var body		:Sprite = new Sprite();
		private var cont		:Sprite = new Sprite();
		private var ballMask	:Shape = new Shape();
		private var ballLight	:BallLight;
		private var texture		:BallMatrixTexture;
		private var cash		:Bitmap;
		
		private var textureX	:Number = 0;
		private var textureY	:Number = 0;
		
		private var prevFixedX	:Number = 0;
		private var prevFixedY	:Number = 0;
		
		private var shadow		:BallDrapShadow;
		private var hitZone		:Sprite;
		
		private var _radius		:Number;
		
		private var id			:uint;
		
		
		//----------------------------------------------------------------------
		//
		//	constructor
		//
		//----------------------------------------------------------------------
		
		public function ViewBall(modelBall:ModelBall) 
		{
			_modelBall = modelBall;
			init();
			id = MathUtils.randRangeInt(1, 10000);
		}

		//----------------------------------------------------------------------
		//
		//	getters / setters
		//
		//----------------------------------------------------------------------
		
		private function set draged(value:Boolean):void
		{
			_draged = value;
			
			if (_draged)
			{
				beginDrag()
			}
			else
			{
				Drop();
			}
		}
		
		private function get draged():Boolean
		{
			return _draged;
		}
		
		//----------------------------------------------------------------------
		//
		//	overreded methods
		//
		//----------------------------------------------------------------------
		
		override public function set x(value:Number):void
		{
			
			
			if (!_draged && !fixed)
			{
				var dif:Number = value - super.x;
				textureX += dif;
				texture.posX = textureX;
				
			}
			else
			{
				if (fixed)
				{
					var d:Number = modelBall.fixedDisplace.x - prevFixedX;
					texture.posX += d;
					prevFixedX = modelBall.fixedDisplace.x;
				}
			}
			super.x = value;
			
		}
		
		override public function set y(value:Number):void
		{
			if (!_draged && !fixed)
			{
				var dif:Number = value - super.y;
				textureY += dif;
				texture.posY = textureY;
			}
			else
			{
				if (fixed)
				{
					var d:Number = modelBall.fixedDisplace.y - prevFixedY;
					texture.posY += d;
					prevFixedY = modelBall.fixedDisplace.y;
				}
			}
			super.y = value;
		}
		
		//----------------------------------------------------------------------
		//
		//	private methods
		//
		//----------------------------------------------------------------------
		
		private function init():void
		{
			_radius = _modelBall.radius;
			var textureID:uint = _modelBall.type;
			texture = new BallMatrixTexture(_radius, textureID);
			visible = true;
			initSingletons();
			initVisual();
			setMouseArea();
			initListeners();
		}
		
		private function initSingletons():void
		{
			model = Model.instance;
			controller = Controller.instance;
			view = View.instance;
		}
		
		private function initVisual():void
		{
			shadow = new BallDrapShadow();
			shadow.width = _radius * 2.1;
			shadow.height = _radius * 2.1;
			shadow.cacheAsBitmap = true;
			shadow.alpha = 0.3;
			addChild(shadow);
			
			ballMask.graphics.beginFill(0x0);
			ballMask.graphics.drawCircle(0, 0, _radius);
			
			body.addChild(texture);
			//body.addChild(ballMask);
			//body.mask = ballMask;
			
			cont.addChild(body);
			ballLight = new BallLight();
			ballLight.width = _radius * 2 + 2;
			ballLight.height = _radius * 2 + 2;
			//ballLight.cacheAsBitmap = true;
			cont.addChild(ballLight);
			cont.addChild(ballMask);
			cont.mask = ballMask;
			
			addChild(cont);
			
			body.filters = [new FishEyeMap(2 * _radius, 2 * _radius, 0.7).filter,];
			visible = false;
			

		}
		
		private function setMouseArea():void
		{
			hitZone = new Sprite();
			var guid:Number;
			if (model.config.showArea)
			{
				guid = 0.3;
			}
			else
			{
				guid = 0;
			}
			var circle:Shape = new Shape();
			circle.graphics.beginFill(0x0055dd, guid);
			circle.graphics.drawCircle(0, 0, _radius * model.config.hitAreaRadius);
			hitZone.addChild(circle);
			addChild(hitZone);
			
			mouseEnabled = false;
			
		}
		
		private function initListeners():void
		{
			model.addEventListener(GamePlayEvent.STEP, model_stepHandler, 
				false, GamePlayEvent.$ORDER_STEP_VIEWBALL, true);
			model.addEventListener(GamePlayEvent.DRAGED_ELEMENT, 
				model_dragedElementHandler, false, 0, true);
			model.addEventListener(GamePlayEvent.DROPED_ELEMENT, 
				model_dropedElementHandler, false, 0, true);
			model.addEventListener(GamePlayEvent.SUCCESS_DROP, 
				model_successDropHandler, false, 0, true);
			model.addEventListener(GamePlayEvent.FAILED_DROP, 
				model_failedDropHandler, false, 0, true);
			model.addEventListener(ModelEvent.BALL_REMOVED,
				model_ballRemovedHandler, false, 0, true);
			
			enableUserListeners();
			
			
			modelBall.addEventListener(ModelBallEvent.START,
				modelBall_startHandler, false, 0, true);
			modelBall.addEventListener(ModelBallEvent.GAME_ENABLED,
				modelBall_gameEnabledHandler, false, 0, true);
			modelBall.addEventListener(ModelBallEvent.ANIMATION_TO_TARGET,
				modelBall_animationToTargetHandler, false, 0, true);
		}
		
		private function removeListeners():void
		{
			model.removeEventListener(GamePlayEvent.STEP, model_stepHandler);
			model.removeEventListener(GamePlayEvent.DRAGED_ELEMENT, 
				model_dragedElementHandler);
			model.removeEventListener(GamePlayEvent.DROPED_ELEMENT, 
				model_dropedElementHandler);
			model.removeEventListener(GamePlayEvent.SUCCESS_DROP, 
				model_successDropHandler);
			model.removeEventListener(GamePlayEvent.FAILED_DROP, 
				model_failedDropHandler);
			model.removeEventListener(ModelEvent.BALL_REMOVED,
				model_ballRemovedHandler);
			
			modelBall.removeEventListener(ModelBallEvent.START,
				modelBall_startHandler);
			modelBall.removeEventListener(ModelBallEvent.GAME_ENABLED,
				modelBall_gameEnabledHandler);
			modelBall.removeEventListener(ModelBallEvent.ANIMATION_TO_TARGET,
				modelBall_animationToTargetHandler);
			
			model.basket.removeEventListener(ModelBasketEvent.MOVE,
				model_basket_moveHandler);
			
			
			disableUserListeners();
		}
		
		private function enableUserListeners():void
		{
			hitZone.useHandCursor = true;
			hitZone.buttonMode = true;
			hitZone.addEventListener(MouseEvent.MOUSE_DOWN, hitZone_mouseDownHandler, false, 0, true);
		}
		
		private function disableUserListeners():void
		{
			hitZone.removeEventListener(MouseEvent.MOUSE_DOWN, hitZone_mouseDownHandler);
		}
		
		private function beginDrag():void
		{
			if (cash && cont.contains(cash)) 
			{
				cont.removeChild(cash);
			}
			var bmp:BitmapData = new BitmapData(cont.width, cont.height, true, 0x00000000);
			bmp.draw(cont, new Matrix (1, 0, 0, 1, Math.round(+ bmp.width / 2), Math.round(+ bmp.height / 2)));
			cash = new Bitmap (bmp);
			cash.smoothing = true;
			cash.x = Math.round(- bmp.width / 2);
			cash.y = Math.round(- bmp.height / 2);
			cont.addChild(cash);
		}
		
		private function Drop():void
		{
			//cont.removeChild(cash);
		}
		
		private function finishDrop():void
		{
			cont.removeChild(cash);
		}
		
		
		private function sendDragedAction():void
		{
			var point:Point = new Point(stage.mouseX, stage.mouseY);
			var action:DragedElementAction = new DragedElementAction(this, modelBall, point);
			controller.accepViewAction(this, action);
		}
		
		private function updateVisual():void
		{
			x = modelBall.x ;
			y = modelBall.y;
			var h:Number = modelBall.h;
			cont.scaleX = h;
			cont.scaleY = h;
			var displace:Number = _radius * 0.3 + _radius * (modelBall.h - 1) * 2;
			shadow.y = - _radius + displace;
			shadow.x = - _radius + displace;
		}
		
		private function fixBall():void
		{
			updateVisual();
			removeListeners();
			mouseEnabled = false;
			model.basket.addEventListener(ModelBasketEvent.MOVE,
				model_basket_moveHandler, false, 0, true);
			fixed =  true;
			cacheAsBitmap = true;
		}
		
		private function clear():void
		{
			removeListeners();
		}
		
		//----------------------------------------------------------------------
		//
		//	event handlers
		//
		//----------------------------------------------------------------------
		
		private function hitZone_mouseDownHandler(e:MouseEvent):void
		{
			sendDragedAction();
		}
		
		private function model_dragedElementHandler(e:GamePlayEvent):void
		{
			if (e.element == modelBall)
			{
				draged = true;
			}
		}
		
		private function model_dropedElementHandler(e:GamePlayEvent):void
		{
			if (e.element == modelBall)
			{
				draged = false;
			}
		}
		
		private function model_successDropHandler(e:GamePlayEvent):void
		{
			if (modelBall == e.element)
			{
				fixBall();
				finishDrop();
			}
		}
		
		private function model_failedDropHandler(e:GamePlayEvent):void
		{
			if (modelBall == e.element)
			{
				finishDrop();
			}
		}
		
		private function modelBall_startHandler(e:ModelBallEvent):void
		{
			visible = true;
		}
		
		private function modelBall_gameEnabledHandler(e:ModelBallEvent):void
		{
			//enableUserListeners();
		}
		
		private function modelBall_animationToTargetHandler(e:ModelBallEvent):void
		{
			//disableUserListeners();
		}
		
		
		private function model_ballRemovedHandler(e:ModelEvent):void 
		{
			if (modelBall == e.modelBall)
			{
				clear();
			}
		}
		
		private function model_stepHandler(e:GamePlayEvent):void 
		{
			updateVisual();
		}
		
		private function model_basket_moveHandler(e:ModelBasketEvent):void
		{
			x = e.x + modelBall.fixedDisplace.x;
			y = e.y + modelBall.fixedDisplace.y;
		}
	}

}