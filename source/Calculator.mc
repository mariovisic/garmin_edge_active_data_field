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
    :cadence => new [3],
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

    logValue(:heartRate, info.currentHeartRate, 1);
    logValue(:averageHeartRate, info.averageHeartRate, 1);
    logValue(:power, info.currentPower, 60);
    logValue(:power3s, powerAverage(3), 1);
    logValue(:power1m, powerAverage(60), 1);
    logValue(:normalizedAveragePower, normalizedAveragePower(), 1);
    logValue(:maxPower, info.maxPower, 1);
    logValue(:cadence, info.currentCadence, 3);
    logValue(:averageCadence, info.averageCadence, 1);
    logValue(:distance, info.elapsedDistance, 5);
    logValue(:speed, info.currentSpeed, 3);
    logValue(:averageSpeed, info.averageSpeed, 1);
    logValue(:heading, radiansToHeading(info.currentHeading), 1);
    logValue(:altitude, info.altitude, 5);
    logValue(:totalAscent, info.totalAscent, 1);
    
    if(mode != :stopped) {
      logValue(:elevationGrade, elevationGrade(), 3);
    }

    count += 1;
  }

  function updateMode() {
    var lastThreeSpeeds = historicalValues.get(:speed).slice(-3, null);
    var lastThreeGradients = historicalValues.get(:elevationGrade).slice(-3, null);
    var lastThreePowers = historicalValues.get(:power).slice(-3, null);
    var lastThreeCadences = historicalValues.get(:cadence).slice(-3, null);

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
      && lastThreeSpeeds[0] < (20 / 3.6) // Convert metres/second to km/h
    ) {
      mode = :climbing;
    } else if(
      (lastThreeGradients[0] <= -3
      && lastThreeGradients[1] <= -3
      && lastThreeGradients[2] <= -3
      // Only show descending mode when at 25km/h
      && lastThreeSpeeds[0] >= (25 / 3.6)) || (  // Convert metres/second to km/h
        lastThreePowers[0] == 0
        && lastThreePowers[1] == 0
        && lastThreePowers[2] == 0
        && lastThreeSpeeds[0] >= (35 / 3.6)  // Convert metres/second to km/h
      ) || (
        lastThreeCadences[0] == 0
        && lastThreeCadences[1] == 0
        && lastThreeCadences[2] == 0
        && lastThreeSpeeds[0] >= (35 / 3.6)  // Convert metres/second to km/h
      )
    ) {
      mode = :descending;
    } else {
      mode = :flat;
    }
  }

  function logValue(name, value, numValuesToKeep) {
    if (value != null) {
      historicalValues.get(name).add(value);

      historicalValues.put(name, historicalValues.get(name).slice(-numValuesToKeep, null));
    }
  }

  function getRawValue(name) {
    return historicalValues.get(name).slice(-1, null)[0];
  }

  function getLatestValue(name, multiplier) {
    var value = getRawValue(name);

    return value == null ? 0 : multiplyValue(value, multiplier);
  }

  function multiplyValue(value, multiplier) {
    if(value != null && multiplier != null) {
      return value * multiplier;
    }

    return value;
  }

  function getLatestFormattedValue(name, format, multiplier) {
    if(format == null) {
      return getLatestValue(name, multiplier);
    } else {
      var value = multiplyValue(getRawValue(name), multiplier);

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
