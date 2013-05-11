package org.ushan.marbles.controlers
{
	import flash.events.EventDispatcher;
	
	import org.ushan.core.mvc.actions.AcceptXMLAction;
	import org.ushan.core.mvc.actions.SetCurrentProgressAction;
	import org.ushan.core.mvc.interfaces.IActionInitiator;
	import org.ushan.core.mvc.interfaces.IController;
	import org.ushan.core.progresses.ITaskManager;
	import org.ushan.core.progresses.LoadSoundTask;
	import org.ushan.core.progresses.LoadTask;
	import org.ushan.core.progresses.LoadTaskManagerBranch;
	import org.ushan.core.progresses.ProgressTaskAbstract;
	import org.ushan.core.progresses.TaskManagerBranch;
	import org.ushan.core.progresses.URLLoadTask;
	import org.ushan.core.progresses.events.ProgressEventAbstract;
	import org.ushan.marbles.actions.ToStartGameAction;
	import org.ushan.marbles.events.ControllerEvent;
	import org.ushan.marbles.models.Model;
	import org.ushan.marbles.models.configs.ECaptions;
	import org.ushan.marbles.models.configs.EConfigConstants;
	import org.ushan.marbles.models.configs.ESounds;
	import org.ushan.marbles.views.View;
	
	public class TaskManager extends EventDispatcher  implements ITaskManager,  
		IController, IActionInitiator
	{
		//----------------------------------------------------------------------
		//	private fields
		//----------------------------------------------------------------------
		private var model		:Model;
		private var view		:View;
		private var controller	:Controller;

		protected var mainBranch 		:TaskManagerBranch;		
		
		//----------------------------------------------------------------------
		//	private fields
		//----------------------------------------------------------------------


		
		//----------------------------------------------------------------------
		//
		//	constructor
		//
		//----------------------------------------------------------------------
		
		public function TaskManager()
		{
			super();
			init();
		}
		
		//----------------------------------------------------------------------
		//
		//	getter // setters
		//
		//----------------------------------------------------------------------
/*		public function get progressBar():UniversalProgressoror
		{
			return _progressBar;
		}*/
		
		//----------------------------------------------------------------------
		//
		//	internal methods
		//
		//----------------------------------------------------------------------
		internal function loadXML():void
		{
			var xmlLoaderTask:URLLoadTask = new URLLoadTask(EConfigConstants.XML_URL);
			xmlLoaderTask.run(this);
			setCurrentProgress(xmlLoaderTask);
			xmlLoaderTask.addEventListener(ProgressEventAbstract.COMPLETE, 
				xmlLoaderTask_completeHandler, false, 0, true);
		}
		
		
		
		//----------------------------------------------------------------------
		//
		//	private methods
		//
		//----------------------------------------------------------------------
		
		private function init():void
		{
			initSingletons();
		}
		
		private function initSingletons():void
		{
			controller = Controller.instance;
			model = Model.instance;
			
		}
		
		private function registerXML(xml:XML):void
		{
			var action:AcceptXMLAction = new AcceptXMLAction(this, xml);
			controller.accepControllerAction(this, action);
		}
		
		
		private function loadSounds():void
		{
			
			var suondList:XMLList = model.config.xml.Sounds;
			var soundTaskBranch:LoadTaskManagerBranch = new LoadTaskManagerBranch(ECaptions.SOUNDS_LOADING);
			var task:LoadSoundTask;
			var url	:String;
			var id	:String;
			var soundNodesId:Vector.<String> = new Vector.<String> ();
			soundNodesId.push(ESounds.START);
			soundNodesId.push(ESounds.DRAG);
			soundNodesId.push(ESounds.DROP);
			soundNodesId.push(ESounds.SUCCESS);
			soundNodesId.push(ESounds.MISTAKE);
			soundNodesId.push(ESounds.WIN);
			for (var i:uint = 0; i < soundNodesId.length; i++)
			{
				id = soundNodesId[i];
				url = suondList.child(id)[0].@path[0];
				task = new LoadSoundTask(url, id, ECaptions.SOUNDS_LOADING);
				soundTaskBranch.addTask(this, task);
			}
			soundTaskBranch.addEventListener(ProgressEventAbstract.COMPLETE,
				soundTaskBranch_completeHandler, false, 0, true);
			setCurrentProgress(soundTaskBranch);
			soundTaskBranch.run(this);
			
		}
		
		
		private function setCurrentProgress(progress:ProgressTaskAbstract):void
		{
			var action:SetCurrentProgressAction = new SetCurrentProgressAction(this, progress);
			controller.accepControllerAction(this, action);			
		}
		//private function clearLoadedSets (var
		//----------------------------------------------------------------------
		//
		//	event handlers
		//
		//----------------------------------------------------------------------
		
		private function xmlLoaderTask_completeHandler(e:ProgressEventAbstract):void
		{
			var task:URLLoadTask = e.targ as URLLoadTask;
			task.removeEventListener(ProgressEventAbstract.COMPLETE, 
				xmlLoaderTask_completeHandler);
			var xml:XML = new XML(task.loader.data);
			registerXML(xml);
			
			loadSounds();
		}
		

		
		private function soundTaskBranch_completeHandler(e:ProgressEventAbstract):void
		{
			trace("soundTaskBranch_completeHandler");
			var task:ProgressTaskAbstract = e.targ as ProgressTaskAbstract;
			task.removeEventListener(ProgressEventAbstract.COMPLETE,
				soundTaskBranch_completeHandler);
			
			var event:ControllerEvent = new ControllerEvent(ControllerEvent.SOUNDS_LOADED);
			event.setProgressTask(task);
			
			controller.passEvent(this, event);
			
		}
		
		
	}
}