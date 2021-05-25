using Toybox.Graphics;

module CurrentTimeAndBatteryField {
  function draw(dc, clockTime, batteryPercentage) {
    dc.setColor(Colors.get([Graphics.COLOR_BLACK, Graphics.COLOR_WHITE]), Graphics.COLOR_TRANSPARENT);

    var amOrPm = clockTime.hour < 12 ? "am" : "pm";
    var hour = clockTime.hour % 12 == 0 ? 12 : clockTime.hour % 12;

    dc.drawText(
      (dc.getWidth() / 24),
      (dc.getWidth() / 24),
      Graphics.FONT_TINY,
      hour.format("%2d") + ":" + clockTime.min.format("%02d") + amOrPm + " / " + batteryPercentage.format("%2d") + "%",
      Graphics.TEXT_JUSTIFY_LEFT
    );
  }
}
