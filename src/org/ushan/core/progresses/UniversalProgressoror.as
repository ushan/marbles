// remove this class to view
package org.ushan.core.progresses
{
	
	import flash.display.BitmapData;
	import flash.display.BlendMode;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.filters.BitmapFilter;
	import flash.filters.DropShadowFilter;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	import org.ushan.core.progresses.events.ProgressEventAbstract;
	import org.ushan.utils.StringUtils;
	
	

	public class UniversalProgressoror extends Sprite
	{
		
		//----------------------------------------------------------------------
		//	instances on scene
		//----------------------------------------------------------------------
		public var bar		:Sprite;
		//----------------------------------------------------------------------
		//	private fields
		//----------------------------------------------------------------------
		protected  var target	:IProgressable;
		protected  var caption	:TextField;
		protected var title		:String = "progress";
						
		//----------------------------------------------------------------------
		//
		//	constructor
		//
		//----------------------------------------------------------------------
		
		public function UniversalProgressoror()
		{
			super();
			init();
		}
		
		//----------------------------------------------------------------------
		//
		//	public methods
		//
		//----------------------------------------------------------------------
		
		public function setTarget(target:IProgressable):void
		{
			if (this.target)
			{
				removeListeners();
			}
			this.target = target;
			hide();
			initListeners();
		}
		
		//----------------------------------------------------------------------
		//
		//	private methods
		//
		//----------------------------------------------------------------------
		
		private function init():void
		{
			//initListeners();
			//hide();
			initVisuals();
		}
		
		private function initVisuals():void
		{
			//var bar:ProgressGraph = new ProgressGraph();
			//addChild(bar);
			
			bar.alpha = 0.7;
			
			caption = new TextField();
			caption.y =  Math.round(bar.height/2 - 40 );
			caption.selectable = false;
			caption.autoSize = TextFieldAutoSize.LEFT;
			addChild(caption);
			caption.blendMode = BlendMode.INVERT;
			
			var format:TextFormat = new TextFormat();
			format.align = "left";
			format.size  = 13;
			format.color = 0x000000;
			caption.defaultTextFormat = format;
			caption.text = title;
			var shadow:BitmapFilter = new DropShadowFilter(3, 65, 0xffffff, 0.6, 2, 2, 1.5);
			var tfFilters:Array = [];
			tfFilters.push(shadow);
			caption.filters = tfFilters;
			caption.alpha = 1;
			initExtended();

		}
		
		protected function initExtended():void
		{
			x = 257;
			y = 200;
		}
		
		private function initListeners():void
		{
			addEventListener(Event.REMOVED_FROM_STAGE, removedFromStageHandler);
			
			target.addEventListener(ProgressEventAbstract.START, target_startHandler, false, 0, true); 
			target.addEventListener(ProgressEventAbstract.PROGRESS, target_progressHandler, false, 0, true);
			// next handlers must be runed befor fisheyeAdmin handler
			target.addEventListener(ProgressEventAbstract.COMPLETE, target_completeHandler, false, 1000);
			target.addEventListener(ProgressEventAbstract.ERROR, target_errorHandler, false, 1000);//
			target.addEventListener(ProgressEventAbstract.ABORT, target_abortHandler, false, 1000);
		}
		
		private function removeListeners():void
		{
			
			removeEventListener(Event.REMOVED_FROM_STAGE, removedFromStageHandler);
			removeEventListener(Event.ENTER_FRAME, removedFromStageHandler);
			target.removeEventListener(ProgressEventAbstract.START, target_startHandler); 
			target.removeEventListener(ProgressEventAbstract.PROGRESS, target_progressHandler);
			target.removeEventListener(ProgressEventAbstract.COMPLETE, target_completeHandler);
			target.removeEventListener(ProgressEventAbstract.ERROR, target_errorHandler);
			target.removeEventListener(ProgressEventAbstract.ABORT, target_abortHandler);
			dispatchEvent(new ProgressEventAbstract(ProgressEventAbstract.ABORT, 0, target));
		}
		
		private function updateVisual(percentage:Number):void
		{
			//var percentageString:String = Math.round(percentage*10000)/100;
			var percentageString:String = StringUtils.getFormatedNumber(2, 1, percentage*100);
			caption.text = target.title + "   " + percentageString + "%";
			caption.x = Math.round(-caption.width/2);
			//bar.rotation = percentage*4000;
		}
		
		private function destroy():void
		{
			removeListeners();
		}
		
		private function hide():void
		{
			visible = false;
			removeEventListener(Event.ENTER_FRAME, enterFrameHandler);
			
		}
		
		private function show():void
		{
			visible = true;
			addEventListener(Event.ENTER_FRAME, enterFrameHandler);
		}
		//----------------------------------------------------------------------
		//
		//	event handlers
		//
		//----------------------------------------------------------------------
		
		private function target_startHandler(e:ProgressEventAbstract):void
		{
			updateVisual(e.percentage);
			show();
		}
		
		private function target_progressHandler(e:ProgressEventAbstract):void
		{
			updateVisual(e.percentage);
			
		}
		
		private function target_errorHandler(e:ProgressEventAbstract):void
		{
			updateVisual(e.percentage);
			hide();
		}
		
		private function target_abortHandler(e:ProgressEventAbstract):void
		{
			updateVisual(e.percentage);
			hide();
		}
		
		private function target_completeHandler(e:ProgressEventAbstract):void
		{
			updateVisual(e.percentage);
			hide();
		}
		
		private function removedFromStageHandler(e:Event):void
		{
			destroy();
		}
		
		private function enterFrameHandler(e:Event):void
		{
			bar.rotation +=5;
		}
	}
}