class ArcField {
  // FIXME: These should eventually be set by the user!
  const FTP = 306;
  const MAX_HR = 191;
  const MAX_SPEED = 60;

  const POWER_ZONES = [
    { :power => 0.0, :powerMax => 0.548, :color => :active_recovery }, // Active Recovery
    { :power => 0.55, :powerMax => 0.758, :color => :endurance }, // Endurance
    { :power => 0.76, :powerMax => 0.908, :color => :tempo }, // Tempo
    { :power => 0.91, :powerMax => 1.058, :color => :threshold }, // Threshold
    { :power => 1.06, :powerMax => 1.208, :color => :vo2_max }, // VO2 Max
    { :power => 1.21, :powerMax => 1.508, :color => :anaerobic }, // Anaerobic
    { :power => 1.51, :powerMax => 5, :color => :neuromuscular } // Neuromuscular
  ];

  const HEART_RATE_ZONES = [
    { :heartRate => 0.50, :heartRateMax => 0.598, :color => :active_recovery }, // Active Recovery
    { :heartRate => 0.60, :heartRateMax => 0.698, :color => :endurance }, // Endurance
    { :heartRate => 0.70, :heartRateMax => 0.798, :color => :tempo }, // Tempo
    { :heartRate => 0.80, :heartRateMax => 0.898, :color => :threshold }, // Threshold
    { :heartRate => 0.90, :heartRateMax => 1.00, :color => :vo2_max }, // VO2 Max
  ];

  const SPEED_ZONES = [
    { :speed => 0.0, :speedMax => 10.0, :color => :speed_10 },
    { :speed => 10.0, :speedMax => 20.0, :color => :speed_20 },
    { :speed => 20.0, :speedMax => 30.0, :color => :speed_30 },
    { :speed => 30.0, :speedMax => 40.0, :color => :speed_40 },
    { :speed => 40.0, :speedMax => 50.0, :color => :speed_50 },
    { :speed => 50.0, :speedMax => 60.0, :color => :speed_60 },
  ];

  function draw(dc, field) {
    dc.setColor(Colors.get(:text), Graphics.COLOR_TRANSPARENT);

    if(field.get(:name) == :power) {
      drawPower(dc, field);
    } else if(field.get(:name) == :heartRate) {
      drawHeartRate(dc, field);
    } else if(field.get(:name) == :speed) {
      drawSpeed(dc, field);
    }
  }

  hidden function drawPower(dc, field) {
    var power = field.get(:value);

    for(var i = 0; i < POWER_ZONES.size(); i++) {
      var zone = POWER_ZONES[i];

      drawRawBand(
        dc,
        0,
        power,
        FTP * 1.5,
        zone.get(:power) * FTP,
        zone.get(:powerMax) * FTP,
        zone.get(:color)
      );
    }
  }

  hidden function drawHeartRate(dc, field) {
    var minimumHeartRateShown = (HEART_RATE_ZONES[0].get(:heartRate) * MAX_HR).toFloat();
    var heartRate = field.get(:value);

    for(var i = 0; i < HEART_RATE_ZONES.size(); i++) {
      var zone = HEART_RATE_ZONES[i];

      drawRawBand(
        dc,
        minimumHeartRateShown,
        heartRate,
        MAX_HR,
        zone.get(:heartRate) * MAX_HR,
        zone.get(:heartRateMax) * MAX_HR,
        zone.get(:color)
      );
    }
  }

  hidden function drawSpeed(dc, field) {
    var speed = field.get(:value);

    for(var i = 0; i < SPEED_ZONES.size(); i++) {
      drawRawBand(
        dc,
        0,
        speed,
        MAX_SPEED,
        SPEED_ZONES[i].get(:speed),
        SPEED_ZONES[i].get(:speedMax),
        SPEED_ZONES[i].get(:color)
      );
    }
  }

  hidden function drawRawBand(dc, startValueOffset, currentValue, maximumValue, zoneStart, zoneFinish, color) {
    if(currentValue > zoneStart) {
      if(currentValue < zoneFinish) {
        zoneFinish = currentValue;
      }

      var arcRadius = null;
      var ArcStartAngle = 175 + ((zoneStart - startValueOffset) / (maximumValue - startValueOffset) * 190);
      var ArcFinishAngle = 175 + ((zoneFinish - startValueOffset) / (maximumValue - startValueOffset) * 190);

      if(ArcFinishAngle > ArcStartAngle + 1) {
        dc.setPenWidth(14);
        dc.setColor(Colors.get(color), Graphics.COLOR_TRANSPARENT);

        dc.drawArc(
          (dc.getWidth() / 2),
          (dc.getHeight() / 18) * 9,
          (dc.getWidth() / 3),
          Graphics.ARC_COUNTER_CLOCKWISE,
          ArcStartAngle,
          ArcFinishAngle
        );
      }
    }
  }
}
