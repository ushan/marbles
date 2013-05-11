package org.ushan.core.encoders
{
	import flash.utils.ByteArray;
	
	import org.ushan.core.progresses.IProgressable;
	import org.ushan.core.progresses.events.ProgressEventAbstract;
	
	public class JPEGEncoderEvent extends org.ushan.core.progresses.events.ProgressEventAbstract
	{
		public static const START		:String = ProgressEventAbstract.START;
		public static const PROGRESS	:String = ProgressEventAbstract.PROGRESS;
		public static const COMPLETE	:String = ProgressEventAbstract.COMPLETE;
		public static const ABORT		:String = ProgressEventAbstract.ABORT;
		
		public var result		:ByteArray

		
		//----------------------------------------------------------------------
		//
		//	constructor
		//
		//---------------------------------------------------------------------
		
		public function JPEGEncoderEvent(type:String, percentage:Number, targ:IProgressable, result:ByteArray = null, bubbles:Boolean=false, cancelable:Boolean=false):void
		{
			super(type, percentage, targ, bubbles, cancelable);
			this.result = result;
		}
	}
}