using Toybox.Graphics;

class ElapsedTimeField {
  var hours;
  var minutes;
  var seconds;

  function draw(dc, elapsedTime) {
    dc.setColor(Colors.get(:text), Graphics.COLOR_TRANSPARENT);

    elapsedTime = elapsedTime / 1000;
    hours = (elapsedTime / 3600);
    minutes = (elapsedTime - (hours * 3600)) / 60;
    seconds = (elapsedTime - (hours * 3600) - (minutes * 60));

    dc.drawText(
      (dc.getWidth() / 24) * 23,
      (dc.getWidth() / 24),
      Graphics.FONT_SYSTEM_TINY,
      hours.format("%2d") + ":" + minutes.format("%02d") + ":" + seconds.format("%02d"),
      Graphics.TEXT_JUSTIFY_RIGHT
    );
  }
}
