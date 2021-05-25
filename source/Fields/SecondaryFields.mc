class SecondaryFields {
  const COORDS = [
    { :text_x => 4.5,
      :text_y => 2.875,
      :line_x => 2,
      :line_y => 4,
    },
    { :text_x => 13.5,
      :text_y => 2.875,
      :line_x => 11,
      :line_y => 4,
    },
    { :text_x => 4.5,
      :text_y => 15.125,
      :line_x => 2,
      :line_y => 16.25,
    },
    { :text_x => 13.5,
      :text_y => 15.125,
      :line_x => 11,
      :line_y => 16.25,
    },

  ];

  function draw(dc, fields) {
    dc.setPenWidth(2);

    for( var i = 0; i < fields.size(); i++) {
      dc.setColor(Colors.get(:text), Graphics.COLOR_TRANSPARENT);

      dc.drawText(
        ((dc.getWidth() / 18) * COORDS[i].get(:text_x)) + 2,
        ((dc.getHeight() / 18) * COORDS[i].get(:text_y)) + 18,
        Graphics.FONT_NUMBER_MILD,
        fields[i].get(:formattedValue),
        Graphics.TEXT_JUSTIFY_CENTER
      );

      var valueDimension = dc.getTextDimensions(fields[i].get(:formattedValue), Graphics.FONT_NUMBER_MILD);
      var unitDimension = dc.getTextDimensions(fields[i].get(:unit), Graphics.FONT_XTINY);

      dc.drawText(
        ((dc.getWidth() / 18) * COORDS[i].get(:text_x)) + (valueDimension[0] / 2) + (dc.getWidth() / 100) + 2,
        ((dc.getHeight() / 18) * COORDS[i].get(:text_y)) + valueDimension[1] - unitDimension[1] + 13,
        Graphics.FONT_XTINY,
        fields[i].get(:unit),
        Graphics.TEXT_JUSTIFY_LEFT
      );

      dc.setColor(Colors.get(fields[i].get(:color)), Graphics.COLOR_TRANSPARENT);


      dc.drawText(
        ((dc.getWidth() / 18) * COORDS[i].get(:text_x)) + 2,
        ((dc.getHeight() / 18) * COORDS[i].get(:text_y)) - 6,
        Graphics.FONT_SMALL,
        fields[i].get(:label),
        Graphics.TEXT_JUSTIFY_CENTER
      );

      dc.setPenWidth(3);

      dc.drawLine(
        ((dc.getWidth() / 18) * COORDS[i].get(:line_x)) - 4,
        (dc.getHeight() / 18) * COORDS[i].get(:line_y),
        ((dc.getWidth() / 18) * COORDS[i].get(:line_x)) - 4 + ((dc.getWidth() / 18) * 6),
        (dc.getHeight() / 18) * COORDS[i].get(:line_y)
      );
    }
  }
}
