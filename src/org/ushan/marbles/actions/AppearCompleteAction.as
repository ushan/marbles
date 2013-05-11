package org.ushan.marbles.actions
{
	import org.ushan.core.mvc.actions.ActionAbstract;
	import org.ushan.core.mvc.interfaces.IActionInitiator;
	
	public class AppearCompleteAction extends ActionAbstract
	{
		
		//----------------------------------------------------------------------
		//
		//	constructor
		//
		//----------------------------------------------------------------------
		
		public function AppearCompleteAction(initiator:IActionInitiator)
		{
			super(initiator, AppearCompleteAction);
		}
	}
}