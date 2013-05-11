package org.ushan.marbles.controlers
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.external.ExternalInterface;
	import flash.geom.Point;
	
	import org.ushan.core.mvc.actions.AcceptXMLAction;
	import org.ushan.core.mvc.interfaces.IAction;
	import org.ushan.core.mvc.interfaces.IActionInitiator;
	import org.ushan.core.mvc.interfaces.IController;
	import org.ushan.core.mvc.interfaces.IMainClass;
	import org.ushan.core.mvc.interfaces.IModel;
	import org.ushan.core.mvc.interfaces.IView;
	import org.ushan.geom.MathUtils;
	import org.ushan.marbles.actions.DragedElementAction;
	import org.ushan.marbles.actions.DropFinishedAction;
	import org.ushan.marbles.actions.DropedElementAction;
	import org.ushan.marbles.actions.EActions;
	import org.ushan.marbles.actions.FailedDropAction;
	import org.ushan.marbles.actions.HandMoveAction;
	import org.ushan.marbles.actions.MistakeAction;
	import org.ushan.marbles.actions.RegisterViewAction;
	import org.ushan.marbles.actions.SaveToEnvironmentAction;
	import org.ushan.marbles.actions.SuccessDropAction;
	import org.ushan.marbles.actions.ToStartGameAction;
	import org.ushan.marbles.events.ControllerEvent;
	import org.ushan.marbles.events.GamePlayEvent;
	import org.ushan.marbles.models.Model;
	import org.ushan.marbles.models.ModelBall;
	import org.ushan.marbles.models.configs.EConfigConstants;
	import org.ushan.marbles.models.configs.EGameMode;
	import org.ushan.marbles.views.View;
	import org.ushan.marbles.views.balls.ViewBall;

	public class Controller extends EventDispatcher implements IController, IActionInitiator
	{
		//----------------------------------------------------------------------
		//
		//	singletone
		//
		//----------------------------------------------------------------------
		
		private static var ins:Controller;
		public static function get instance():Controller
		{
			if (ins == null)
				ins = new Controller( new Singletonizer() );
			return ins;
		}
		
		public function Controller(singletonizer:Singletonizer)
		{
			ins = this;
		}
		//----------------------------------------------------------------------
		//	instance on the scene
		//----------------------------------------------------------------------
		
		//----------------------------------------------------------------------
		//	private fields
		//----------------------------------------------------------------------
		private var model			:Model;
		private var view			:View;
		private var input			:Input;
		private var taskManager		:TaskManager;
		private var historyManager	:HistoryManager;
		private var stepHolder		:Sprite;

		//----------------------------------------------------------------------
		//
		//	getters / setters
		//
		//----------------------------------------------------------------------
		
		
		//----------------------------------------------------------------------
		//
		//	Accep actions
		//
		//----------------------------------------------------------------------
		
		public function init(initiator:IMainClass, model:Model):void
		{
			this.model = model;
			initSingletons();
		}
		
/*		public function registerView(view:View):void
		{
			this.view = view;
			var event:ControllerEvent = new ControllerEvent(ControllerEvent.VIEW_INITED);
			passEvent(this, event);
			start();
		}*/
		
		public function accepModelAction(initiator:IModel, action:IAction):void
		{
			var declarated:Boolean = 
				(action.reflect == EActions.APPEAR_COMPLETE) ||
				(action.reflect == EActions.SUCCESS_DROP) ||
				(action.reflect == EActions.DROP_FINISHED) ||
				(action.reflect == EActions.FAILED_DROP) ||
				(action.reflect == EActions.WIN) ||
				(action.reflect == EActions.SAVE_TO_ENVIRONMENT);
			if (!declarated)
			{
				throw new Error("UError. Controller. ModelAction: " + action +  " was not declarated");
			}
			acceptAction(action);
		}
		
		public function accepControllerAction(initiator:IController, action:IAction):void
		{
			var declarated:Boolean = 
				(action.reflect == EActions.ACCEPT_XML) ||
				//(action.reflect == EActions.TO_START_GAME) ||
				(action.reflect == EActions.SET_CURRENT_PROGRESS) ||
				(action.reflect == EActions.STEP) ||
				(action.reflect == EActions.DROP_CURRENT) ||
				(action.reflect == EActions.MISTAKE) ||
				(action.reflect == EActions.HAND_MOVE) ||
				(action.reflect == EActions.SHOW_HIDE_INFOR) ||
				(action.reflect == EActions.SHOW_HIDE_HELP) ;
			if (!declarated)
			{
				throw new Error("UError. Controller. ControllerAction: " + action +  " was not declarated");
			}
			acceptAction(action);
		}
		
		public function accepViewAction(initiator:IView, action:IAction):void
		{
			var declarated:Boolean = 
				(action.reflect == EActions.REGISTER_VIEW) ||
				(action.reflect == EActions.TO_START_GAME) ||
				(action.reflect == EActions.SET_DEBUGER) ||
				(action.reflect == EActions.DRAGED_ELEMENT) ||
				(action.reflect == EActions.FAILED_DROP) ;
			if (!declarated)
			{
				throw new Error("UError. Controller. ViewAction: " + action +  " was not declarated");
			}
			acceptAction(action);
		}
		
		private function acceptAction(action:IAction):void
		{
			switch (action.reflect)
			{
				case EActions.REGISTER_VIEW:
					action_registerView(action as RegisterViewAction);
					break;
				case EActions.ACCEPT_XML:
					model.acceptAction(this, action);
					break;
				case EActions.SET_DEBUGER:
					model.acceptAction(this, action);
					break;
				case EActions.STEP:
					model.acceptAction(this, action);
					break;
				case EActions.SET_CURRENT_PROGRESS:
					model.acceptAction(this, action);
					break;
				case EActions.TO_START_GAME:
					model.acceptAction(this, action);
					break;
				case EActions.APPEAR_COMPLETE:
					model.acceptAction(this, action);
					break;
				case EActions.DRAGED_ELEMENT:
					action_dragedElement(action as DragedElementAction);
					break;
				case EActions.DROPED_ELEMENT:
					model.acceptAction(this, action);
					break;
				case EActions.DROP_CURRENT:
					model.acceptAction(this, action);
					break;
				case EActions.HAND_MOVE:
					model.acceptAction(this, action);
					break;
				case EActions.DROP_FINISHED:
					model.acceptAction(this, action);
					break;
				case EActions.SUCCESS_DROP:
					model.acceptAction(this, action);
					break;
				case EActions.FAILED_DROP:
					model.acceptAction(this, action);
					break;
				case EActions.MISTAKE:
					model.acceptAction(this, action);
					break;
				case EActions.WIN:
					model.acceptAction(this, action);
					break;
				case EActions.SAVE_TO_ENVIRONMENT:
					action_saveToEnvironment(action as SaveToEnvironmentAction);
					break;
				default:
					throw new Error("UError. There is not an action with type " + action.reflect);
					
			}
		}
		//----------------------------------------------------------------------
		//
		//	internal methods
		//
		//----------------------------------------------------------------------
		
		internal function passEvent(initiator:IController, event:Event):void
		{
			//---> begin debug
			var declarated:Boolean = 
				(event.type == ControllerEvent.SOUNDS_LOADED) ||
				(event.type == ControllerEvent.VIEW_INITED) ||
				(event.type == GamePlayEvent.SUCCESS_DROP) ||
				(event.type == GamePlayEvent.FAILED_DROP);
				
			if (!declarated)
			{
				throw new Error("UError. Controller. Event: " + event + ", type " + event.type + " was not declarated");
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
			model.acceptAction(this, action);
			registerView(action.view);
		}
		
		private function action_dragedElement(action:DragedElementAction):void
		{
			if (model.config.nextMarbleEnabled)
			{
				if (action.element.type == model.currentState.nextBallType)
				{
					model.acceptAction(this, action);
				}
				else
				{
					var mistakeAction:MistakeAction = new MistakeAction(this, action.element);
					accepControllerAction(this, mistakeAction);
				}
			}
			else
			{
				model.acceptAction(this, action);
			}
		}
		
		private function action_saveToEnvironment(action:SaveToEnvironmentAction):void
		{
			trace(action.paramsString);
			var result:uint = ExternalInterface.call(EConfigConstants.ENVIRONMENT_FUNC, action.paramsString);
		}
		
		//----------------------------------------------------------------------
		//
		//	private methods
		//
		//----------------------------------------------------------------------
		
		private function initSingletons():void
		{
			input = new Input();
			taskManager = new TaskManager();
			historyManager = new HistoryManager();
		}
		
		private function registerView(view:View):void
		{
			this.view = view;
			var event:ControllerEvent = new ControllerEvent(ControllerEvent.VIEW_INITED);
			dispatchEvent(event);
			initXML();
		}
		
		private function initXML():void
		{
			taskManager.loadXML()
		}
		

		//----------------------------------------------------------------------
		//
		//	event handlers
		//
		//----------------------------------------------------------------------
		
/*		private function stepHolder_EnterFrameHandler(e:Event):void
		{
			
		}
*/
		
	}
	
/*	class BranchesList
	{
		//----------------------------------------------------------------------
		//
		//	constructor
		//
		//----------------------------------------------------------------------
		
		public function BranchesList ():void
		{
			
		}
		
		//----------------------------------------------------------------------
		//
		//	getters / setters
		//
		//----------------------------------------------------------------------
	}*/
}
class Singletonizer{}

