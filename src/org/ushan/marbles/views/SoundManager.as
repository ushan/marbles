package org.ushan.marbles.views
{
	import flash.events.EventDispatcher;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	
	import org.ushan.core.progresses.LoadSoundTask;
	import org.ushan.core.progresses.LoadTaskManagerBranch;
	import org.ushan.marbles.controlers.Controller;
	import org.ushan.marbles.events.ControllerEvent;
	import org.ushan.marbles.events.GamePlayEvent;
	import org.ushan.marbles.models.Model;
	import org.ushan.marbles.models.configs.ESounds;
	
	public class SoundManager extends EventDispatcher
	{
		//----------------------------------------------------------------------
		//	private fields
		//----------------------------------------------------------------------
		private var model			:Model;
		private var controller		:Controller;
		//private var view			:View;
		private var branch			:LoadTaskManagerBranch;
		
		private var startSound		:Sound;
		private var dragSound		:Sound;
		private var dropSound		:Sound;
		private var successSound	:Sound;
		private var mistakeSound	:Sound;
		private var winSound		:Sound;

		private var startChanel		:SoundChannel;
		private var dragChanel		:SoundChannel;
		private var dropChanel		:SoundChannel;
		private var successChanel	:SoundChannel;
		private var mistakeChanel	:SoundChannel;
		private var winChanel		:SoundChannel;
		
		//----------------------------------------------------------------------
		//
		//	constructor
		//
		//----------------------------------------------------------------------
		
		public function SoundManager()
		{
			super();
			init();
		}
		
		//----------------------------------------------------------------------
		//
		//	private methods
		//
		//----------------------------------------------------------------------
		
		private function init():void
		{
			initSingletons();
			initListeners();
		}
		
		private function initSingletons():void
		{
			model = Model.instance;
			controller = Controller.instance;
		} 
		
		private function initListeners():void
		{
			controller.addEventListener(ControllerEvent.SOUNDS_LOADED,
				controller_soundsLoadedHandler, false, 0, true);
			initSoundListeners();

		}
		private function initSoundListeners():void
		{
			model.addEventListener(GamePlayEvent.DRAGED_ELEMENT, 
				model_dragedElementHandler, false, 0, true);
			model.addEventListener(GamePlayEvent.DROPED_ELEMENT, 
				model_dropedElementHandler, false, 0, true);
			model.addEventListener(GamePlayEvent.START_GAME, 
				model_startGameHandler, false, 0, true);
			model.addEventListener(GamePlayEvent.SUCCESS_DROP, 
				model_successDropHandler, false, 0, true);
			model.addEventListener(GamePlayEvent.MISTAKE, 
				model_mistakeHandler, false, 0, true);
			model.addEventListener(GamePlayEvent.WIN, 
				model_winHandler, false, 0, true);

		}
		
		private function initSounds( branch:LoadTaskManagerBranch):void
		{
			
			this.branch  = branch;	
			var task:LoadSoundTask 
			task = branch.getTaskById(ESounds.START) as LoadSoundTask;
			startSound = task.sound;
			task = branch.getTaskById(ESounds.DRAG) as LoadSoundTask;
			dragSound = task.sound;
			task = branch.getTaskById(ESounds.DROP) as LoadSoundTask;
			dropSound = task.sound;
			task = branch.getTaskById(ESounds.SUCCESS) as LoadSoundTask;
			successSound = task.sound;
			task = branch.getTaskById(ESounds.MISTAKE) as LoadSoundTask;
			mistakeSound = task.sound;
			task = branch.getTaskById(ESounds.WIN) as LoadSoundTask;
			winSound = task.sound;
		}
		
		//----------------------------------------------------------------------
		//
		//	event handlers
		//
		//----------------------------------------------------------------------
		
		private function model_dragedElementHandler(e:GamePlayEvent):void
		{
			dragChanel = dragSound.play(0);
		}
		
		private function model_dropedElementHandler(e:GamePlayEvent):void
		{
			dropChanel = dropSound.play(0);
		}
		
		private function controller_soundsLoadedHandler(e:ControllerEvent):void
		{
			branch = e.progressTask as LoadTaskManagerBranch;
			initSounds(branch);
		}
		
		private function model_successDropHandler(e:GamePlayEvent):void
		{
			successChanel = successSound.play(0);
		}
		
		private function model_mistakeHandler(e:GamePlayEvent):void
		{
			mistakeChanel = mistakeSound.play(0);
		}
		
		private function model_startGameHandler(e:GamePlayEvent):void
		{
			startChanel = startSound.play(0);
		}
		
		private function model_winHandler(e:GamePlayEvent):void
		{
			winChanel = winSound.play(0);
		}
		
	}
}