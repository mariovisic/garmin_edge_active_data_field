using Toybox.WatchUi as Ui;
using Toybox.Graphics;
using Toybox.Lang;

class ActiveDataFieldView extends Ui.DataField
{
  hidden var batteryPercentage;
  hidden var clockTime;
  hidden var calculator = new ActiveDataFieldCalculator();

  const FTP = 306;

  const POWER_COLORS = [
    { "power" => 0.0, "powerMax" => 0.54, "color" => 0x999999 }, // Active Recovery
    { "power" => 0.55, "powerMax" => 0.75, "color" => 0x8EC6FF }, // Endurance
    { "power" => 0.76, "powerMax" => 0.90, "color" => 0x00A746 }, // Tempo
    { "power" => 0.91, "powerMax" => 1.05, "color" => 0xc2c219 }, // Threshold
    { "power" => 1.06, "powerMax" => 1.20, "color" => 0xFF6111 }, // VO2 Max
    { "power" => 1.21, "powerMax" => 1.50, "color" => 0xFF0F17 }, // Anaerobic
    { "power" => 1.51, "powerMax" => 5, "color" => 0xBC0722 } // Neuromuscular
  ];

  function initialize() {
    DataField.initialize();
  }

  function compute(info) {
    batteryPercentage = System.getSystemStats().battery;
    clockTime = System.getClockTime();
    calculator.logInfo(info);
  }

  function onUpdate(dc) {
    new BatteryPercentageIndicator().draw(dc, batteryPercentage);
    new CurrentTimeIndicator().draw(dc, clockTime);

    dc.setPenWidth(2);

    dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_TRANSPARENT);
    dc.drawText(
      ((dc.getWidth() / 18) * 4.5) + 2,
      ((dc.getHeight() / 6) * 1) + 2,
      Graphics.FONT_LARGE,
      calculator.getLatestFormattedValue("heartRate", "%d"),
      Graphics.TEXT_JUSTIFY_CENTER
    );

    dc.drawText(
      ((dc.getWidth() / 18) * 13.5) + 2,
      ((dc.getHeight() / 6) * 1) + 2,
      Graphics.FONT_LARGE,
      calculator.getLatestFormattedValue("speed", "%d"),
      Graphics.TEXT_JUSTIFY_CENTER
    );

    dc.setColor(Graphics.COLOR_RED, Graphics.COLOR_TRANSPARENT);
    dc.drawRoundedRectangle(
      ((dc.getWidth() / 18) * 1) - 4,
      (dc.getHeight() / 6) * 1,
      (dc.getWidth() / 18) * 8,
      (dc.getHeight() / 6),
      4
    );

    dc.setColor(Graphics.COLOR_BLUE, Graphics.COLOR_TRANSPARENT);
    dc.drawRoundedRectangle(
      ((dc.getWidth() / 18) * 10) - 4,
      (dc.getHeight() / 6) * 1,
      (dc.getWidth() / 18) * 8,
      (dc.getHeight() / 6),
      4
    );

    dc.setPenWidth(12);

    var currentPower = calculator.getLatestValue("power");
    var powerColor = null;
    if(currentPower > 0) {
      
      for(var i = 0; i < POWER_COLORS.size(); i++) {
        if(currentPower >= POWER_COLORS[i].get("power") * FTP) {
          powerColor = POWER_COLORS[i];

          var maxPowerToDisplay = FTP * 1.4;
          if(currentPower > maxPowerToDisplay) {
            maxPowerToDisplay = currentPower;
          }
          var currentZoneMinimum = powerColor.get("power") * FTP;
          var currentZoneMaximum = powerColor.get("powerMax") * FTP;

          var currentPowerOrZoneMax = currentZoneMaximum;
          if(currentPower < currentZoneMaximum) {
            currentPowerOrZoneMax = currentPower;
          }

          var powerArcStartAngle = 175 + (currentZoneMinimum.toFloat() / maxPowerToDisplay.toFloat() * 190);
          var powerArcFinishAngle = 175 + (currentPowerOrZoneMax.toFloat() / maxPowerToDisplay.toFloat() * 190);

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

    dc.drawText(
      (dc.getWidth() / 2),
      (dc.getHeight() / 2),
      Graphics.FONT_LARGE,
      calculator.getLatestFormattedValue("power", "%d"),
      Graphics.TEXT_JUSTIFY_CENTER
    );
  }
}
