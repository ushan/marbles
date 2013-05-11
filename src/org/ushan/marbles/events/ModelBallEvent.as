package org.ushan.marbles.events
{
	import flash.events.Event;
	
	public class ModelBallEvent extends Event
	{
		public static const START				:String = "start";
		public static const ANIMATION_TO_TARGET	:String = "animationToTarget";
		public static const GAME_ENABLED		:String = "gameEnabled";
		
		//----------------------------------------------------------------------
		//	orders
		//----------------------------------------------------------------------
		
		//----------------------------------------------------------------------
		//	private fields
		//----------------------------------------------------------------------
		
		public function ModelBallEvent(type:String)
		{
			super(type, bubbles, cancelable);
		}
	}
}