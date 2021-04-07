using Toybox.Graphics;

class CurrentTimeAndBatteryField {
  var amOrPm;
  var hour;

  function draw(dc, clockTime, batteryPercentage) {
    dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_TRANSPARENT);

    amOrPm = clockTime.hour < 12 ? "am" : "pm";
    hour = clockTime.hour % 12 == 0 ? 12 : clockTime.hour % 12;

    dc.drawText(
      (dc.getWidth() / 24),
      (dc.getWidth() / 24),
      Graphics.FONT_SYSTEM_TINY,
      hour.format("%2d") + ":" + clockTime.min.format("%02d") + amOrPm + " / " + batteryPercentage.format("%2d") + "%",
      Graphics.TEXT_JUSTIFY_LEFT
    );
  }
}
