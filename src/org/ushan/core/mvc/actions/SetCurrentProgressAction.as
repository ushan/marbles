package org.ushan.core.mvc.actions
{
	import org.ushan.core.mvc.interfaces.IActionInitiator;
	import org.ushan.core.progresses.IProgressable;
	
	public class SetCurrentProgressAction extends ActionAbstract
	{
		//----------------------------------------------------------------------
		//	getters
		//----------------------------------------------------------------------
		private var _currentProgress			:IProgressable;
		public function get currentProgress()	:IProgressable { return _currentProgress };
		
		//----------------------------------------------------------------------
		//
		//	constructor
		//
		//----------------------------------------------------------------------
		
		public function SetCurrentProgressAction(initiator:IActionInitiator, progress:IProgressable)
		{
			super(initiator, SetCurrentProgressAction);
			_currentProgress = progress;
			
		}
	}
}