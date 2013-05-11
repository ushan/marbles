package
{
	import flash.display.Sprite;
	
	import org.ushan.core.mvc.interfaces.IMainClass;
	import org.ushan.marbles.controlers.Controller;
	import org.ushan.marbles.models.Model;
	import org.ushan.marbles.views.BasketBack;
	import org.ushan.marbles.views.BasketOver;
	import org.ushan.marbles.views.Hand;
	import org.ushan.marbles.views.View;
	import org.ushan.marbles.views.WinAnimation;
	
	
	public class UIinit extends Sprite implements IMainClass
	{
		
		//----------------------------------------------------------------------
		//	private fields
		//----------------------------------------------------------------------
		private var view		:View;
		private var model		:Model;
		private var controller	:Controller;
		
		//----------------------------------------------------------------------
		//
		//	constructor
		//
		//----------------------------------------------------------------------
		
		public function UIinit()
		{
			//initMVC();
			var hand:Hand;
			var winAnimation:WinAnimation;
			var basketBack:BasketBack;
			var basketOver:BasketOver;
		}
		
		//----------------------------------------------------------------------
		//
		//	public methods
		//
		//----------------------------------------------------------------------
		
		
		//----------------------------------------------------------------------
		//
		//	private methods
		//
		//----------------------------------------------------------------------
		
		private function initMVC():void
		{
			
			model = new Model();
			controller = Controller.instance;
			controller.init(this, model);
			view = new View();
			addChild(view);
			//var fonts:FontsContainer = new FontsContainer();
		}
		
	}
}