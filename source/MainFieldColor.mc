class MainFieldColor {
  function draw(dc, field) {
    if(field.get(:name) == :power) {
      drawPower(dc, field);
    } else if(field.get(:name) == :heartRate) {
      drawHeartRateColor(dc, field);
    }
  }

  hidden function drawPower(dc, field) {
    setColors(
      dc,
      field.get(:value) / Toybox.Application.getApp().getProperty("ftp").toFloat(),
      [
        [ 0.00, 0.548, [ 0x888888 ] ], // Active Recovery
        [ 0.55, 0.758, [ 0x8EC6FF ] ], // Endurance
        [ 0.76, 0.908, [ 0x00A746 ] ], // Tempo
        [ 0.91, 1.058, [ 0xc2c219 ] ], // Threshold
        [ 1.06, 1.208, [ 0xFF6111 ] ], // VO2 Max
        [ 1.21, 1.508, [ 0xFF0F17 ] ], // Anaerobic
        [ 1.51, 5.000, [ 0xBC0722 ] ] // Neuromuscular
      ]
    );
    drawRectangle(dc);
  }

  hidden function drawHeartRateColor(dc, field) {
    setColors(
      dc,
      field.get(:value) / Toybox.Application.getApp().getProperty("max_hr").toFloat(),
      [
        [ 0.00, 0.598, [ 0x888888 ] ], // Active Recovery
        [ 0.60, 0.698, [ 0x8EC6FF ] ], // Endurance
        [ 0.70, 0.798, [ 0x00A746 ] ], // Tempo
        [ 0.80, 0.898, [ 0xc2c219 ] ], // Threshold
        [ 0.90, 1.000, [ 0xFF6111 ] ], // VO2 Max
      ]
    );
    drawRectangle(dc);
  }

  hidden function setColors(dc, value, zones) {
    for(var i = 0; i < zones.size(); i++) {
      if(value >= zones[i][0]) {
        dc.setColor(Colors.get(zones[i][2]), -1);
      }
    }
  }

  hidden function drawRectangle(dc) {
    dc.fillRectangle(
      0,
      dc.getHeight() * (0.10),
      dc.getWidth(),
      dc.getHeight() * (0.315)
    );

    dc.setColor(0xffffff, -1);
  }
}
