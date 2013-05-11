package org.ushan.marbles.models
{
	public class TimeInfo
	{
		//----------------------------------------------------------------------
		//	read only
		//----------------------------------------------------------------------
		
		private var _currentTimeSpent			:uint;
		public function get currentTimeSpent()	:uint { return _currentTimeSpent };
		
		private var _gameTimeSpent				:uint;
		public function get gameTimeSpent()		:uint { return _gameTimeSpent };
		
		private var _bestTime					:uint;
		public function get bestTime()			:uint { return _bestTime };
		
		//----------------------------------------------------------------------
		//
		//	constructor
		//
		//----------------------------------------------------------------------
		public function TimeInfo(	   currentTimeSpent	:uint,
									   gameTimeSpent	:uint,
									   bestTime			:uint)
		{
			_currentTimeSpent = currentTimeSpent;
			_gameTimeSpent = gameTimeSpent;
			_bestTime = bestTime;
		}
		
		public function toString():String
		{
			var str:String = "";
			str += "_currentTimeSpent : " + _currentTimeSpent + ";\n";
			str += "_gameTimeSpent : " + _gameTimeSpent + ";\n";
			str += "_bestTime : " + _bestTime + ";\n";
			return str;
		}
	}
}