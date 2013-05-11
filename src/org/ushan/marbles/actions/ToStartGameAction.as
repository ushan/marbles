package org.ushan.marbles.actions
{
	import org.ushan.core.mvc.actions.ActionAbstract;
	import org.ushan.core.mvc.interfaces.IActionInitiator;

	public class ToStartGameAction extends ActionAbstract
	{
		public function ToStartGameAction(initiator:IActionInitiator)
		{
			super(initiator, ToStartGameAction);
		}
	}
}