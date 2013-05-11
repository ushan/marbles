package org.ushan.marbles.actions
{
	import flash.geom.Point;
	
	import org.ushan.core.mvc.actions.ActionAbstract;
	import org.ushan.core.mvc.interfaces.IActionInitiator;
	
	public class DropCurrentAction extends ActionAbstract
	{
		//----------------------------------------------------------------------
		//	read only
		//----------------------------------------------------------------------
		private var _point				:Point;
		public function get point()		:Point { return _point };
		
		//----------------------------------------------------------------------
		//
		//	constructor
		//
		//----------------------------------------------------------------------
		
		public function DropCurrentAction(initiator:IActionInitiator, point:Point)
		{
			super(initiator, DropCurrentAction);
			_point = point;
		}
		
		
	}
}