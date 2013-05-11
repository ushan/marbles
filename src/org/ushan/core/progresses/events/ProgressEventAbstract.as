package org.ushan.core.progresses.events
{
	import flash.events.Event;
	
	import org.ushan.core.progresses.IProgressable;
	import org.ushan.core.progresses.ProgressTaskAbstract;
	

	public class ProgressEventAbstract extends Event
	{
		public static const START		:String = "start";
		public static const PROGRESS	:String = "progress";
		public static const COMPLETE	:String = "complete";
		public static const ERROR		:String = "error";
		public static const ABORT		:String = "abort";
		
		//----------------------------------------------------------------------
		//	private fields
		//----------------------------------------------------------------------
		private var _percentage		:Number = 0;
		private var _targ			:IProgressable;
		private var _resultError	:uint = 1000;
		private var _prefix			:String = "unknown";
		private var _resultsArray	:Array;
		private var _resultsList	:Vector.<ProgressTaskAbstract>;
		
		//----------------------------------------------------------------------
		//
		//	constructor
		//
		//---------------------------------------------------------------------
		
		public function ProgressEventAbstract(type:String, percentage:Number, targ:IProgressable, bubbles:Boolean=false, cancelable:Boolean=false):void
		{
			super(type, bubbles, cancelable);
			_percentage = percentage;
			_targ = targ;
			_resultError = resultError;
		}
		
		//----------------------------------------------------------------------
		//
		//	getters / setters
		//
		//----------------------------------------------------------------------
		
		public function get targ():IProgressable
		{
			return _targ;
		}
		
		public function get percentage():Number
		{
			return _percentage;
		}
		
		public function get resultError():uint
		{
			return _resultError;
		}
		public function setResultError(value:uint):void
		{
			_resultError = value;
		}
		
		public function get prefix():String
		{
			return _prefix;
		}
		public function setPrefix(value:String):void
		{
			_prefix = value;
		}
		
		public function get resultsArray():Array
		{
			return _resultsArray;
		}
		
		public function setResultsArray(value:Array):void
		{
			_resultsArray = value;
		}
		
		public function get resultsList():Vector.<ProgressTaskAbstract>
		{
			return _resultsList;
		}
		
		public function setResultsList(value:Vector.<ProgressTaskAbstract>):void
		{
			_resultsList = value;
		}

		
		
		
	}
}