package org.ushan.marbles.actions
{
	import flash.geom.Point;
	
	import org.ushan.core.mvc.actions.ActionAbstract;
	import org.ushan.core.mvc.interfaces.IActionInitiator;
	
	public class HandMoveAction extends ActionAbstract
	{
		//----------------------------------------------------------------------
		//	read only
		//----------------------------------------------------------------------
		private var _point			:Point;
		public function get point()	:Point { return _point };
		
		//----------------------------------------------------------------------
		//
		//	constructor
		//
		//----------------------------------------------------------------------
		public function HandMoveAction(initiator:IActionInitiator, point:Point)
		{
			super(initiator, HandMoveAction);
			_point = point;
		}
	}
}