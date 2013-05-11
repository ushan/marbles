package
{
	import flash.display.GradientType;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	import flash.ui.ContextMenu;
	import flash.ui.ContextMenuItem;
	
	import org.ushan.core.mvc.interfaces.IMainClass;
	import org.ushan.marbles.controlers.Controller;
	import org.ushan.marbles.models.Model;
	import org.ushan.marbles.views.BackGround;
	import org.ushan.marbles.views.BasketBack;
	import org.ushan.marbles.views.BasketOver;
	import org.ushan.marbles.views.Hand;
	import org.ushan.marbles.views.View;
	import org.ushan.marbles.views.WinAnimation;
	import org.ushan.marbles.views.balls.BallDisplayInfo;

	
	[SWF(width="900", height="720", frameRate="31", backgroundColor="#eeeeee")]
	public class Marbles extends Sprite implements IMainClass
	{
		//----------------------------------------------------------------------
		//	embeded
		//----------------------------------------------------------------------
		[Embed("assets/ui.swf", mimeType="application/octet-stream")]
		private var ViewMediaData:Class;
		
		//----------------------------------------------------------------------
		//	private fields
		//----------------------------------------------------------------------
		private var view		:View;
		private var model		:Model;
		private var controller	:Controller;
		
		private var holder			:Loader;
		private var loaderContext	:LoaderContext;
		
		public function Marbles()
		{
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
			initFlashUI();
			initContextMenu();
			initSeparateClasses();
		}
		private function initSingletons():void
		{
			model = new Model(); 
			controller = Controller.instance;
			controller.init(this, model);
		}
		
		private function initView():void
		{
			view = new View(); 
			addChild(view);
			
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
		}
		
		
		private function initSeparateClasses():void
		{			
			var hand:Hand;
			var winAnimation:WinAnimation;
			var basketBack:BasketBack;
			var basketOver:BasketOver;
			var ballDisplayInfo:BallDisplayInfo;
			var backGround:BackGround;
		}
		
		private function initFlashUI():void
		{			 
			holder =  new Loader();
			holder.contentLoaderInfo.addEventListener(Event.COMPLETE, holder_completeHandler);
			loaderContext = new LoaderContext(false, ApplicationDomain.currentDomain);
			holder.loadBytes( new ViewMediaData(), loaderContext);
		}
		
		private function initContextMenu():void
		{
			var puzzleContextMenu:ContextMenu = new ContextMenu();
			var item:ContextMenuItem = new ContextMenuItem("Marbles v.1.8.0");
			puzzleContextMenu.customItems.push(item);
			contextMenu = puzzleContextMenu;
		}
		
		//----------------------------------------------------------------------
		//
		//	event handlers
		//
		//----------------------------------------------------------------------
		
		private function holder_completeHandler(e:Event):void
		{
			initView();
		}
	}
}