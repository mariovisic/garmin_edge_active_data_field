class HeartRateArcField {
  const ZONES = [
    { "heartRate" => 0.50, "heartRateMax" => 0.598, "color" => 0x777777 }, // Active Recovery
    { "heartRate" => 0.60, "heartRateMax" => 0.698, "color" => 0x8EC6FF }, // Endurance
    { "heartRate" => 0.70, "heartRateMax" => 0.798, "color" => 0x00A746 }, // Tempo
    { "heartRate" => 0.80, "heartRateMax" => 0.898, "color" => 0xc2c219 }, // Threshold
    { "heartRate" => 0.90, "heartRateMax" => 1.00, "color" => 0xFF6111 }, // VO2 Max
  ];

  function draw(dc, heartRate, maxHeartRate) {
    var zone = null;
    var arcRadius = null;
    var minimumHeartRateShown = (ZONES[0].get("heartRate") * maxHeartRate).toFloat();

    dc.setColor(ZONES[0].get("color"), Graphics.COLOR_TRANSPARENT);

    for(var i = 0; i < ZONES.size(); i++) {
      if(heartRate > (ZONES[i].get("heartRate") * maxHeartRate).toNumber() + 1) {
        zone = ZONES[i];

        var currentZoneMinimum = zone.get("heartRate") * maxHeartRate;
        var currentZoneMaximum = zone.get("heartRateMax") * maxHeartRate;

        var heartRateOrZoneMax = currentZoneMaximum;
        if(heartRate < currentZoneMaximum) {
          heartRateOrZoneMax = heartRate;
        }

        var ArcStartAngle = 175 + ((currentZoneMinimum - minimumHeartRateShown).toFloat() / (maxHeartRate - minimumHeartRateShown).toFloat() * 190);
        var ArcFinishAngle = 175 + ((heartRateOrZoneMax - minimumHeartRateShown).toFloat() / (maxHeartRate - minimumHeartRateShown).toFloat() * 190);

        if(i > 0 && heartRate < currentZoneMaximum) {
          dc.setPenWidth(24);
          arcRadius = (dc.getWidth() / 3) - 6;
        } else {
          dc.setPenWidth(14);
          arcRadius = (dc.getWidth() / 3);
        }
        dc.setColor(zone.get("color"), Graphics.COLOR_TRANSPARENT);

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
