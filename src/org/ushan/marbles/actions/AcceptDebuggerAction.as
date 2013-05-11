package org.ushan.marbles.actions
{
	import flash.display.Sprite;
	
	import org.ushan.core.mvc.actions.ActionAbstract;
	import org.ushan.core.mvc.interfaces.IActionInitiator;
	
	public class AcceptDebuggerAction extends ActionAbstract
	{
		//----------------------------------------------------------------------
		//	read only
		//----------------------------------------------------------------------
		private var _debugger			:Sprite;
		public function get debugger()	:Sprite { return _debugger };
		
		//----------------------------------------------------------------------
		//
		//	constructor
		//
		//----------------------------------------------------------------------
		
		
		
		public function AcceptDebuggerAction(initiator:IActionInitiator, debugger:Sprite)
		{
			super(initiator, AcceptDebuggerAction);
		}
	}
}