package org.ushan.marbles.events
{
	import flash.events.Event;
	
	public class ModelBasketEvent extends Event
	{
		public static const MOVE	:String = "move";
		
		//----------------------------------------------------------------------
		//	read only
		//----------------------------------------------------------------------
		private var _x			:Number;
		public function get x()	:Number { return _x};
		
		private var _y			:Number;
		public function get y()	:Number { return _y};
		
		//----------------------------------------------------------------------
		//
		//	constructor
		//
		//----------------------------------------------------------------------
		
		public function ModelBasketEvent(type:String, x:Number, y:Number)
		{
			super(type);
			_x = x;
			_y = y;
		}
	}
}