using Toybox.Graphics;

class BatteryPercentageIndicator {
  function draw(dc, batteryPercentage) {
    dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_TRANSPARENT);

    dc.drawText(
      (dc.getWidth() / 24),
      (dc.getWidth() / 24),
      Graphics.FONT_SYSTEM_TINY,
      "Battery: " + batteryPercentage.format("%2d") + "%",
      Graphics.TEXT_JUSTIFY_LEFT
    );
  }
}
