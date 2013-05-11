package org.ushan.marbles.actions
{
	import org.ushan.core.mvc.actions.ActionAbstract;
	import org.ushan.core.mvc.interfaces.IActionInitiator;
	
	public class StepAction extends ActionAbstract
	{
		public function StepAction(initiator:IActionInitiator)
		{
			super(initiator, StepAction);
		}
	}
}