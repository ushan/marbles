package org.ushan.core.conveyor
{
	public class ConveyorBranche
	{
		public var tasks				:Array = new Array();
		public var crrTsk				:CTask;
		public var aConv 				:Conveyor;
		public var isPaused 			:Boolean = false;
		public var i 					:int;
		public var isDeleteAfterFinish 	:Boolean;
		
		//----------------------------------------------------------------------
		//
		//	constructor
		//
		//----------------------------------------------------------------------
		
		public function ConveyorBranche(isDeleteAfterFinish:Boolean = false)
		{
			aConv = Conveyor.getInstance();
			aConv.branches.push(this);
			this.isDeleteAfterFinish = isDeleteAfterFinish;
		}
		public function addTask(obj:Object, func:Function, frames:uint, ...args):void 
		{
			var task:CTask = new CTask(obj, func, frames, args);
			tasks.push(task);
		}
		
		public function addTween(obj:Object, func:Function, frames:uint, prop:String, start:Number, end:Number, ease:Function):void 
		{
			//var task:CTask = new CTask(obj, func, frames, args);
			for (i=0; i<frames; i++) {
				//var task:CTask = new CTask(obj, func, frames, args);
			}
		}
		
		public function run(tsk:CTask):void 
		{
			tsk.func.apply(tsk.obj, tsk.args);
		}
		
		
		public function remove():void 
        {
            aConv.removeBranche(this)
        }
		
		//----------------------------------------------------------------------
		//
		//	private methods
		//
		//---------------------------------------------------------------------- 
		
		private function customEasing(t:Number, b:Number, c:Number, d:Number):Number
		{
				var n:Number = Math.cos((t / d) * (Math.PI * 8));
				//var n:Number = 1;
				return b + c * (t / d) * n;
		}

	}
}