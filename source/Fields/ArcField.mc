class ArcField {
  // FIXME: These should eventually be set by the user!
  const FTP = 306;
  const MAX_HR = 191;

  const POWER_ZONES = [
    { :power => 0.0, :powerMax => 0.548, :color => 0x777777 }, // Active Recovery
    { :power => 0.55, :powerMax => 0.758, :color => 0x8EC6FF }, // Endurance
    { :power => 0.76, :powerMax => 0.908, :color => 0x00A746 }, // Tempo
    { :power => 0.91, :powerMax => 1.058, :color => 0xc2c219 }, // Threshold
    { :power => 1.06, :powerMax => 1.208, :color => 0xFF6111 }, // VO2 Max
    { :power => 1.21, :powerMax => 1.508, :color => 0xFF0F17 }, // Anaerobic
    { :power => 1.51, :powerMax => 5, :color => 0xBC0722 } // Neuromuscular
  ];

  const HEART_RATE_ZONES = [
    { :heartRate => 0.50, :heartRateMax => 0.598, :color => 0x777777 }, // Active Recovery
    { :heartRate => 0.60, :heartRateMax => 0.698, :color => 0x8EC6FF }, // Endurance
    { :heartRate => 0.70, :heartRateMax => 0.798, :color => 0x00A746 }, // Tempo
    { :heartRate => 0.80, :heartRateMax => 0.898, :color => 0xc2c219 }, // Threshold
    { :heartRate => 0.90, :heartRateMax => 1.00, :color => 0xFF6111 }, // VO2 Max
  ];

  function draw(dc, field) {
    dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_TRANSPARENT);

    if(field.get(:name) == :power) {
      drawPower(dc, field);
    } else if(field.get(:name) == :heartRate) {
      drawHeartRate(dc, field);
    } else if(field.get(:name) == :speed) {
      drawSpeed(dc, field);
    }
  }

  hidden function drawPower(dc, field) {
    var powerColor = null;
    var arcRadius = null;
    var currentPower = field.get(:value);

    for(var i = 0; i < POWER_ZONES.size(); i++) {
      if(currentPower > (POWER_ZONES[i].get(:power) * FTP).toNumber() + 1) {
        powerColor = POWER_ZONES[i];

        var maxPowerToDisplay = FTP * 1.5;
        if(currentPower > maxPowerToDisplay) {
          maxPowerToDisplay = currentPower;
        }
        var currentZoneMinimum = powerColor.get(:power) * FTP;
        var currentZoneMaximum = powerColor.get(:powerMax) * FTP;

        var currentPowerOrZoneMax = currentZoneMaximum;
        if(currentPower < currentZoneMaximum) {
          currentPowerOrZoneMax = currentPower;
        }

        drawRawBand(
          dc,
          i,
          currentZoneMinimum.toFloat() / maxPowerToDisplay.toFloat(),
          currentPowerOrZoneMax.toFloat() / maxPowerToDisplay.toFloat(),
          currentPower.toFloat() / FTP.toFloat(),
          powerColor.get(:color)
        );
      }
    }
  }

  hidden function drawHeartRate(dc, field) {
    var zone = null;
    var minimumHeartRateShown = (HEART_RATE_ZONES[0].get(:heartRate) * MAX_HR).toFloat();
    var heartRate = field.get(:value);

    for(var i = 0; i < HEART_RATE_ZONES.size(); i++) {
      if(heartRate > (HEART_RATE_ZONES[i].get(:heartRate) * MAX_HR).toNumber() + 1) {
        zone = HEART_RATE_ZONES[i];

        var currentZoneMinimum = zone.get(:heartRate) * MAX_HR;
        var currentZoneMaximum = zone.get(:heartRateMax) * MAX_HR;

        var heartRateOrZoneMax = currentZoneMaximum;
        if(heartRate < currentZoneMaximum) {
          heartRateOrZoneMax = heartRate;
        }

        drawRawBand(
          dc,
          i,
          (currentZoneMinimum - minimumHeartRateShown).toFloat() / (MAX_HR - minimumHeartRateShown).toFloat(),
          (heartRateOrZoneMax - minimumHeartRateShown).toFloat() / (MAX_HR - minimumHeartRateShown).toFloat(),
          heartRate.toFloat() / MAX_HR.toFloat(),
          zone.get(:color)
        );
      }
    }
  }

  hidden function drawSpeed(dc, field) {
    if(field.get(:value) > 0) {
      drawRawBand(
        dc,
        0,
        0,
        field.get(:value).toFloat() / 60.0,
        1,
        0x0084E3
      );
    }
  }

  hidden function drawRawBand(dc, i, percentageZoneStart, percentageZoneFinish, valuePercent, color) {
    var arcRadius = null;
    var ArcStartAngle = 175 + (percentageZoneStart * 190);
    var ArcFinishAngle = 175 + (percentageZoneFinish * 190);

    if(i > 0 && valuePercent < percentageZoneFinish) {
      dc.setPenWidth(24);
      arcRadius = (dc.getWidth() / 3) - 6;
    } else {
      dc.setPenWidth(14);
      arcRadius = (dc.getWidth() / 3);
    }
    dc.setColor(color, Graphics.COLOR_TRANSPARENT);

    dc.drawArc(
      (dc.getWidth() / 2),
      (dc.getHeight() / 18) * 9,
      arcRadius,
      Graphics.ARC_COUNTER_CLOCKWISE,
      ArcStartAngle,
      ArcFinishAngle
    );
  }
}
