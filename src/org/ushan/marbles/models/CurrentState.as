package org.ushan.marbles.models
{
	import fl.core.UIComponent;
	
	import flash.external.ExternalInterface;
	import flash.utils.clearInterval;
	import flash.utils.getTimer;
	import flash.utils.setInterval;
	
	import org.ushan.core.mvc.interfaces.IActionInitiator;
	import org.ushan.core.mvc.interfaces.IModel;
	import org.ushan.core.progresses.IProgressable;
	import org.ushan.geom.MathUtils;
	import org.ushan.marbles.actions.SaveToEnvironmentAction;
	import org.ushan.marbles.actions.WinAction;
	import org.ushan.marbles.controlers.Controller;
	import org.ushan.marbles.events.GamePlayEvent;
	import org.ushan.marbles.events.ModelEvent;
	import org.ushan.marbles.models.configs.EConfigConstants;
	import org.ushan.marbles.views.View;
	import org.ushan.utils.XMLUtils;

	public class CurrentState implements IModel, IActionInitiator
	{
		//----------------------------------------------------------------------
		//	read only
		//----------------------------------------------------------------------
		public function get successes()			:uint { return _successes};
		private var _successes					:uint;
		
		private var _mistakes					:uint;
		public function get mistakes()			:uint { return _mistakes};
		
		private var _mistakesTotal				:uint;
		public function get mistakesTotal()		:uint { return _mistakesTotal};
		
		private var _nextBallType				:uint;
		public function get nextBallType()		:uint { return _nextBallType};
		
		
		public function get gamesFinished()		:uint { return _gamesFinished }; //current session
		private var _gamesFinished				:uint;
		
		public function get gameTime()			:uint { return _gameTime }; //current session (milliseconds)
		private var _gameTime					:uint;
		
		public function get totalMarbles()		:uint { return model.config.totalMarbles }; //current game 
		//private var _totalMarbles				:uint;
		
		
		public function get collectedMarbles()	:uint { return _collectedMarbles }; //current session
		private var _collectedMarbles			:uint;
		
		public function get drops()				:uint { return _drops }; //current game
		private var _drops						:uint;
		
		public function get score()				:int { 
		return _collectedMarbles *  model.config.bonusIncrement + model.config.bonus * gamesFinished };
		//private var _score						:uint;


		//----------------------------------------------------------------------
		//	private fields
		//----------------------------------------------------------------------
		private var model				:Model;
		private var controller			:Controller;
		private var view				:View;
		
		private var lastSavedTime		:int = 0;
		private var intervalForTime		:int;
		
		private var _currentProgress	:IProgressable
		
		//----------------------------------------------------------------------
		//
		//	constructor
		//
		//----------------------------------------------------------------------
		
		public function CurrentState()
		{
			init();
		}
		
		
		public function get currentProgress():IProgressable 
		{
			return _currentProgress; 
		}
		
		public function setCurrentProgress(initiator:Model, progressbar:IProgressable):void
		{
			_currentProgress = progressbar;			
			var event:ModelEvent = new ModelEvent(ModelEvent.PROGRESS_TARGET_CHANGE);
			event.setProgressTarget(progressbar);
			model.dispatchEvent(event);			
		}
		
		
		
		//----------------------------------------------------------------------
		//
		//	internal
		//
		//----------------------------------------------------------------------
		
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
			controller = Controller.instance;
		}
		
		private function initListeners():void
		{
			
			model.addEventListener(GamePlayEvent.START_GAME, model_startGameHandler,
				false, GamePlayEvent.$ORDER_STARTGAME_CURRENTSTATE, true);
			model.addEventListener(GamePlayEvent.WIN, model_winHandler, 
				false, 0, true);
			model.addEventListener(GamePlayEvent.SUCCESS_DROP, model_successDropHandler,
				false, GamePlayEvent.$ORDER_SUCCESSDROP_CURRENTSTATE, true);
			model.addEventListener(GamePlayEvent.DROPED_FINISHED, model_dropedFinishedHandler,
				false, GamePlayEvent.$ORDER_DROPEDFINISHED_CURRENTSTATE, true);
			model.addEventListener(GamePlayEvent.MISTAKE, model_mistakeHandler,
				false, GamePlayEvent.$ORDER_MISTAKE_CURRENTSTATE, true);
			model.addEventListener(GamePlayEvent.FAILED_DROP, model_failedDropHandler,
				false, GamePlayEvent.$ORDER_MISTAKE_CURRENTSTATE, true);
				
		}
		
		private function initGameListeners():void
		{
			
		}
		
		private function addSuccess():void
		{
			_successes ++;
			_collectedMarbles ++;
			if (_successes >= model.config.totalMarbles)
			{
				var action:WinAction = new WinAction(this);
				controller.accepModelAction(this, action);
			}
		}
		
		private function addMistakes():void
		{
			trace("addMistakes");
			_mistakes ++;
			_mistakesTotal ++;
		}
		
		private function resetScores():void
		{
			_successes = 0;
			_mistakes = 0;
			_drops = 0; 
		}
		
		private function nextTurn():void
		{
			_nextBallType = model.ballManager.getNextRandomType();
		}
		
		private function send_saveToEnvironmentAction():void
		{
			//tempCount++;
			var gameTimeSeconds:uint = Math.round( _gameTime / 1000);
			var dropedOut:uint = drops ;
			var params:String = score + "," + gameTimeSeconds + "," + mistakesTotal + "," + gamesFinished + "," + collectedMarbles + 
				"," + totalMarbles + "," + dropedOut;
			var action:SaveToEnvironmentAction = new SaveToEnvironmentAction(this, params);
			controller.accepModelAction(this, action);
		}
		
		private function saveTime():void
		{
			var timeInctement:uint = getTimer() - lastSavedTime;
			_gameTime += timeInctement;
			lastSavedTime = getTimer();
		}
		
		private function startTimeLogging():void
		{
			lastSavedTime = getTimer();
			saveTime();
			intervalForTime = setInterval(saveTime, 1000);
		}
		
		private function stopTimeLogging():void
		{
			saveTime();
			clearInterval(intervalForTime);
		}
		
		//----------------------------------------------------------------------
		//
		//	event handlers
		//
		//----------------------------------------------------------------------
		
		private function model_successDropHandler(e:GamePlayEvent):void
		{
			addSuccess();
			nextTurn();
			send_saveToEnvironmentAction();
		}
		
		private function model_startGameHandler(e:GamePlayEvent):void
		{
			resetScores();
			nextTurn();
			startTimeLogging();
			send_saveToEnvironmentAction();
		}
		
		private function model_mistakeHandler(e:GamePlayEvent):void
		{
			addMistakes();
			send_saveToEnvironmentAction();
		}
		
		private function model_winHandler(e:GamePlayEvent):void
		{
			_gamesFinished ++;
			stopTimeLogging();
			send_saveToEnvironmentAction();
		}
		
		
		private function model_dropedFinishedHandler(e:GamePlayEvent):void
		{
			send_saveToEnvironmentAction();
		}
		
		
		private function model_failedDropHandler(e:GamePlayEvent):void
		{
			_drops++;
			send_saveToEnvironmentAction();
		}
		


	}
}