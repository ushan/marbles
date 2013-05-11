package org.ushan.marbles.actions
{
	import flash.display.Sprite;
	
	import org.ushan.core.mvc.actions.ActionAbstract;
	import org.ushan.core.mvc.interfaces.IActionInitiator;
	
	public class SetDebugerAction extends ActionAbstract
	{
		//----------------------------------------------------------------------
		//	read only
		//----------------------------------------------------------------------
		private var _debuger			:Sprite;
		public function get debuger()	:Sprite { return _debuger };
		
		//----------------------------------------------------------------------
		//
		//	constructor
		//
		//----------------------------------------------------------------------
		
		public function SetDebugerAction(initiator:IActionInitiator, debuger:Sprite)
		{
			super(initiator, SetDebugerAction);
			_debuger = debuger;
		}
	}
}