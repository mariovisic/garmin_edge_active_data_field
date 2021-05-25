using Toybox.Graphics;

module ElapsedTimeField {
  function draw(dc, elapsedTime) {
    dc.setColor(Colors.get([Graphics.COLOR_BLACK, Graphics.COLOR_WHITE]), Graphics.COLOR_TRANSPARENT);

    elapsedTime = elapsedTime / 1000;
    var hours = (elapsedTime / 3600);
    var minutes = (elapsedTime - (hours * 3600)) / 60;
    var seconds = (elapsedTime - (hours * 3600) - (minutes * 60));

    dc.drawText(
      (dc.getWidth() / 24) * 23,
      (dc.getWidth() / 24),
      Graphics.FONT_TINY,
      hours.format("%2d") + ":" + minutes.format("%02d") + ":" + seconds.format("%02d"),
      Graphics.TEXT_JUSTIFY_RIGHT
    );
  }
}
