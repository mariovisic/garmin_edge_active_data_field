using Toybox.System;

class ActiveDataFieldCalculator {
  hidden var historicalValues = {
    "altitude" => new [5],
    "heartRate" => new [5],
    "power" => new [5],
    "speed" => new [5],
  };

	function initialize() {}

  function logInfo(info) {
    logValue("altitude", info.altitude, 5);
    logValue("heartRate", info.currentHeartRate, 5);
    logValue("power", info.currentPower, 5);
    logValue("speed", info.currentSpeed, 5);

    // TODO: Remove on release
    System.print("values: ");
    System.println(historicalValues);
  }

  hidden function logValue(name, value, numValuesToKeep) {
    if (value != null) {
      historicalValues.get(name).add(value);
      historicalValues.put(name, historicalValues.get(name).slice(-numValuesToKeep, null));
    }
  }
  function getLatestValue(name) {
    return historicalValues.get(name).slice(-1, null)[0];
  }
}
