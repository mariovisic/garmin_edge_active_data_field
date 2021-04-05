class PowerArcField {
  const POWER_COLORS = [
    { "power" => 0.0, "powerMax" => 0.54, "color" => 0x999999 }, // Active Recovery
    { "power" => 0.55, "powerMax" => 0.75, "color" => 0x8EC6FF }, // Endurance
    { "power" => 0.76, "powerMax" => 0.90, "color" => 0x00A746 }, // Tempo
    { "power" => 0.91, "powerMax" => 1.05, "color" => 0xc2c219 }, // Threshold
    { "power" => 1.06, "powerMax" => 1.20, "color" => 0xFF6111 }, // VO2 Max
    { "power" => 1.21, "powerMax" => 1.50, "color" => 0xFF0F17 }, // Anaerobic
    { "power" => 1.51, "powerMax" => 5, "color" => 0xBC0722 } // Neuromuscular
  ];

  function draw(dc, currentPower, ftp) {
    var powerColor = null;
    
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

          dc.setPenWidth(18);
          dc.setColor(powerColor.get("color"), Graphics.COLOR_TRANSPARENT);

          dc.drawArc(
            (dc.getWidth() / 2),
            (dc.getHeight() / 2),
            (dc.getWidth() / 3),
            Graphics.ARC_COUNTER_CLOCKWISE,
            powerArcStartAngle,
            powerArcFinishAngle
          );
        }
      }
    }
  }
}
