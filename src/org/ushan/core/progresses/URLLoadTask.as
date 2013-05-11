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
	
	public class URLLoadTask extends ProgressTaskAbstract
	{
		//----------------------------------------------------------------------
		//	read only
		//----------------------------------------------------------------------
		
		private var _url					:String;
		public function get url()			:String { return _url; }
		
		private var _resultError			:uint =1;
		public function get resultError()	:uint { return _resultError; }
		
		private var _loader					:URLLoader;
		public function get loader()		:URLLoader { return _loader;}
		
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
		
		public function URLLoadTask(url:String, prefix:String = null)
		{
			var id:String = prefix ? prefix : url;
			super(id);
			_url = url;			
			init();
		}
		
		
		//----------------------------------------------------------------------
		//
		//	public methods
		//
		//----------------------------------------------------------------------
		
		override public function run(initiator:ITaskManager):void
		{
			dispatchStart();
			loader.load(urlRequest);
		}
		
		//----------------------------------------------------------------------
		//
		//	private methods
		//
		//----------------------------------------------------------------------
		
		private function init():void
		{
			initRequest();
			initLoader();
		}
		
		private function initRequest():void
		{
			_urlRequest = new URLRequest(_url);
			_urlRequest.method = URLRequestMethod.GET;	
		}
		
		private function initLoader():void
		{
			_loader = new URLLoader();
			_loader.addEventListener(Event.COMPLETE, loader_completeHandler, false, 0, true);
			_loader.addEventListener(ProgressEvent.PROGRESS, loader_progressHandler, false, 0, true);
			_loader.addEventListener(IOErrorEvent.IO_ERROR, loader_iOErrorHandler, false, 0, true);
		}
		
		private function removeListeners():void
		{
			_loader.removeEventListener(Event.COMPLETE, loader_completeHandler);
			_loader.removeEventListener(ProgressEvent.PROGRESS, loader_progressHandler);
			_loader.removeEventListener(IOErrorEvent.IO_ERROR, loader_iOErrorHandler);
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