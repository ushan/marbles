package org.ushan.core.progresses
{
	import flash.display.BitmapData;
	import flash.display.Sprite;

	public class LoadTaskManagerBranch extends TaskManagerBranch
	{
		public function LoadTaskManagerBranch(name:String)
		{
			super(name);
		}
		
		public function addTasksFromList(urlsList:Vector.<String>, classType:Class):void
		{
			//var loadsBranch:TaskManagerBranch = new TaskManagerBranch("xmlsLoader");
			for (var i:uint = 0; i<urlsList.length; i++)
			{
				var taskURL:String = urlsList[i];
				var ext:String = taskURL.substr((taskURL.length-3), 3);
				
				switch (true)
				{
					case ext = "xml":
						var urlTask:URLLoadTask = new URLLoadTask(taskURL);
						addTask(this, urlTask);
						break;
					case ext = "png" || "jpg" || "gig":
						var task:LoadTask = new LoadTask(taskURL, taskURL);
						addTask(this, task);
						break;
					case ext = "mp3" || "wav":
						var soundTask:LoadSoundTask = new LoadSoundTask(taskURL, taskURL);
						addTask(this, soundTask);
						break;
					default:
						throw new Error("UError. Extention types '" + ext + " arr not supported");
						
				}
				
			}	
		}
		
/*		public function getResultsAsBitmapData():Vector.<BitmapData>
		{
			var results:Vector.<BitmapData> = new Vector.<BitmapData>();
			for (var i:uint = 0; i<_tasks.length; i++)
			{
				
			}
			
		}*/
		

	}
}