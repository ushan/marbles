package org.ushan.core.mvc.actions
{
	import org.ushan.core.mvc.interfaces.IAction;
	import org.ushan.core.mvc.interfaces.IActionInitiator;

	public class ActionAbstract implements IAction
	{
		
		//----------------------------------------------------------------------
		//	getters
		//----------------------------------------------------------------------
		protected var _initiator		:IActionInitiator;
		public function get initiator()	:IActionInitiator { return _initiator };
		
		protected var _reflect			:Class;
		public function get reflect()	:Class { return _reflect };
		
		//----------------------------------------------------------------------
		//
		//	constructor
		//
		//----------------------------------------------------------------------
		
		public function ActionAbstract(initiator:IActionInitiator, reflect:Class)
		{
			_initiator = initiator;
			_reflect = reflect;
		}
	}
}