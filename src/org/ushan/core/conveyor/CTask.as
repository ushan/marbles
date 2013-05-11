package org.ushan.core.conveyor
{
	public class CTask
	{
		//----------------------------------------------------------------------
		//	read only
		//----------------------------------------------------------------------
		private var _args				:Array;
		public function get args()		:Array { return _args };
		
		private var _obj				:Object;
		public function get obj()		:Object { return _obj };
		
		private var _func				:Function;
		public function get func()		:Function { return _func };
		
		private var _frames				:uint;
		public function get frames()	:uint { return _frames };
		
		private var _framesLeft			:int;
		public function get framesLeft():int { return _framesLeft };
		public function set framesLeft(value:int):void { _framesLeft =  value};
		
		
		//----------------------------------------------------------------------
		//
		//	constructor
		//
		//----------------------------------------------------------------------
		
		public function CTask(obj:Object, func:Function, frames:uint, args:Array)
		{
			_obj = obj;
			_func = func;
			_args = args;			
			_frames = frames;
			_framesLeft = frames;			
		}

	}
}