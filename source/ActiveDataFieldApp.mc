using Toybox.Application;

class ActiveDataFieldApp extends Toybox.Application.AppBase {
	function initialize() {
		AppBase.initialize();
	}

	function onStart(state) {}
	
	function onStop(state) {}
	
	function getInitialView() {
		return [ new ActiveDataFieldView() ];
	}
}
