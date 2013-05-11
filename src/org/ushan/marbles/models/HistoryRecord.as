package org.ushan.marbles.models
{
	public class HistoryRecord
	{
		//----------------------------------------------------------------------
		//	getters / setters
		//----------------------------------------------------------------------
		private var _gamesPlayed				:uint;
		public function get gamesPlayed()		:uint { return _gamesPlayed };
		public function set gamesPlayed(value	:uint):void	
		{	
			_soXML.@gamesPlayed = String(value); 
			_gamesPlayed = value;	
		}

		private var _gamesFinished				:uint;
		public function get gamesFinished()		:uint { return _gamesFinished };
		public function set gamesFinished(value	:uint):void	
		{
			_soXML.@gamesFinished = String(value); 
			_gamesFinished = value;
		}
		
		private var _bestTime					:uint;
		public function get bestTime()			:uint { return _bestTime };
		public function set bestTime(value		:uint):void	
		{
			_soXML.@bestTime[0] = String(value);
			_bestTime = value;
		}
		
		private var _totalTime					:uint;
		public function get totalTime()			:uint { return _totalTime };
		public function set totalTime(value		:uint):void	
		{
			_soXML.@totalTime[0] = String(value); 
			_totalTime = value;
		}
		
		private var _totalMarbles				:uint;
		public function get totalMarbles()		:uint { return _totalMarbles };
		public function set totalMarbles(value	:uint):void	
		{
			_soXML.@totalMarbles[0] = String(value); 
			_totalMarbles = value;
		}
		
		private var _crrMarbles					:uint;
		public function get crrMarbles()		:uint { return _crrMarbles };
		public function set crrMarbles(value	:uint):void	
		{
			_soXML.@crrMarbles[0] = String(value); 
			_crrMarbles = value;
		}
		
		private var _crrGameMode				:uint;
		public function get crrGameMode()		:uint { return _crrGameMode };
		public function set crrGameMode(value	:uint):void	
		{
			_soXML.@crrGameMode[0] = String(value); 
			_crrGameMode = value;
		}
		
		private var _soXML						:XML;
		public function get soXML()				:XML { return _soXML };
		
		//----------------------------------------------------------------------
		//
		//	private fields
		//
		//----------------------------------------------------------------------
		private var model			:Model;
		private var ns				:Namespace = new Namespace("org.ushan.marbles.models:HistoryRecord");
		
		//----------------------------------------------------------------------
		//
		//	constructor
		//
		//----------------------------------------------------------------------
		public function HistoryRecord(soXML:XML = null)
		{
			default xml namespace = ns;
			if (!soXML)
			{
				//var crrGameMode
				_soXML = <Marbles gamesPlayed="0" gamesFinished="0" bestTime="0" 
						totalTime="0" totalMarbles="0" crrMarbles="0" crrGameMode="0">
						</Marbles>;
			}
			else
			{
				_soXML = soXML;
			}
			parseXML();
		}
		
		
		
		public function toString():String
		{
			var str:String = "";
			str += "_gamesPlayed : " + _gamesPlayed + ";\n";
			str += "_gamesFinished : " + _gamesFinished + ";\n";
			str += "_bestTime : " + _bestTime + ";\n";
			str += "_totalTime : " + _totalTime + ";\n";
			str += "_totalMarbles : " + _totalMarbles + ";\n";
			str += "_crrMarbles : " + _crrMarbles + ";\n";
			str += "_crrGameMode : " + _crrGameMode + ";\n";
			return str;
		}
		
		//----------------------------------------------------------------------
		//
		//	private methods
		//
		//----------------------------------------------------------------------
		
		private function init():void
		{
			initSingletons();
		}
		private function initSingletons():void
		{
			model = Model.instance;
		}
		
		private function parseXML():void
		{
			_gamesPlayed  = parseInt(soXML.@gamesPlayed);
			_gamesFinished  = parseInt(soXML.@gamesFinished);
			_bestTime  = parseInt(soXML.@gamesFinished);
			_totalTime  = parseInt(soXML.@totalTime);
			_totalMarbles  = parseInt(soXML.@totalMarbles);
			_crrMarbles  = parseInt(soXML.@crrMarbles);
			_crrGameMode  = parseInt(soXML.@crrGameMode);
			trace("HistoryRecord parseXML" + soXML.toXMLString());
		}
	}
}