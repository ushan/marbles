package org.ushan.marbles.events
{
	import flash.events.Event;
	
	import org.ushan.core.progresses.IProgressable;
	import org.ushan.marbles.models.ModelBall;
	
	public class ModelEvent extends Event
	{
		public static const BALL_ADDED				:String = "ballAdded";
		public static const BALL_REMOVED			:String = "ballRemoved";
		public static const PROGRESS_TARGET_CHANGE	:String = "progressTargetChange";
		public static const XML_WAS_INITED			:String = "xmlWasInited";
		
		//----------------------------------------------------------------------
		//	orders
		//----------------------------------------------------------------------
		public static const $ORDER_XMLWASINITED_HISTORYMANAGER	:uint = 100;
		
		private static var _progressTarget	:IProgressable ;
		private static var _modelBall		:ModelBall ;
		
		//----------------------------------------------------------------------
		//
		//	constructor
		//
		//----------------------------------------------------------------------
		
		public function ModelEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
		public function get progressTarget():IProgressable
		{
			return _progressTarget;
		}
		
		public function setProgressTarget(value:IProgressable):void
		{
			_progressTarget = value;
		}
		
		public function get modelBall():ModelBall
		{
			return _modelBall;
		}
		
		public function setModelBall(value:ModelBall):void
		{
			_modelBall = value;
		}
		

	}
}