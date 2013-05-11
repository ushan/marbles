package org.ushan.core.progresses
{
	import flash.display.BitmapData;
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.media.Sound;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestHeader;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	import flash.utils.ByteArray;
	
	import org.ushan.core.progresses.events.ProgressEventAbstract;
	
	public class LoadSoundTask extends ProgressTaskAbstract
	{
		//----------------------------------------------------------------------
		//	read only
		//----------------------------------------------------------------------
		
		private var _url					:String;
		public function get url()			:String { return _url; }
		
		private var _resultError			:uint =1;
		public function get resultError()	:uint { return _resultError; }
		
		private var _sound					:Sound;
		public function get sound()			:Sound { return _sound;}
		
		private var _urlRequest				:URLRequest;
		public function get urlRequest()	:URLRequest { return _urlRequest;}
		
		//----------------------------------------------------------------------
		//	private fields
		//----------------------------------------------------------------------
		
		//----------------------------------------------------------------------
		//
		//	constructor
		//
		//----------------------------------------------------------------------
		
		public function LoadSoundTask(	url			:String, 
									id			:String, 
									title		:String = null,
									xmlNode		:XML = null,
									checkUnique	:Boolean = true)
		{
			super(id, title, xmlNode, checkUnique);
			_url = url;			
			init();
		}
		
		
		//----------------------------------------------------------------------
		//
		//	public methods
		//
		//----------------------------------------------------------------------
		
		public function clear(initiator:ITaskManager):void
		{
			removeListeners();
			sound.close();
		}
		
		override public function run(initiator:ITaskManager):void
		{
			dispatchStart();
			if (_isCloned)
			{
				finish();
			}
			else
			{
				_sound.load(_urlRequest);
			}
		}
		
		//----------------------------------------------------------------------
		//
		//	private methods
		//
		//----------------------------------------------------------------------
		
		private function init():void
		{
			if (!checkDoublicates())
			{	
				initRequest();
				initLoader();
			}
			initListeners();
		}
		
		private function initRequest():void
		{
			_urlRequest = new URLRequest(_url);
			_urlRequest.method = URLRequestMethod.GET;	
		}
		
		private function initLoader():void
		{
			_sound = new Sound();
		}
		
		private function initListeners():void
		{
			_sound.addEventListener(Event.COMPLETE, sound_completeHandler, false, 0, true);
			_sound.addEventListener(ProgressEvent.PROGRESS, sound_progressHandler, false, 0, true);
			_sound.addEventListener(IOErrorEvent.IO_ERROR, sound_iOErrorHandler, false, 0, true);
		}
		
		private function checkDoublicates():Boolean
		{
			var hasLoaded:LoadSoundTask = getTaskById(_id, this) as LoadSoundTask;
			if (hasLoaded)
			{
				clone(hasLoaded);
				return true;
			}
			return false;
		}
		
		private function clone(hasLoaded:LoadSoundTask):void
		{
			_sound = hasLoaded.sound;
			_urlRequest = hasLoaded.urlRequest;
		}
		
		private function removeListeners():void
		{
			_sound.removeEventListener(Event.COMPLETE, sound_completeHandler);
			_sound.removeEventListener(ProgressEvent.PROGRESS, sound_progressHandler);
			_sound.removeEventListener(IOErrorEvent.IO_ERROR, sound_iOErrorHandler);
		}
		
		
		private function updatePercentage(value:Number):void
		{
			_percentage = value;
			var event:ProgressEventAbstract = new ProgressEventAbstract (ProgressEventAbstract.PROGRESS, 
				_percentage, this)
			dispatchEvent(event);
		}
		
		private function onFailed():void
		{
			removeListeners();
			dispatchError(EErrors.MEDIA_LOADING);
		}
		
		private function dispatchError(error:uint, percentage:Number = 0):void
		{
			
			var event:ProgressEventAbstract = new ProgressEventAbstract(ProgressEventAbstract.ERROR, percentage, this);
			event.setResultError(error);
			dispatchEvent(event);
		}
		
		private function finish():void
		{
			dispatchComplete();
			removeListeners();
		}
		
		//----------------------------------------------------------------------
		//
		//	event handlers
		//
		//----------------------------------------------------------------------
		
		private function sound_iOErrorHandler(e:Event):void 
		{
			onFailed();
		}
		
		private function sound_completeHandler(e:Event):void 
		{
			finish();
		}
		
		private function sound_progressHandler(e:ProgressEvent):void 
		{
			updatePercentage(e.bytesLoaded/e.bytesTotal);
		}
		
	}
}