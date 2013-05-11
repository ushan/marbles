package org.ushan.marbles.actions
{
	import org.ushan.core.mvc.actions.ActionAbstract;
	import org.ushan.core.mvc.interfaces.IActionInitiator;
	import org.ushan.marbles.models.TimeInfo;
	
	public class TimeStepAction extends ActionAbstract
	{
		//----------------------------------------------------------------------
		//	read only
		//----------------------------------------------------------------------
		private var _timeInfo			:TimeInfo;
		public function get timeInfo()	:TimeInfo { return _timeInfo };
		
		//----------------------------------------------------------------------
		//
		//	constructor
		//
		//----------------------------------------------------------------------
		
		public function TimeStepAction(initiator	:IActionInitiator, 
									   timeInfo		:TimeInfo)
		{
			super(initiator, TimeStepAction);
			_timeInfo = timeInfo;
		}
	}
}