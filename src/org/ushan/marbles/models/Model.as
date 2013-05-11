package org.ushan.marbles.models
{
	import Box2D.Collision.Shapes.b2CircleDef;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2BodyDef;
	import Box2D.Dynamics.b2World;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.geom.Point;
	
	import org.ushan.core.mvc.actions.AcceptXMLAction;
	import org.ushan.core.mvc.actions.SetCurrentProgressAction;
	import org.ushan.core.mvc.interfaces.IAction;
	import org.ushan.core.mvc.interfaces.IActionInitiator;
	import org.ushan.core.mvc.interfaces.IController;
	import org.ushan.core.mvc.interfaces.IModel;
	import org.ushan.marbles.actions.DragedElementAction;
	import org.ushan.marbles.actions.DropFinishedAction;
	import org.ushan.marbles.actions.DropedElementAction;
	import org.ushan.marbles.actions.EActions;
	import org.ushan.marbles.actions.FailedDropAction;
	import org.ushan.marbles.actions.HandMoveAction;
	import org.ushan.marbles.actions.MistakeAction;
	import org.ushan.marbles.actions.RegisterViewAction;
	import org.ushan.marbles.actions.SetDebugerAction;
	import org.ushan.marbles.actions.SuccessDropAction;
	import org.ushan.marbles.actions.WinAction;
	import org.ushan.marbles.controlers.Controller;
	import org.ushan.marbles.controlers.HistoryManager;
	import org.ushan.marbles.events.ControllerEvent;
	import org.ushan.marbles.events.GamePlayEvent;
	import org.ushan.marbles.events.ModelEvent;
	import org.ushan.marbles.models.configs.Config;
	import org.ushan.marbles.models.configs.EConfigConstants;
	import org.ushan.marbles.views.View;
	
	public class Model extends EventDispatcher  implements IModel, IActionInitiator
	{
		//----------------------------------------------------------------------
		//
		//	singletone
		//
		//----------------------------------------------------------------------
		private static var _instance			:Model;
		public static function get instance()	:Model	{ return _instance;	}
		
		//----------------------------------------------------------------------
		//	read only
		//----------------------------------------------------------------------
		
		private var _config						:Config;
		public function get  config()			:Config { return _config }
		
		private var _currentState				:CurrentState;
		public function get  currentState()		:CurrentState { return _currentState }
		
		//private var _historyManager			:HistoryManager;
		//public function get  historyManager()	:HistoryManager { return _historyManager }
		
		private var _ballManager				:ModelBallManager;
		public function get  ballManager()		:ModelBallManager { return _ballManager }
		
		private var _world						:b2World;
		public function get  world()			:b2World { return _world }
		
		private var _space						:Space;
		public function get  space()			:Space { return _space}
		
		private var _basket						:ModelBasket;
		public function get  basket()			:ModelBasket { return _basket}
		
		//----------------------------------------------------------------------
		//	private fields
		//----------------------------------------------------------------------
		private var controller		:Controller;
		private var view			:View;
		
		private var _ship		:b2Body;
		
		//----------------------------------------------------------------------
		//
		//	constructor
		//
		//----------------------------------------------------------------------
		
		public function Model()
		{
			super();
			_instance = this;
			init();

		}
		
		//----------------------------------------------------------------------
		//
		//	getter / stetter
		//
		//----------------------------------------------------------------------
		

		
		//----------------------------------------------------------------------
		//
		//	static methods
		//
		//----------------------------------------------------------------------
		
		
		//----------------------------------------------------------------------
		//
		//	public methods
		//
		//----------------------------------------------------------------------
		
		public function acceptAction(initiator:IController, action:IAction):void
		{
			switch (action.reflect)
			{
				case EActions.REGISTER_VIEW:
					action_registerView(action as RegisterViewAction);
					break;
				case EActions.TO_START_GAME:
					action_toStartGame();
					break;
				case EActions.APPEAR_COMPLETE:
					action_appearComplete();
					break;
				case EActions.SET_DEBUGER:
					var setDebugerAction:SetDebugerAction = action as SetDebugerAction;
					action_setDebuger(setDebugerAction.debuger);
					break;
				case EActions.STEP:
					action_step();
					break;
				case EActions.SET_CURRENT_PROGRESS:
					var setCurrentProgressAction:SetCurrentProgressAction = action as SetCurrentProgressAction;
					_currentState.setCurrentProgress(this, setCurrentProgressAction.currentProgress);
					break;
				case EActions.ACCEPT_XML:
					var acceptXMLAction:AcceptXMLAction = action as AcceptXMLAction;
					action_xmlWasInited(acceptXMLAction.xml);
					break;
				case EActions.HAND_MOVE:
					action_handMove(action as HandMoveAction)
					break;
				case EActions.DRAGED_ELEMENT:
					var dragedElementAction:DragedElementAction = action as DragedElementAction; 
					action_dragedElement(dragedElementAction.element, dragedElementAction.point);
					break;
				case EActions.DROPED_ELEMENT:
					var dropedElementAction:DropedElementAction = action as DropedElementAction; 
					action_dropedElement(dropedElementAction.element);
				case EActions.DROP_CURRENT:
					action_dropCurrent();
					break;
				case EActions.DROP_FINISHED://This trucs need to be placed  in the view
					action_dropFinished(action as DropFinishedAction);
					break;
				case EActions.SUCCESS_DROP:
					action_successDrop(action as SuccessDropAction);
					break;
				case EActions.FAILED_DROP:
					action_failedDrop(action as FailedDropAction);
					break;
				case EActions.MISTAKE:
					action_mistake(action as MistakeAction);
					break;
				case EActions.WIN:
					action_win(action as WinAction);
					break;
				default:
					throw new Error("UError. There is not an action with type " + action.reflect);
			}
		}
		
		internal function passEvent(initiator:IModel, event:Event):void
		{
			//---> begin debug
			var declarated:Boolean = 
			(event.type == ModelEvent.XML_WAS_INITED) ||
			(event.type == GamePlayEvent.START_GAME) ||
			(event.type == GamePlayEvent.APPEAR_COMPLETE) ||
			(event.type == GamePlayEvent.STEP) ||
			(event.type == GamePlayEvent.DRAGED_ELEMENT) ||
			(event.type == GamePlayEvent.DROPED_ELEMENT) ||
			(event.type == GamePlayEvent.SUCCESS_DROP) ||
			(event.type == GamePlayEvent.DROPED_FINISHED) ||
			(event.type == GamePlayEvent.FAILED_DROP) ||
			(event.type == GamePlayEvent.MISTAKE) ||
			(event.type == GamePlayEvent.HAND_MOVE) ||
			(event.type == GamePlayEvent.WIN) ||
			(event.type == ModelEvent.BALL_REMOVED)||
			(event.type == ModelEvent.BALL_ADDED);
			//trace(event + "  " + event.type);
			if (!declarated)
			{
				throw new Error("UError. Model. Event: " + event + ", type " + event.type + " was not declarated");
			}
			//---> finish debug
			dispatchEvent(event);
		}

		
		//----------------------------------------------------------------------
		//
		//	actions handler
		//
		//----------------------------------------------------------------------
		
		private function action_registerView(action:RegisterViewAction):void
		{
			config.setStageSize(this, action.view.stage);
		}
		
		private function action_xmlWasInited(xml:XML):void
		{
			config.setXml(this, xml);
			initWorld();
			var event:ModelEvent = new ModelEvent(ModelEvent.XML_WAS_INITED);
			passEvent(this, event);
		}
		
		private function action_toStartGame():void
		{
			startGame();
			var event:GamePlayEvent = new GamePlayEvent(GamePlayEvent.START_GAME);
			passEvent(this, event);
		}
		
		private function action_appearComplete():void
		{
			var event:GamePlayEvent = new GamePlayEvent(GamePlayEvent.APPEAR_COMPLETE);
			passEvent(this, event);
		}
		
		private function action_setDebuger(debuger:Sprite):void
		{
			_space.setDebuger(this, view.debuger);
		}
		
		private function action_step():void
		{
			update();
		}
		
		private function action_handMove(action:HandMoveAction):void
		{
			var event:GamePlayEvent = new GamePlayEvent(GamePlayEvent.HAND_MOVE);
			event.setPoint(action.point);
			passEvent(this, event);
		}
		
		private function action_dragedElement(element:ModelBall, point:Point):void
		{
			ballManager.dragBall(this, element, point);
			var event:GamePlayEvent = new GamePlayEvent(GamePlayEvent.DRAGED_ELEMENT);
			event.setElement(element);
			passEvent(this, event);
		}
		
		private function action_dropedElement(element:ModelBall):void
		{
			ballManager.dropBall(this, element);
			var event:GamePlayEvent = new GamePlayEvent(GamePlayEvent.DROPED_ELEMENT);
			event.setElement(element);
			passEvent(this, event);
		}
		
		private function action_dropCurrent():void
		{
			if (ballManager && ballManager.selected)
			{
				var element:ModelBall = ballManager.selected;
				ballManager.dropBall(this, element);
				var event:GamePlayEvent = new GamePlayEvent(GamePlayEvent.DROPED_ELEMENT);
				event.setElement(element);
				passEvent(this, event);
			}
		}
		
		private function action_mistake(action:MistakeAction):void
		{
			var event:GamePlayEvent = new GamePlayEvent(GamePlayEvent.MISTAKE);
			event.setElement(action.element);
			passEvent(this, event);
		}
		
		private function action_successDrop(action:SuccessDropAction):void
		{
			ballManager.successDrop(this, action.element, action.point);
			//_currentState.addSuccess();
			var event:GamePlayEvent = new GamePlayEvent(GamePlayEvent.SUCCESS_DROP);
			event.setPoint(action.point);
			event.setElement(action.element);
			passEvent(this, event);
		}
		
		private function action_failedDrop(action:FailedDropAction):void
		{
			ballManager.failedDrop(this, action.element, action.point);
			var event:GamePlayEvent = new GamePlayEvent(GamePlayEvent.FAILED_DROP);
			event.setPoint(action.point);
			event.setElement(action.element);
			passEvent(this, event);
		}
		
		private function action_dropFinished(action:DropFinishedAction):void
		{
			checkSuccess(action.element, action.point);
			var event:GamePlayEvent = new GamePlayEvent(GamePlayEvent.DROPED_FINISHED);
			passEvent(this, event);
		}
		
		private function action_win(action:WinAction):void
		{
			var event:GamePlayEvent = new GamePlayEvent(GamePlayEvent.WIN);
			passEvent(this, event);
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
			controller = Controller.instance;
			_config = new Config();
			//_historyManager = new HistoryManager();
			_currentState = new CurrentState();
		}
		
		private function initListeners():void
		{
			controller.addEventListener(ControllerEvent.VIEW_INITED, controller_viewInitedHandler);
		}
		
		private function initView():void
		{
			view = View.instance;
		}
		
		private function initWorld():void
		{
			_space = new Space();
			_world = space.world;
			_basket = new ModelBasket();

		}
		
		private function startGame():void
		{
			if (!_ballManager)
			{
				_ballManager = new ModelBallManager();
			}
			//currentState.resetScores();
			_ballManager.resetBalls(this);
			_ballManager.createBalls(this);
		}
		
		private function checkSuccess(modelBall:ModelBall, point:Point):void
		{
			
			var success:Boolean = _basket.checkHit(point);
			
			if (success)
			{
				
				var actionSuccess:SuccessDropAction = new SuccessDropAction(this, modelBall, point);
				controller.accepModelAction(this, actionSuccess);
			}
			else
			{
				var actionFailed:FailedDropAction = new FailedDropAction(this, modelBall, point);
				controller.accepModelAction(this, actionFailed);
			}
			
		}
		
		private function update():void
		{
			//_world.Step(EConfigConstants.PH_TIME_STEP, EConfigConstants.PH_ITERATIONS);
			var event:GamePlayEvent = new GamePlayEvent(GamePlayEvent.STEP);
			//dispatchEvent(event);
			passEvent(this, event);
		}
		//----------------------------------------------------------------------
		//
		//	event handlers
		//
		//----------------------------------------------------------------------
		private function controller_viewInitedHandler(e:ControllerEvent):void
		{
			initView();
		}
	}
}
