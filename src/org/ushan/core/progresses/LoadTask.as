package org.ushan.core.progresses
{
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestHeader;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	import flash.utils.ByteArray;
	
	import org.ushan.core.progresses.events.ProgressEventAbstract;
	
	public class LoadTask extends ProgressTaskAbstract
	{
		//----------------------------------------------------------------------
		//	read only
		//----------------------------------------------------------------------
		
		private var _url					:String;
		public function get url()			:String { return _url; }
		
		private var _resultError			:uint =1;
		public function get resultError()	:uint { return _resultError; }
		
		private var _loader					:Loader;
		public function get loader()		:Loader { return _loader;}
		
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

		public function LoadTask(	url			:String, 
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
			loader.unload();
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
				_loader.load(_urlRequest);
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
			_loader = new Loader();
		}
		
		private function initListeners():void
		{
			_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, loader_completeHandler, false, 0, true);
			_loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, loader_progressHandler, false, 0, true);
			_loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, loader_iOErrorHandler, false, 0, true);
		}
		
		private function checkDoublicates():Boolean
		{
			var hasLoaded:LoadTask = getTaskById(_id, this) as LoadTask;
			if (hasLoaded)
			{
				clone(hasLoaded);
				return true;
			}
			return false;
		}
		
		private function clone(hasLoaded:LoadTask):void
		{
			_loader = hasLoaded.loader;
			_urlRequest = hasLoaded.urlRequest;
		}
		
		private function removeListeners():void
		{
			_loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, loader_completeHandler);
			_loader.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS, loader_progressHandler);
			_loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, loader_iOErrorHandler);
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
			var event:ProgressEventAbstract = new ProgressEventAbstract(ProgressEventAbstract.ERROR, 1, this);
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
		
		private function loader_iOErrorHandler(e:Event):void 
		{
			onFailed();
		}
		
		private function loader_completeHandler(e:Event):void 
		{
			finish();
		}
		
		private function loader_progressHandler(e:ProgressEvent):void 
		{
			updatePercentage(e.bytesLoaded/e.bytesTotal);
		}
		
	}
}