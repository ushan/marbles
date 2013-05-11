package org.ushan.marbles.actions
{
	import org.ushan.core.mvc.actions.ActionAbstract;
	import org.ushan.core.mvc.interfaces.IActionInitiator;
	
	public class WinAction extends ActionAbstract
	{
		//----------------------------------------------------------------------
		//
		//	constructor
		//
		//----------------------------------------------------------------------
		
		public function WinAction(initiator:IActionInitiator)
		{
			super(initiator, WinAction);
		}
	}
}