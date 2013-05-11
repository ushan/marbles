package org.ushan.marbles.actions
{
	import org.ushan.core.mvc.actions.AcceptXMLAction;
	import org.ushan.core.mvc.actions.SetCurrentProgressAction;
	import org.ushan.core.mvc.actions.ShowHideHelpAction;

	public class EActions
	{
		public static const  REGISTER_VIEW				:Class = RegisterViewAction;
		public static const  TO_START_GAME				:Class = ToStartGameAction;
		public static const  APPEAR_COMPLETE			:Class = AppearCompleteAction;
		public static const  SET_CURRENT_PROGRESS		:Class = SetCurrentProgressAction;
		public static const  ACCEPT_XML					:Class = AcceptXMLAction;
		public static const  SET_DEBUGER				:Class = SetDebugerAction;
		public static const  STEP						:Class = StepAction;
		public static const  TIME_STEP					:Class = TimeStepAction;
		public static const  SHOW_HIDE_INFOR			:Class = ShowHideInfoAction;
		public static const  SHOW_HIDE_HELP				:Class = ShowHideHelpAction;
		public static const  DRAGED_ELEMENT				:Class = DragedElementAction;
		public static const  DROPED_ELEMENT				:Class = DropedElementAction;
		public static const  HAND_MOVE					:Class = HandMoveAction;
		public static const  SUCCESS_DROP				:Class = SuccessDropAction;
		public static const  FAILED_DROP				:Class = FailedDropAction;
		public static const  DROP_FINISHED				:Class = DropFinishedAction;
		public static const  DROP_CURRENT				:Class = DropCurrentAction;
		public static const  MISTAKE					:Class = MistakeAction;
		public static const  WIN						:Class = WinAction;
		public static const  SAVE_TO_ENVIRONMENT		:Class = SaveToEnvironmentAction;
		
	}
}