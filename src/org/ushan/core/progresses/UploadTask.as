package org.ushan.core.progresses
{
	import flash.display.BitmapData;
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
	
	import org.ushan.modaprint.control.progresses.events.ProgressEventAbstract;
	import org.ushan.modaprint.ui.graphs.ProgressGraph;
	import org.ushan.modaprint.data.cofigs.EErrors;
	
	
	public class UploadTask extends ProgressTaskAbstract
	{
		//----------------------------------------------------------------------
		//	public fields
		//----------------------------------------------------------------------
		private var _prefix		:String;
		public function get prefix():String { return _prefix; }
		private var _resultError	:uint =1;
		public function get resultError():uint { return _resultError; }
		//----------------------------------------------------------------------
		//	private fields
		//----------------------------------------------------------------------
		private var uploadData		:ByteArray;		
		private var _acceptedData	:URLVariables;		
		private var loader			:URLLoader;
		private var requestString	:String;
		private var urlRequest		:URLRequest;
		
		//----------------------------------------------------------------------
		//
		//	constructor
		//
		//----------------------------------------------------------------------
		
		public function UploadTask(prefix:String, requestString:String, uploadData:ByteArray = null)
		{
			super();
			_prefix = prefix;
			this.uploadData = uploadData;
			this.requestString = requestString;

			init();
		}
		
		//----------------------------------------------------------------------
		//
		//	getters / setters
		//
		//----------------------------------------------------------------------
		
		public function get acceptedData():URLVariables
		{
			return _acceptedData;
		}
		
		//----------------------------------------------------------------------
		//
		//	public methods
		//
		//----------------------------------------------------------------------
		
		override public function run(initiator:TaskManagerBranch):void
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
			urlRequest = new URLRequest(requestString);
			
			urlRequest.data = uploadData;
			urlRequest.method = URLRequestMethod.POST;
			var header:URLRequestHeader = new URLRequestHeader ("Content-type", "application/octet-stream");
			urlRequest.requestHeaders.push(header);		
		}
		
		private function initLoader():void
		{
			loader = new URLLoader();
			loader.addEventListener(Event.COMPLETE, loader_completeHandler, false, 0, true);
			loader.addEventListener(ProgressEvent.PROGRESS, loader_progressHandler, false, 0, true);
			loader.addEventListener(IOErrorEvent.IO_ERROR, loader_iOErrorHandler, false, 0, true);
		}
		
		private function removeListeners():void
		{
			loader.removeEventListener(Event.COMPLETE, loader_completeHandler);
			loader.removeEventListener(ProgressEvent.PROGRESS, loader_progressHandler);
			loader.removeEventListener(IOErrorEvent.IO_ERROR, loader_iOErrorHandler);
		}
		

		private function updatePercentage(value:Number):void
		{
			_percentage = value;
			dispatchEvent(new ProgressEventAbstract(ProgressEventAbstract.PROGRESS, _percentage, this));
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
			_acceptedData = new URLVariables(loader.data);
			if (_acceptedData.hasOwnProperty("errorsReport"))
			{
				if (_acceptedData.errorsReport == String (EErrors.NO_ERROR))// = 0
				{
					dispatchComplete();
				} 
				else
				{
					dispatchError(parseInt(_acceptedData.errorsReport), 1);
				}
			}
			else
			{
				dispatchError(EErrors.UPLOADING, 1);
			}
			
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
			updatePercentage(0);
		}
		
	}
}