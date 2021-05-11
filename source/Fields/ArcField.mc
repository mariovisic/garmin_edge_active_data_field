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
    if(field.get(:name) == :power) {
      drawPower(dc, field);
    } else if(field.get(:name) == :heartRate) {
      drawHeartRate(dc, field);
    }
  }

  function drawPower(dc, field) {
    var powerColor = null;
    var arcRadius = null;
    var currentPower = field.get(:value);

    if(currentPower > 0) {
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

          var powerArcStartAngle = 175 + (currentZoneMinimum.toFloat() / maxPowerToDisplay.toFloat() * 190);
          var powerArcFinishAngle = 175 + (currentPowerOrZoneMax.toFloat() / maxPowerToDisplay.toFloat() * 190);

          if(i > 0 && currentPower < currentZoneMaximum) {
            dc.setPenWidth(24);
            arcRadius = (dc.getWidth() / 3) - 6;
          } else {
            dc.setPenWidth(14);
            arcRadius = (dc.getWidth() / 3);
          }
          dc.setColor(powerColor.get(:color), Graphics.COLOR_TRANSPARENT);

          dc.drawArc(
            (dc.getWidth() / 2),
            (dc.getHeight() / 18) * 9,
            arcRadius,
            Graphics.ARC_COUNTER_CLOCKWISE,
            powerArcStartAngle,
            powerArcFinishAngle
          );
        }
      }
    } else {
      dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_TRANSPARENT);
    }
  }

  function drawHeartRate(dc, field) {
    var zone = null;
    var arcRadius = null;
    var minimumHeartRateShown = (HEART_RATE_ZONES[0].get(:heartRate) * MAX_HR).toFloat();
    var heartRate = field.get(:value);

    dc.setColor(HEART_RATE_ZONES[0].get(:color), Graphics.COLOR_TRANSPARENT);

    for(var i = 0; i < HEART_RATE_ZONES.size(); i++) {
      if(heartRate > (HEART_RATE_ZONES[i].get(:heartRate) * MAX_HR).toNumber() + 1) {
        zone = HEART_RATE_ZONES[i];

        var currentZoneMinimum = zone.get(:heartRate) * MAX_HR;
        var currentZoneMaximum = zone.get(:heartRateMax) * MAX_HR;

        var heartRateOrZoneMax = currentZoneMaximum;
        if(heartRate < currentZoneMaximum) {
          heartRateOrZoneMax = heartRate;
        }

        var ArcStartAngle = 175 + ((currentZoneMinimum - minimumHeartRateShown).toFloat() / (MAX_HR - minimumHeartRateShown).toFloat() * 190);
        var ArcFinishAngle = 175 + ((heartRateOrZoneMax - minimumHeartRateShown).toFloat() / (MAX_HR - minimumHeartRateShown).toFloat() * 190);

        if(i > 0 && heartRate < currentZoneMaximum) {
          dc.setPenWidth(24);
          arcRadius = (dc.getWidth() / 3) - 6;
        } else {
          dc.setPenWidth(14);
          arcRadius = (dc.getWidth() / 3);
        }
        dc.setColor(zone.get(:color), Graphics.COLOR_TRANSPARENT);

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
  }
}
