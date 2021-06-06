// TODO: ftp and max_hr should be set by the user!

class ArcField {

  function draw(dc, field) {
    dc.setColor(Colors.get([0x000000, 0xffffff]), -1);

    if(field.get(:name) == :power) {
      drawPower(dc, field);
    } else if(field.get(:name) == :heartRate) {
      drawHeartRate(dc, field);
    } else if(field.get(:name) == :speed) {
      drawSpeed(dc, field);
    }
  }

  hidden function drawPower(dc, field) {
    var ftp = Toybox.Application.getApp().getProperty("ftp");

    var zones = [
      [ 0.0, 0.548, [ 0x777777, 0x999999 ] ], // Active Recovery
      [ 0.55, 0.758, [ 0x8EC6FF ] ], // Endurance
      [ 0.76, 0.908, [ 0x00A746 ] ], // Tempo
      [ 0.91, 1.058, [ 0xc2c219 ] ], // Threshold
      [ 1.06, 1.208, [ 0xFF6111 ] ], // VO2 Max
      [ 1.21, 1.508, [ 0xFF0F17 ] ], // Anaerobic
      [ 1.51, 5, [ 0xBC0722 ] ] // Neuromuscular
    ];

    var power = field.get(:value);

    for(var i = 0; i < zones.size(); i++) {
      var zone = zones[i];

      drawRawBand(
        dc,
        0,
        power,
        ftp * 1.5,
        zone[0] * ftp,
        zone[1] * ftp,
        zone[2]
      );
    }
  }

  hidden function drawHeartRate(dc, field) {
    var maxHR = Toybox.Application.getApp().getProperty("max_hr");
    var zones = [
      [ 0.50, 0.598, [ 0x777777, 0x999999 ] ], // Active Recovery
      [ 0.60, 0.698, [ 0x8EC6FF ] ], // Endurance
      [ 0.70, 0.798, [ 0x00A746 ] ], // Tempo
      [ 0.80, 0.898, [ 0xc2c219 ] ], // Threshold
      [ 0.90, 1.00, [ 0xFF6111 ] ], // VO2 Max
    ];

    var minimumHeartRateShown = (zones[0][0] * maxHR).toFloat();
    var heartRate = field.get(:value);

    for(var i = 0; i < zones.size(); i++) {
      var zone = zones[i];

      drawRawBand(
        dc,
        minimumHeartRateShown,
        heartRate,
        maxHR,
        zone[0] * maxHR,
        zone[1] * maxHR,
        zone[2]
      );
    }
  }

  hidden function drawSpeed(dc, field) {
    var maxSpeed = 60;
    var zones = [
      [0.0, 10.0, [ 0x0084ff ] ],
      [10.0, 20.0, [ 0x297dcc, 0x339cff ] ],
      [20.0, 30.0, [ 0x3d6d99, 0x66b5ff ] ],
      [30.0, 40.0, [ 0x3d5266, 0x99ceff ] ],
      [40.0, 50.0, [ 0x292e33, 0xcce6ff ] ],
      [50.0, 60.0, [ 0x000000, 0xffffff ] ],
    ];

    var speed = field.get(:value);

    for(var i = 0; i < zones.size(); i++) {
      drawRawBand(
        dc,
        0,
        speed,
        maxSpeed,
        zones[i][0],
        zones[i][1],
        zones[i][2]
      );
    }
  }

  hidden function drawRawBand(dc, startValueOffset, currentValue, maximumValue, zoneStart, zoneFinish, colors) {
    if(currentValue > zoneStart) {
      if(currentValue < zoneFinish) {
        zoneFinish = currentValue;
      }

      var arcRadius = null;
      var ArcStartAngle = 235 + ((zoneStart - startValueOffset) / (maximumValue - startValueOffset) * 50);
      var ArcFinishAngle = 235 + ((zoneFinish - startValueOffset) / (maximumValue - startValueOffset) * 50);

      if(ArcFinishAngle > ArcStartAngle + 1) {
        dc.setPenWidth(dc.getWidth() * 0.08);
        dc.setColor(Colors.get(colors), -1);

        dc.setClip(
          0,
          dc.getHeight() * 0.075,
          dc.getWidth(),
          dc.getHeight() * 0.37
        );

        dc.drawArc(
          dc.getWidth() * 0.5,
          -dc.getHeight() * 0.13,
          dc.getWidth() * 0.70,
          0,
          ArcStartAngle,
          ArcFinishAngle
        );

        dc.clearClip();
      }
    }
  }
}
