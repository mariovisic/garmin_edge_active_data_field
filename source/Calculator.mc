using Toybox.Math;

module Calculator {
  var mode = :flat;

  var historicalValues = {
    :heartRate => new [1],
    :averageHeartRate => new [1],
    :power => new [60],
    :power3s => new [1],
    :power1m => new [1],
    :normalizedAveragePower => new [1],
    :maxPower => new [1],
    :cadence => new [1],
    :averageCadence => new [1],
    :distance => new [5],
    :speed => new [3],
    :averageSpeed => new [1],
    :heading => new [1],
    :altitude => new [5],
    :totalAscent => new [1],
    :elevationGrade => new [3]
  };

  var count = 0;
  var normalizedPowerTotal = 0;

  function logInfo(info) {

    logValue(:heartRate, info.currentHeartRate, 1, null);
    logValue(:averageHeartRate, info.averageHeartRate, 1, null);
    logValue(:power, info.currentPower, 60, null);
    logValue(:power3s, powerAverage(3), 1, null);
    logValue(:power1m, powerAverage(60), 1, null);
    logValue(:normalizedAveragePower, normalizedAveragePower(), 1, null);
    logValue(:maxPower, info.maxPower, 1, null);
    logValue(:cadence, info.currentCadence, 1, null);
    logValue(:averageCadence, info.averageCadence, 1, null);
    logValue(:distance, info.elapsedDistance, 5, 0.001);
    logValue(:speed, info.currentSpeed, 3, 3.6);
    logValue(:averageSpeed, info.averageSpeed, 1, 3.6);
    logValue(:heading, radiansToHeading(info.currentHeading), 1, null);
    logValue(:altitude, info.altitude, 5, null);
    logValue(:totalAscent, info.totalAscent, 1, null);
    
    if(mode != :stopped) {
      logValue(:elevationGrade, elevationGrade(), 3, null);
    }

    count += 1;
  }

  function updateMode() {
    var lastThreeSpeeds = historicalValues.get(:speed).slice(-3, null);
    var lastThreeGradients = historicalValues.get(:elevationGrade).slice(-3, null);

    if(lastThreeSpeeds[0] == null) { lastThreeSpeeds[0] = 0; }
    if(lastThreeSpeeds[1] == null) { lastThreeSpeeds[1] = 0; }
    if(lastThreeSpeeds[2] == null) { lastThreeSpeeds[2] = 0; }

    if(lastThreeGradients[0] == null) { lastThreeGradients[0] = 0; }
    if(lastThreeGradients[1] == null) { lastThreeGradients[1] = 0; }
    if(lastThreeGradients[2] == null) { lastThreeGradients[2] = 0; }

    if(lastThreeSpeeds[0] == 0
      && lastThreeSpeeds[1] == 0
      && lastThreeSpeeds[2] == 0
    ) {
      mode = :stopped;
    } else if(
      lastThreeGradients[0] >= 3
      && lastThreeGradients[1] >= 3
      && lastThreeGradients[2] >= 3
      // Only show climbing mode when slower than 20km/h
      && lastThreeSpeeds[0] < 20
    ) {
      mode = :climbing;
    } else if(
      lastThreeGradients[0] <= -3
      && lastThreeGradients[1] <= -3
      && lastThreeGradients[2] <= -3
      // Only show descending mode when at 25km/h
      && lastThreeSpeeds[0] >= 25
    ) {
      mode = :descending;
    } else {
      mode = :flat;
    }
  }

  function logValue(name, value, numValuesToKeep, multiplier) {
    if (value != null) {
      if(multiplier == null) {
        historicalValues.get(name).add(value);
      } else {
        historicalValues.get(name).add(value * multiplier);
      }

      historicalValues.put(name, historicalValues.get(name).slice(-numValuesToKeep, null));
    }
  }

  function getRawValue(name) {
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

  function hasField(name) {
    return(getRawValue(name) != null);
  }

  function radiansToHeading(radians) {
    if(radians == null) {
      return "---";
    }
    else {
      var degrees = Math.toDegrees(radians);
      if(degrees < -157.5) {
        return "S";
      } else if(degrees < -112.5) {
        return "SW";
      } else if(degrees < -67.5) {
        return "W";
      } else if(degrees < -22.5) {
        return "NW";
      } else if(degrees < 22.5) {
        return "N";
      } else if(degrees < 67.5) {
        return "NE";
      } else if(degrees < 112.5) {
        return "E";
      } else if(degrees < 157.5) {
        return "SE";
      } else {
        return "S";
      }
    }
  }

  function elevationGrade() {
    if(historicalValues.get(:distance)[0] != null
      && historicalValues.get(:distance)[4] != null
      && historicalValues.get(:altitude)[0] != null
      && historicalValues.get(:altitude)[4] != null
    ) {
      var distance = (historicalValues.get(:distance)[4] - historicalValues.get(:distance)[0]) * 1000;
      // 7 metres travelled in 5 seconds is around 5km/h, so only calculate grade if we're faster than that :)
      if(distance > 7) {
        var elevationChange = historicalValues.get(:altitude)[4] - historicalValues.get(:altitude)[0];
        return (elevationChange / distance.toFloat() * 100);
      }
    }
    return null;
  }

  function powerAverage(num) {
    var powers = historicalValues.get(:power).slice(-num, null);
    var total = 0;
    for(var i = 0; i < powers.size(); i++) {
      if(powers[i] == null) {
        return null;
      } else {
        total += powers[i];
      }
    }

    return total / num.toFloat();
  }

  function normalizedAveragePower() {
    var averagePower = powerAverage(30);
    var iterations = (count / 30);

    if(count % 30 == 0 && averagePower != null) {
      normalizedPowerTotal += Math.pow(averagePower , 4);
    }

    if(iterations == 0 || normalizedPowerTotal == 0) {
      return null;
    }

    return Math.pow((normalizedPowerTotal / iterations.toFloat()), 0.25);
  }
}
