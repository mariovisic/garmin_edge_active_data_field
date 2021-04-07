class SecondaryFields {
  const FIELD_DATA = {
    "heartRate" => { "color" => Graphics.COLOR_RED, "label" => "bpm", "format" => "%d" },
    "speed" => { "color" => Graphics.COLOR_BLUE, "label" => "km/h", "format" => "%d" },
    "cadence" => { "color" => Graphics.COLOR_DK_GREEN, "label" => "rpm", "format" => "%d" },
    "distance" => { "color" => Graphics.COLOR_PURPLE, "label" => "km", "format" => "%.1f" },
  };

  const COORDINATES = [
    { "text_x" => 4.5,
      "text_y" => 3,
      "box_x" => 1,
      "box_y" => 3,
    },
    { "text_x" => 13.5,
      "text_y" => 3,
      "box_x" => 10,
      "box_y" => 3,
    },
    { "text_x" => 4.5,
      "text_y" => 15.5,
      "box_x" => 1,
      "box_y" => 15.5,
    },
    { "text_x" => 13.5,
      "text_y" => 15.5,
      "box_x" => 10,
      "box_y" => 15.5,
    },

  ];

  function draw(dc, calculator, fieldNames) {
    dc.setPenWidth(2);

    for( var i = 0; i < fieldNames.size(); i++) {
      dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_TRANSPARENT);

      dc.drawText(
        ((dc.getWidth() / 18) * COORDINATES[i].get("text_x")) + 2,
        ((dc.getHeight() / 18) * COORDINATES[i].get("text_y")) + 2,
        Graphics.FONT_LARGE,
        calculator.getLatestFormattedValue(fieldNames[i], FIELD_DATA[fieldNames[i]].get("format")),
        Graphics.TEXT_JUSTIFY_CENTER
      );

      dc.setColor(FIELD_DATA[fieldNames[i]].get("color"), Graphics.COLOR_TRANSPARENT);

      dc.drawRoundedRectangle(
        ((dc.getWidth() / 18) * COORDINATES[i].get("box_x")) - 4,
        (dc.getHeight() / 18) * COORDINATES[i].get("box_y"),
        (dc.getWidth() / 18) * 8,
        (dc.getHeight() / 18) * 3,
        4
      );
    }
  }
}