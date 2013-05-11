package org.ushan.marbles.actions
{
	import org.ushan.core.mvc.actions.ActionAbstract;
	import org.ushan.core.mvc.interfaces.IActionInitiator;
	
	public class SaveToEnvironmentAction extends ActionAbstract
	{
		//----------------------------------------------------------------------
		//	read only
		//----------------------------------------------------------------------
		public function get paramsString()	:String { return _paramsString };
		private var _paramsString			:String;
		
		//----------------------------------------------------------------------
		//
		//	constructor
		//
		//----------------------------------------------------------------------
		
		public function SaveToEnvironmentAction(initiator:IActionInitiator, paramsString:String)
		{
			super(initiator, SaveToEnvironmentAction);
			_paramsString = paramsString;
		}
	}
}