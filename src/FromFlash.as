package
{
	import flash.display.GradientType;
	import flash.display.Loader;
	import flash.display.SpreadMethod;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Matrix;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	import flash.ui.ContextMenu;
	import flash.ui.ContextMenuItem;
	
	import org.ushan.core.mvc.interfaces.IMainClass;
	import org.ushan.puzzle.controlers.Controller;
	import org.ushan.puzzle.models.Model;
	import org.ushan.puzzle.models.configs.EConfigConstants;
	import org.ushan.puzzle.views.View;
	
	//[SWF(width="900", height="650", frameRate="31", backgroundColor="#cccccc")]
	public class FromFlash extends Sprite implements IMainClass
	{
		//----------------------------------------------------------------------
		//	embeded
		//----------------------------------------------------------------------
		//[Embed("assets/ui.swf", mimeType="application/octet-stream")]
		private var ViewMediaData:Class;
		
		//----------------------------------------------------------------------
		//	private fields
		//----------------------------------------------------------------------
		private var view		:View;
		private var model		:Model;
		private var controller	:Controller;
		
		private var holder			:Loader;
		private var loaderContext	:LoaderContext;
		
		public function FromFlash()
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
			createBack();
			initSingletons();
			//initFlashUI();
			//initContextMenu();
			initView();
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
		}
		

		private function initContextMenu():void
		{
			var puzzleContextMenu:ContextMenu = new ContextMenu();
			var item:ContextMenuItem = new ContextMenuItem("Puzzle v.1.10.0");
			puzzleContextMenu.customItems.push(item);
			contextMenu = puzzleContextMenu;
		}
		
		private function createBack():void
		{
			var back:Sprite = new Sprite();
			//back.alpha = 0.4;
			
			var fillType:String = GradientType.LINEAR;
			var colors:Array = [0x99CC00, 0xFFCC32];
			var alphas:Array = [1, 1];
			var ratios:Array = [0x00, 0xFF];
			
			var w:Number = EConfigConstants.SCENE_WIDTH;
			var h:Number = EConfigConstants.SCENE_HEIGHT;
			var matr:Matrix = new Matrix();
			matr.createGradientBox(w, h, 0.4, 0.8, 0.3);
			var spreadMethod:String = SpreadMethod.PAD;
			back.graphics.beginGradientFill(fillType, colors, alphas, ratios, matr, spreadMethod);
			back.graphics.drawRect(0, 0, w, h);
			back.cacheAsBitmap = true;
			addChild(back);
			
		}

	}
}