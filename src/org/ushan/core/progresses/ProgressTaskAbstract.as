package org.ushan.core.progresses
{
	import flash.events.EventDispatcher;
	
	import org.ushan.core.progresses.events.ProgressEventAbstract;
	
	public class ProgressTaskAbstract extends EventDispatcher implements IProgressable
	{
		//----------------------------------------------------------------------
		//	static fields
		//----------------------------------------------------------------------
		protected static var tasksList	:Vector.<ProgressTaskAbstract> = new Vector.<ProgressTaskAbstract>();
		public static var isUnique		:Boolean;
		
		//----------------------------------------------------------------------
		//	read only
		//----------------------------------------------------------------------
		protected var _percentage			:Number;
		public function get percentage()	:Number	{ return _percentage; }
		
		protected var _title				:String;
		public function get title()			:String	{ return _title; }
		
		protected var _id					:String;
		public function get id()			:String	{ return _id; }
		
		protected var _xmlNode				:XML;
		public function get xmlNode()		:XML	{ return _xmlNode; }
		
		protected var _checkUnique			:Boolean;
		//public function get checkUnique()	:Boolean	{ return _checkUnique; }
		
		protected var _isCloned				:Boolean;
		public function get isCloned	()	:Boolean	{ return _isCloned	; }
		
		
		//----------------------------------------------------------------------
		//	protected fields
		//----------------------------------------------------------------------
		
		//----------------------------------------------------------------------
		//
		//	constructor
		//
		//----------------------------------------------------------------------
		
		public function ProgressTaskAbstract(id:String, 
											 title:String = null, 
											 xmlNode:XML = null, 
											 checkUnique:Boolean = true,
											 percentage:Number = 0)
		{
			super();
			_checkUnique = checkUnique;
			if (!validateID(id)) 
			{
				return;

			}
			//_id = id;
			_title = title ? title : id;
			_xmlNode = xmlNode;
			_percentage = percentage;
			
		}
		
		//----------------------------------------------------------------------
		//
		//	static methods
		//
		//----------------------------------------------------------------------
		public static function getTaskById(id:String, exclusion:ProgressTaskAbstract):ProgressTaskAbstract
		{
			var returnTask:ProgressTaskAbstract;
			for (var i:uint = 0; i<tasksList.length; i++)
			{
				if (tasksList[i].id == id && tasksList[i] != exclusion)
				{
					return tasksList[i];
				}
			}
			return null;
		}
		
		//----------------------------------------------------------------------
		//
		//	public methods
		//
		//----------------------------------------------------------------------
		
		public function run(initiator:ITaskManager):void {}
		
		public function deleteFromLinks(initiator:TaskManagerBranch):void
		{
			var pos:uint = tasksList.indexOf(this);
			tasksList.splice(pos, 1);
		}
		
		override public function toString():String
		{
			return _id;
		}
		//----------------------------------------------------------------------
		//
		//	private methods
		//
		//----------------------------------------------------------------------
		
		private function validateID(id:String):Boolean
		{
			for (var i:uint = 0; i<tasksList.length; i++)
			{
				if (tasksList[i].id == id)
				{
					if (_checkUnique)
					{
						throw new Error("UError. id with name '" + id + "' is already exists");
						return false;
					}
					else
					{
						_isCloned = true;
					}
				}
			}

			_id = id;
			tasksList.push(this);
			return true;
		}
			
		protected function dispatchProgress(value:Number):void
		{
			var event:ProgressEventAbstract = new ProgressEventAbstract(ProgressEventAbstract.PROGRESS, value, this);
			dispatchEvent(event);
		}
		
		protected function dispatchStart():void
		{
			var event:ProgressEventAbstract = new ProgressEventAbstract(ProgressEventAbstract.START, 0, this);
			dispatchEvent(event);
		}
		
		protected function dispatchComplete():void
		{
			var event:ProgressEventAbstract = new ProgressEventAbstract(ProgressEventAbstract.COMPLETE, 1, this);
			dispatchEvent(event);
		}
	}
}