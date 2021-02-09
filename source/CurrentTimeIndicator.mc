using Toybox.Graphics;

class CurrentTimeIndicator {
  var amOrPm;
  var hour;

  function draw(dc, clockTime) {
    dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_TRANSPARENT);

    amOrPm = clockTime.hour < 12 ? "am" : "pm";
    hour = clockTime.hour % 12 == 0 ? 12 : clockTime.hour % 12;

    dc.drawText(
      (dc.getWidth() / 24) * 23,
      (dc.getWidth() / 24),
      Graphics.FONT_SYSTEM_TINY,
      hour.format("%2d") + ":" + clockTime.min.format("%02d") + amOrPm,
      Graphics.TEXT_JUSTIFY_RIGHT
    );
  }
}
