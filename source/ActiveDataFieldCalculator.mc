using Toybox.System;

class ActiveDataFieldCalculator {
  var historicalValues = {
    "speed" => new [5],
    "altitude" => new [5],
  };

	function initialize() {}

  function logInfo(info) {
    logSpeed(info.currentSpeed);

    System.print("speeds: ");
    System.println(historicalValues.get("speed"));
  }

  function logSpeed(currentSpeed) {
    if (currentSpeed != null) {
      historicalValues.get("speed").add(currentSpeed * 3.6);
      historicalValues.put("speed", historicalValues.get("speed").slice(-5, null));
    }
  }
}
