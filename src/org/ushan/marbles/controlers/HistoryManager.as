package org.ushan.marbles.controlers
{
	import flash.events.EventDispatcher;
	import flash.net.SharedObject;
	import flash.utils.clearInterval;
	import flash.utils.getTimer;
	import flash.utils.setInterval;
	
	import org.ushan.core.mvc.interfaces.IActionInitiator;
	import org.ushan.core.mvc.interfaces.IController;
	import org.ushan.marbles.actions.TimeStepAction;
	import org.ushan.marbles.events.ConfigEvent;
	import org.ushan.marbles.events.GamePlayEvent;
	import org.ushan.marbles.events.ModelEvent;
	import org.ushan.marbles.models.HistoryRecord;
	import org.ushan.marbles.models.Model;
	import org.ushan.marbles.models.TimeInfo;
	import org.ushan.marbles.models.configs.EConfigConstants;
	import org.ushan.utils.XMLUtils;

	public class HistoryManager extends EventDispatcher implements IActionInitiator, IController
	{
		//----------------------------------------------------------------------
		//	private fields
		//----------------------------------------------------------------------
		
		private var controller		:Controller;
		private var model			:Model;
		
		private var lastSavedTime	:int = 0;
		private var interval		:int;
		
		private var usersSO			:SharedObject;
		private var historyRecord	:HistoryRecord
		
		private var startTime		:uint;
		


		
		/**
		 *Do not used now 
		 * 
		 */
		public function HistoryManager()
		{
			super();
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
			initSingletons();
			initListeners();
			
		}
		
		private function initSingletons():void
		{
			controller = Controller.instance;
			model = Model.instance;
		}
		
		private function initListeners():void
		{
			model.addEventListener(GamePlayEvent.START_GAME, model_startGameHandler, 
				false, 0, true);
			model.addEventListener(GamePlayEvent.WIN, model_winHandler, 
				false, 0, true);
			model.addEventListener(GamePlayEvent.SUCCESS_DROP, model_successDropHandler, 
				false, 0, true);
			model.addEventListener(ModelEvent.XML_WAS_INITED, model_xmlWasInitedHandler, 
				false, ModelEvent.$ORDER_XMLWASINITED_HISTORYMANAGER, true);
		}
		
		private function loadSavedSO():void
		{
			usersSO = SharedObject.getLocal(EConfigConstants.SO_NAME);
			var savedXML:XML = usersSO.data["User" + model.config.userID.toString()] as XML;
			historyRecord = new HistoryRecord(savedXML);
			//totalTime = historyRecord.totalTime;
		}
		
		private function saveData():void
		{
			var d:Date = new Date();
			//trace(d.toLocaleString());
			usersSO = SharedObject.getLocal(EConfigConstants.SO_NAME);
			usersSO.data["User" + model.config.userID.toString()] = historyRecord.soXML;
			usersSO.data["historyUsr" + model.config.userID.toString() + "Game" + historyRecord.gamesPlayed] = historyRecord.soXML.toXMLString();
			//usersSO.data["historyUsr" + model.config.userID.toString() + "Game" + temp_recordID] = historyRecord.soXML.toXMLString();
		}
		
		private function startTimeLogging():void
		{
			
			lastSavedTime = Math.floor(getTimer()/1000);
			interval = setInterval(logTime, 1000);
			startTime = lastSavedTime;
		}
		
		private function stopTimeLogging():void
		{
			lastSavedTime = Math.floor(getTimer()/1000);
			clearInterval(interval);
		}
		
		private function logWinTime():void
		{
			
			var currentTime:int = Math.floor(getTimer()/1000);
			//model.currentState.currentNode.@currentTimeSpent[0] = "0s";
			historyRecord.gamesFinished++;
			var gameTime:uint = currentTime - startTime;
			if (gameTime < historyRecord.bestTime || historyRecord.bestTime == 0 ) historyRecord.bestTime = gameTime;
			saveData();
			
		}
		
		private function logTime():void
		{
			var currentTime:int = Math.floor(getTimer()/1000);
			var currentTimeSpent:int;
			var gameTimeSpent	:int;
			var bestTime		:int;
			
			currentTimeSpent = currentTime - lastSavedTime ;
			historyRecord.totalTime += currentTimeSpent;
			saveData();
			var timeInfo:TimeInfo = new TimeInfo(currentTimeSpent,
				gameTimeSpent, bestTime);
			
			
			var action:TimeStepAction = new TimeStepAction(this, timeInfo);
			//controller.accepControllerAction(this, action);
			
			lastSavedTime = currentTime;
		}
		
		//----------------------------------------------------------------------
		//
		//	event handlers
		//
		//----------------------------------------------------------------------
		
		private function model_xmlWasInitedHandler (e:ModelEvent):void
		{
			loadSavedSO();
		}
		
		private function model_config_puzzleImageSelectedHandler(e:ConfigEvent):void
		{
		}
		
		private function model_startGameHandler (e:GamePlayEvent):void
		{
			startTimeLogging();
			historyRecord.gamesPlayed++;
			saveData();
			
		}
		
		private function model_winHandler (e:GamePlayEvent):void
		{
			
			logTime();
			logWinTime();
			saveData();
			stopTimeLogging();
		}
		
		private function model_successDropHandler (e:GamePlayEvent):void
		{
			historyRecord.totalMarbles++;
			saveData();
			
		}
		
	}
}