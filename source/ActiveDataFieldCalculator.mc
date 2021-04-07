using Toybox.System;

class ActiveDataFieldCalculator {
  hidden var historicalValues = {
    "altitude" => new [5],
    "heartRate" => new [5],
    "power" => new [5],
    "cadence" => new [5],
    "distance" => new [5],
    "speed" => new [5],
  };

	function initialize() {}

  function logInfo(info) {
    logValue("altitude", info.altitude, 5, 1);
    logValue("heartRate", info.currentHeartRate, 5, 1);
    logValue("power", info.currentPower, 5, 1);
    logValue("cadence", info.currentCadence, 5, 0.5);
    logValue("distance", info.elapsedDistance, 5, 0.001);
    logValue("speed", info.currentSpeed, 5, 3.6);
  }

  hidden function logValue(name, value, numValuesToKeep, multiplier) {
    if (value != null) {
      historicalValues.get(name).add(value * multiplier);
      historicalValues.put(name, historicalValues.get(name).slice(-numValuesToKeep, null));
    }
  }
  function getLatestValue(name) {
    var value = historicalValues.get(name).slice(-1, null)[0];

    return value == null ? 0 : value;
  }

  function getLatestFormattedValue(name, format) {
    var value = getLatestValue(name);

    return value == null ? "-" : value.format(format);
  }
}
