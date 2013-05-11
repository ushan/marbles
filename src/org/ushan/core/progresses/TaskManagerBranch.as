package org.ushan.core.progresses
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import org.ushan.core.progresses.events.ProgressEventAbstract;
	
	
	public class TaskManagerBranch extends ProgressTaskAbstract implements IProgressable, ITaskManager
	{
		//----------------------------------------------------------------------
		//	read only
		//----------------------------------------------------------------------
		protected var _tasks	:Vector.<ProgressTaskAbstract>;
		public function get tasks():Vector.<ProgressTaskAbstract> {return _tasks;}
		
		//----------------------------------------------------------------------
		//	private and protected fields
		//----------------------------------------------------------------------
		private var currentTask	:int;
		
		//----------------------------------------------------------------------
		//
		//	constructor
		//
		//----------------------------------------------------------------------
		
		public function TaskManagerBranch(title:String, id:String = null)
		{
			var taskID:String = id ? id : title;
			super(taskID);
			_id = id;
			_title = title;
			init();
		}
		//----------------------------------------------------------------------
		//
		//	public methods
		//
		//----------------------------------------------------------------------
		public function addTask (initiator	:ITaskManager, 
								   		task	:ProgressTaskAbstract):void
		{
			_tasks.push(task);
		}
		
		public function addTasksFromVector (initiator	:ITaskManager, 
												vector	:Vector.<ProgressTaskAbstract>):void
		{
			_tasks = _tasks.concat(vector);
			
		}
		
		override public function run (initiator:ITaskManager):void
		{
			var event:ProgressEventAbstract = new ProgressEventAbstract(ProgressEventAbstract.START, 0, this);
			dispatchEvent(event);
			runNextTask();
		}
		
		public function getTaskById (id:String):ProgressTaskAbstract
		{
			for (var i:uint = 0; i<_tasks.length; i++)
			{
				if (_tasks[i].id == id)
				{
					return _tasks[i];
				}
			}
			return null;
		}
		
		//----------------------------------------------------------------------
		//
		//	getters / setters
		//
		//----------------------------------------------------------------------
		

		
		//----------------------------------------------------------------------
		//
		//	private methods
		//
		//----------------------------------------------------------------------
		
		private function init():void
		{
			setStartVars();
		}
		
		private function setStartVars():void
		{
			_tasks = new Vector.<ProgressTaskAbstract>();
			currentTask = -1;
			_percentage = 0;
		}
		
		
		private function setTaskListeners(taskId:uint):void
		{
			var task:ProgressTaskAbstract = tasks[taskId];
			task.addEventListener(ProgressEventAbstract.START, task_startHandler, false, 0, true);		
			task.addEventListener(ProgressEventAbstract.PROGRESS, task_progressHandler, false, 0, true);		
			task.addEventListener(ProgressEventAbstract.COMPLETE, task_completeHandler, false, 0, true);
			task.addEventListener(ProgressEventAbstract.ERROR, task_errorHandler, false, 0, true);	
		}
		
		private function removeTaskListeners(taskId:int):void
		{
			if (taskId >= 0)
			{
				var task:ProgressTaskAbstract = tasks[taskId];
				task.removeEventListener(ProgressEventAbstract.START, task_startHandler);		
				task.removeEventListener(ProgressEventAbstract.PROGRESS, task_progressHandler);		
				task.removeEventListener(ProgressEventAbstract.COMPLETE, task_completeHandler);
				task.removeEventListener(ProgressEventAbstract.ERROR, task_errorHandler);	
			}
		}
		
		private function getNextTask():ProgressTaskAbstract
		{
			if ( currentTask < _tasks.length-1)
			{
				var task:ProgressTaskAbstract = _tasks[currentTask+1];
				currentTask++;
			} else {
				task = null;
			}
			return task;
		}
		
		private function runNextTask():void
		{
			var task:ProgressTaskAbstract = getNextTask();
			removeTaskListeners(currentTask-1);
			setTaskListeners(currentTask);
			var event:ProgressEventAbstract;
			if (task)
			{
				updatePercentage(0);
				task.run(this);
			} else {
				finish();
			}
		}
		
		private function updatePercentage(value:Number):void
		{
			_percentage = (currentTask)/_tasks.length + value/_tasks.length;
			var event:ProgressEventAbstract = new ProgressEventAbstract(ProgressEventAbstract.PROGRESS, _percentage, this);
			dispatchEvent(event);
		}
		
		private function finish():void
		{
			updatePercentage(1);
			var event:ProgressEventAbstract = new ProgressEventAbstract(ProgressEventAbstract.COMPLETE, 1, this);
			event.setResultsList(_tasks);
			dispatchEvent(event);
			removeTaskListeners(currentTask);
			
		}
		
		private function dispatchError(e:ProgressEventAbstract):void
		{
			//trace (event is ProgressEventAbstract);
			var event:ProgressEventAbstract = 
				new ProgressEventAbstract(ProgressEventAbstract.ERROR, 0, this);
			event.setResultError(e.resultError);
			dispatchEvent(event);	
		}
		
		//----------------------------------------------------------------------
		//
		//	event handlers
		//
		//----------------------------------------------------------------------
		
		private function task_startHandler(e:ProgressEventAbstract):void
		{
		}
		
		private function task_progressHandler(e:ProgressEventAbstract):void
		{
			updatePercentage(e.percentage);
		}
		
		private function task_errorHandler(e:ProgressEventAbstract):void
		{
			dispatchError(e);
		}
		
		private function task_completeHandler(e:ProgressEventAbstract):void
		{
			runNextTask();
		}
	}
}