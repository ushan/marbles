package org.ushan.core.mvc.interfaces
{

	public interface IAction
	{
		function get initiator():IActionInitiator;
		function get reflect()		:Class ;
	}
}