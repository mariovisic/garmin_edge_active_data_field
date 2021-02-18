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
    if(info.currentSpeed == null) {
      logValue("speed", info.currentSpeed, 5);
    } else {
      logValue("speed", info.currentSpeed * 3.6, 5);
    }
  }

  hidden function logValue(name, value, numValuesToKeep) {
    if (value != null) {
      historicalValues.get(name).add(value);
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
