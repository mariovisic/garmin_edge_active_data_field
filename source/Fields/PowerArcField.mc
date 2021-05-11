class PowerArcField {
  const POWER_COLORS = [
    { "power" => 0.0, "powerMax" => 0.548, "color" => 0x777777 }, // Active Recovery
    { "power" => 0.55, "powerMax" => 0.758, "color" => 0x8EC6FF }, // Endurance
    { "power" => 0.76, "powerMax" => 0.908, "color" => 0x00A746 }, // Tempo
    { "power" => 0.91, "powerMax" => 1.058, "color" => 0xc2c219 }, // Threshold
    { "power" => 1.06, "powerMax" => 1.208, "color" => 0xFF6111 }, // VO2 Max
    { "power" => 1.21, "powerMax" => 1.508, "color" => 0xFF0F17 }, // Anaerobic
    { "power" => 1.51, "powerMax" => 5, "color" => 0xBC0722 } // Neuromuscular
  ];

  function draw(dc, currentPower, ftp) {
    var powerColor = null;
    var arcRadius = null;
    
    if(currentPower > 0) {
      for(var i = 0; i < POWER_COLORS.size(); i++) {
        if(currentPower > (POWER_COLORS[i].get("power") * ftp).toNumber() + 1) {
          powerColor = POWER_COLORS[i];

          var maxPowerToDisplay = ftp * 1.5;
          if(currentPower > maxPowerToDisplay) {
            maxPowerToDisplay = currentPower;
          }
          var currentZoneMinimum = powerColor.get("power") * ftp;
          var currentZoneMaximum = powerColor.get("powerMax") * ftp;

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
          dc.setColor(powerColor.get("color"), Graphics.COLOR_TRANSPARENT);

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
}
