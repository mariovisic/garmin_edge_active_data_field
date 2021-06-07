module Grid {
  function draw(dc) {
    dc.setColor(0x888888, -1);
    dc.setPenWidth(1);

    var coords = [0.100, 0.415, 0.61, 0.805];
    for(var i = 0; i < coords.size(); i++) {
      dc.drawLine(
        0,
        (dc.getHeight() * coords[i]),
        dc.getWidth(),
        (dc.getHeight() * coords[i])
      );
    }

    dc.drawLine(
      dc.getWidth() * 0.5,
      (dc.getHeight() * coords[1]),
      dc.getWidth() * 0.5,
      (dc.getHeight())
    );
  }
}
