using Toybox.System;

class Calculator {
  public var mode;

  // FIXME: Move these to a shared external class
  hidden var historicalValues = {
    :heartRate => new [5],
    :averageHeartRate => new [1],
    :power => new [5],
    :averagePower => new [1],
    :maxPower => new [1],
    :cadence => new [5],
    :averageCadence => new [1],
    :distance => new [5],
    :speed => new [5],
    :averageSpeed => new [1],
    :heading => new [1],
    :altitude => new [5],
    :totalAscent => new [5],
  };

  function initialize() {
    mode = :flat;
  }

  function logInfo(info) {

    logValue(:heartRate, info.currentHeartRate, 5, null);
    logValue(:averageHeartRate, info.averageHeartRate, 1, null);
    logValue(:power, info.currentPower, 5, null);
    logValue(:averagePower, info.averagePower, 1, null);
    logValue(:maxPower, info.maxPower, 1, null);
    logValue(:cadence, info.currentCadence, 5, null);
    logValue(:averageCadence, info.averageCadence, 1, null);
    logValue(:distance, info.elapsedDistance, 5, 0.001);
    logValue(:speed, info.currentSpeed, 5, 3.6);
    logValue(:averageSpeed, info.averageSpeed, 1, 3.6);
    logValue(:heading, radiansToHeading(info.currentHeading), 1, null);
    logValue(:altitude, info.altitude, 5, null);
    logValue(:totalAscent, info.totalAscent, 5, null);
  }

  function updateMode() {
    if(mode == :flat) {
      var lastThreeSpeeds = historicalValues.get(:speed).slice(-3, null);
      var stopped = true;
      for(var i = 0; i < lastThreeSpeeds.size(); i++) {
        if(lastThreeSpeeds[i] != 0) {
          stopped = false;
          break;
        }
      }
      if(stopped) {
        mode = :stopped;
      }
    } else if(mode == :stopped) {
      var lastThreeSpeeds = historicalValues.get(:speed).slice(-3, null);
      var stopped = true;
      for(var i = 0; i < lastThreeSpeeds.size(); i++) {
        if(lastThreeSpeeds[i] != 0) {
          stopped = false;
          break;
        }
      }
      if(!stopped) {
        mode = :flat;
      }
    }
  }

  hidden function logValue(name, value, numValuesToKeep, multiplier) {
    if (value != null) {
      if(multiplier == null) {
        historicalValues.get(name).add(value);
      } else {
        historicalValues.get(name).add(value * multiplier);
      }

      historicalValues.put(name, historicalValues.get(name).slice(-numValuesToKeep, null));
    }
  }

  hidden function getRawValue(name) {
    return historicalValues.get(name).slice(-1, null)[0];
  }

  function getLatestValue(name) {
    var value = getRawValue(name);

    return value == null ? 0 : value;
  }

  function getLatestFormattedValue(name, format) {
    if(format == null) {
      return getLatestValue(name);
    } else {
      var value = getRawValue(name);

      return value == null ? "---" : value.format(format);
    }
  }

  // FIXME: This should keep track of which values have ever had a value set
  // which is not NULL, rather than checking if the current value is NULL;
  function hasField(name) {
    return(getRawValue(name) != null);
  }

  function radiansToHeading(radians) {
    if(radians == null) {
      return "---";
    } else if(Math.toDegrees(radians) < -157.5) {
      return "S";
    } else if(Math.toDegrees(radians) < -112.5) {
      return "SW";
    } else if(Math.toDegrees(radians) < -67.5) {
      return "W";
    } else if(Math.toDegrees(radians) < -22.5) {
      return "NW";
    } else if(Math.toDegrees(radians) < 22.5) {
      return "N";
    } else if(Math.toDegrees(radians) < 67.5) {
      return "NE";
    } else if(Math.toDegrees(radians) < 112.5) {
      return "E";
    } else if(Math.toDegrees(radians) < 157.5) {
      return "SE";
    } else {
      return "S";
    }
  }
}
