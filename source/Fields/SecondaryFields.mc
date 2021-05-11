class SecondaryFields {
  const COORDINATES = [
    { :test_x => 4.5,
      :test_y => 2.75,
      :box_x => 1,
      :box_y => 2.5,
    },
    { :test_x => 13.5,
      :test_y => 2.75,
      :box_x => 10,
      :box_y => 2.5,
    },
    { :test_x => 4.5,
      :test_y => 15.25,
      :box_x => 1,
      :box_y => 14.75,
    },
    { :test_x => 13.5,
      :test_y => 15.25,
      :box_x => 10,
      :box_y => 14.75,
    },

  ];

  function draw(dc, fields) {
    dc.setPenWidth(2);

    for( var i = 0; i < fields.size(); i++) {
      dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_TRANSPARENT);

      dc.drawText(
        ((dc.getWidth() / 18) * COORDINATES[i].get(:test_x)) + 2,
        ((dc.getHeight() / 18) * COORDINATES[i].get(:test_y)) + 13,
        Graphics.FONT_LARGE,
        fields[i].get(:formattedValue),
        Graphics.TEXT_JUSTIFY_CENTER
      );

      var valueDimension = dc.getTextDimensions(fields[i].get(:formattedValue), Graphics.FONT_LARGE);
      var unitDimension = dc.getTextDimensions(fields[i].get(:unit), Graphics.FONT_XTINY);

      dc.drawText(
        ((dc.getWidth() / 18) * COORDINATES[i].get(:test_x)) + (valueDimension[0] / 2) + (dc.getWidth() / 100) + 2,
        ((dc.getHeight() / 18) * COORDINATES[i].get(:test_y)) + valueDimension[1] - unitDimension[1] + 8,
        Graphics.FONT_XTINY,
        fields[i].get(:unit),
        Graphics.TEXT_JUSTIFY_LEFT
      );

      dc.drawText(
        ((dc.getWidth() / 18) * COORDINATES[i].get(:test_x)) + 2,
        ((dc.getHeight() / 18) * COORDINATES[i].get(:test_y)) - 4,
        Graphics.FONT_SMALL,
        fields[i].get(:label),
        Graphics.TEXT_JUSTIFY_CENTER
      );

      dc.setColor(fields[i].get(:color), Graphics.COLOR_TRANSPARENT);

      dc.drawRoundedRectangle(
        ((dc.getWidth() / 18) * COORDINATES[i].get(:box_x)) - 4,
        (dc.getHeight() / 18) * COORDINATES[i].get(:box_y),
        (dc.getWidth() / 18) * 8,
        (dc.getHeight() / 18) * 4,
        4
      );
    }
  }
}
