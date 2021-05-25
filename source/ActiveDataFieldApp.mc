using Toybox.Application;

class ActiveDataFieldApp extends Toybox.Application.AppBase {
	function initialize() {
		AppBase.initialize();
	}
	
	function getInitialView() {
		return [ new ActiveDataFieldView() ];
	}
}
