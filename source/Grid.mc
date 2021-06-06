module Grid {
  function draw(dc) {
    dc.setColor(0x888888, -1);
    dc.setPenWidth(1);

    var gridCoords = [0.075, 0.445, 0.63, 0.815];
    for(var i = 0; i < gridCoords.size(); i++) {
      dc.drawLine(
        0,
        (dc.getHeight() * gridCoords[i]),
        dc.getWidth(),
        (dc.getHeight() * gridCoords[i])
      );
    }

    dc.drawLine(
      dc.getWidth() * 0.5,
      (dc.getHeight() * 0.445),
      dc.getWidth() * 0.5,
      (dc.getHeight())
    );
  }
}
