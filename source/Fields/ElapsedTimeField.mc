module ElapsedTimeField {
  function draw(dc, elapsedTime) {
    dc.setColor(Colors.get([0x000000, 0xffffff]), -1);

    elapsedTime = elapsedTime / 1000;
    var hours = (elapsedTime / 3600);
    var minutes = (elapsedTime - (hours * 3600)) / 60;
    var seconds = (elapsedTime - (hours * 3600) - (minutes * 60));

    dc.drawText(
      dc.getWidth() * 0.94,
      0,
      2,
      hours.format("%2d") + ":" + minutes.format("%02d") + ":" + seconds.format("%02d"),
      0
    );
  }
}
