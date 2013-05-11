package org.ushan.core.conveyor
{
	import flash.display.Sprite;
	import flash.events.*;
	

	public class Conveyor 	{
		private static var instance : Conveyor;
		public var mBranche		:ConveyorBranche;
		public var branches		:Array = [];	
		public var i			:int;
		public var eventCont	:Sprite;
		public var isPaused 	:Boolean = false;
		
		//----------------------------------------------------------------------
		//
		//	constructor
		//
		//----------------------------------------------------------------------
		
		public static function getInstance() : Conveyor 
	    {
			if (instance == null )
			{
			instance = new Conveyor();
			instance.init();
			trace("preinit");		
			}
			return instance;
	    }
		public function Conveyor()
		{
			if (instance != null)
	        {
	        	throw new Error("UError. SINGLETON_EXCEPTION");
	        }            
       		instance = this;
		}
		public function init():void
		{
			eventCont = new Sprite();
			eventCont.addEventListener(Event.ENTER_FRAME, enterFrameHandler, false, 0, true);
			mBranche = new ConveyorBranche();
		}
		//TODO WIthout arguments
		public function addTask(obj:Object, func:Function, frames:uint, ...args):void 
		{
			//FromPirrest
			mBranche.addTask.apply(null, [obj, func, frames].concat(args));
			//mBranche.addTask(obj, func, frames, args);
		}
		public function addBranche ():ConveyorBranche {
			return new ConveyorBranche();
		}
		public function removeBranche (branche:ConveyorBranche):void {
			branches.splice(branches.indexOf(branche), 1);
		}
		private function enterFrameHandler(e:Event):void 
		{
			//trace("enterFrameHandler");
			if (!isPaused)
			{
	 			for each (var branche:ConveyorBranche in branches)
				{	
					if (branche.tasks.length > 0 && !branche.isPaused) 
					{
						branche.crrTsk = branche.tasks[0];			
						if (branche.crrTsk.framesLeft == 0 && branche.tasks.length > 0) 
						{
							branche.crrTsk = branche.tasks.shift();
							branche.run(branche.crrTsk);
							//Deleteng afte emtiong. TODO Move deleting to Branche class
							if (branche.tasks.length == 0 && branche.isDeleteAfterFinish)
							{
								removeBranche(branche);
							}
						}
						branche.crrTsk.framesLeft--;
						//trace(crrTsk.frames);
					} 
				}
			} 			
		}
		
	}
}

