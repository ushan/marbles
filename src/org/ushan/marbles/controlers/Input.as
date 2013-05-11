package org.ushan.marbles.controlers
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.utils.getTimer;
	
	import org.ushan.core.mvc.actions.ShowHideHelpAction;
	import org.ushan.core.mvc.interfaces.IActionInitiator;
	import org.ushan.core.mvc.interfaces.IController;
	import org.ushan.marbles.actions.DropCurrentAction;
	import org.ushan.marbles.actions.HandMoveAction;
	import org.ushan.marbles.actions.ShowHideInfoAction;
	import org.ushan.marbles.actions.StepAction;
	import org.ushan.marbles.events.ControllerEvent;
	import org.ushan.marbles.models.Model;
	import org.ushan.marbles.views.View;
	
	public class Input extends EventDispatcher implements IActionInitiator, IController
	{
		//----------------------------------------------------------------------
		//	private fields
		//----------------------------------------------------------------------
		
		private var controller	:Controller;
		private var model		:Model;
		private var view		:View;
		private var ascii		:Array;
		private var clickTime	:uint = getTimer();
		
		public function Input(target:IEventDispatcher=null)
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
			fillAscii();
			controller.addEventListener(ControllerEvent.VIEW_INITED, 
				controller_viewInitedHandler, false, 0, true);
			
		}
		
		private function initSingletons():void
		{
			controller = Controller.instance;
			model = Model.instance;
		}
		
		private function initView():void
		{
			view = View.instance;
		}
		
		private function initListeners():void
		{
			view.stage.doubleClickEnabled = false;
			view.stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler, false, 0, true);
			view.stage.addEventListener(KeyboardEvent.KEY_UP, keyUpHandler, false, 0, true);
			//view.stage.addEventListener(MouseEvent.DOUBLE_CLICK, doubleClickHandler, false, 0, true);
			view.stage.addEventListener(MouseEvent.CLICK, clickHandler, false, 0, true);
			view.stage.addEventListener(MouseEvent.MOUSE_WHEEL, mouseWheelHandler, false, 0, true);
			view.stage.addEventListener(MouseEvent.MOUSE_MOVE, mouseMoveHandler, false, 0, true);
			view.stage.addEventListener(Event.ENTER_FRAME, enterFrameHandler, false, 0, true);
			view.stage.addEventListener(MouseEvent.MOUSE_UP, mouseUpHandler, false, 0, true);
		}
		
		private function fillAscii():void
		{
			ascii = new Array();
			ascii[65] = "A";
			ascii[66] = "B";
			ascii[67] = "C";
			ascii[68] = "D";
			ascii[69] = "E";
			ascii[70] = "F";
			ascii[71] = "G";
			ascii[72] = "H";
			ascii[73] = "I";
			ascii[74] = "J";
			ascii[75] = "K";
			ascii[76] = "L";
			ascii[77] = "M";
			ascii[78] = "N";
			ascii[79] = "O";
			ascii[80] = "P";
			ascii[81] = "Q";
			ascii[82] = "R";
			ascii[83] = "S";
			ascii[84] = "T";
			ascii[85] = "U";
			ascii[86] = "V";
			ascii[87] = "W";
			ascii[88] = "X";
			ascii[89] = "Y";
			ascii[90] = "Z";
			ascii[48] = "0";
			ascii[49] = "1";
			ascii[50] = "2";
			ascii[51] = "3";
			ascii[52] = "4";
			ascii[53] = "5";
			ascii[54] = "6";
			ascii[55] = "7";
			ascii[56] = "8";
			ascii[57] = "9";
			ascii[32] = "Spacebar";
			ascii[17] = "Ctrl";
			ascii[16] = "Shift";
			ascii[192] = "~";
			ascii[38] = "up";
			ascii[40] = "down";
			ascii[37] = "left";
			ascii[39] = "right";
			ascii[96] = "Numpad 0";
			ascii[97] = "Numpad 1";
			ascii[98] = "Numpad 2";
			ascii[99] = "Numpad 3";
			ascii[100] = "Numpad 4";
			ascii[101] = "Numpad 5";
			ascii[102] = "Numpad 6";
			ascii[103] = "Numpad 7";
			ascii[104] = "Numpad 8";
			ascii[105] = "Numpad 9";
			ascii[111] = "Numpad /";
			ascii[106] = "Numpad *";
			ascii[109] = "Numpad -";
			ascii[107] = "Numpad +";
			ascii[110] = "Numpad .";
			ascii[45] = "Insert";
			ascii[46] = "Delete";
			ascii[33] = "Page Up";
			ascii[34] = "Page Down";
			ascii[35] = "End";
			ascii[36] = "Home";
			ascii[112] = "F1";
			ascii[113] = "F2";
			ascii[114] = "F3";
			ascii[115] = "F4";
			ascii[116] = "F5";
			ascii[117] = "F6";
			ascii[118] = "F7";
			ascii[119] = "F8";
			ascii[188] = ",";
			ascii[190] = ".";
			ascii[186] = ";";
			ascii[222] = "'";
			ascii[219] = "[";
			ascii[221] = "]";
			ascii[189] = "-";
			ascii[187] = "+";
			ascii[220] = "\\";
			ascii[191] = "/";
			ascii[9] = "TAB";
			ascii[8] = "Backspace";
			//ascii[27] = "ESC";
		}
		
		private function runKeyDownAction(keyCode:uint, ctrKey:Boolean = false):void
		{
			if (ascii[keyCode] == "I" && ctrKey)
			{
				var showHideInfoAction:ShowHideInfoAction = new ShowHideInfoAction(this, true);
				controller.accepControllerAction(this, showHideInfoAction);
			}
			if (ascii[keyCode] == "H")
			{
				var showHideHelpAction:ShowHideHelpAction = new ShowHideHelpAction(this, true);
				controller.accepControllerAction(this, showHideHelpAction);
			}

		}
		
		private function runKeyUpAction(keyCode:uint):void
		{
			if (ascii[keyCode] == "I")
			{
				var showHideInfoAction:ShowHideInfoAction = new ShowHideInfoAction(this, false);
				controller.accepControllerAction(this, showHideInfoAction);
			}
			if (ascii[keyCode] == "H")
			{
				var showHideHelpAction:ShowHideHelpAction = new ShowHideHelpAction(this, false);
				controller.accepControllerAction(this, showHideHelpAction);
			}


		}
		
		private function onDdoubleClick (e:MouseEvent):void
		{
			
		}
		
		private function runStepAction ():void
		{
			var action:StepAction = new StepAction(this);
			controller.accepControllerAction(this, action);
		}
		
		private function sendDropCurrentAction (point:Point):void
		{
			var action:DropCurrentAction = new DropCurrentAction(this, point);
			controller.accepControllerAction(this, action);
		}
		
		private function sendHandMoveAction (point:Point):void
		{
			var action:HandMoveAction = new HandMoveAction(this, point);
			controller.accepControllerAction(this, action);
		}
		//----------------------------------------------------------------------
		//
		//	event handlers
		//
		//----------------------------------------------------------------------
		
		private function controller_viewInitedHandler (e:ControllerEvent):void
		{
			initView();
			initListeners();
		}
		
		private function enterFrameHandler (e:Event):void
		{
			runStepAction();
		}
		
		private function keyDownHandler (e:KeyboardEvent):void
		{
			runKeyDownAction(e.keyCode, e.shiftKey);
		}
		
		private function keyUpHandler (e:KeyboardEvent):void
		{
			runKeyUpAction(e.keyCode);
		}
		
		private function mouseWheelHandler (e:MouseEvent):void
		{
			
		}
		
		private function mouseMoveHandler (e:MouseEvent):void
		{
			sendHandMoveAction(new Point(e.stageX, e.stageY));
		}
		
		private function mouseUpHandler (e:MouseEvent):void
		{
			sendDropCurrentAction(new Point(e.stageX, e.stageY));
		}
		
		private function clickHandler (e:MouseEvent):void
		{
			var newTime:uint = getTimer();
			if (newTime - clickTime < 300)
			{
				onDdoubleClick(e);
			}
			clickTime = newTime;
			
		}
	}
}