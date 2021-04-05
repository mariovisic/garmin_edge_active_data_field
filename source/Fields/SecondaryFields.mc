class SecondaryFields {
  function draw(dc, calculator) {
    dc.setPenWidth(2);

    dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_TRANSPARENT);
    dc.drawText(
      ((dc.getWidth() / 18) * 4.5) + 2,
      ((dc.getHeight() / 6) * 1) + 2,
      Graphics.FONT_LARGE,
      calculator.getLatestFormattedValue("heartRate", "%d"), //FIXME: These values should be passed into the function, not extracted from the calculator
      Graphics.TEXT_JUSTIFY_CENTER
    );

    dc.drawText(
      ((dc.getWidth() / 18) * 13.5) + 2,
      ((dc.getHeight() / 6) * 1) + 2,
      Graphics.FONT_LARGE,
      calculator.getLatestFormattedValue("speed", "%d"), //FIXME: These values should be passed into the function, not extracted from the calculator
      Graphics.TEXT_JUSTIFY_CENTER
    );

    dc.setColor(Graphics.COLOR_RED, Graphics.COLOR_TRANSPARENT);
    dc.drawRoundedRectangle(
      ((dc.getWidth() / 18) * 1) - 4,
      (dc.getHeight() / 6) * 1,
      (dc.getWidth() / 18) * 8,
      (dc.getHeight() / 6),
      4
    );

    dc.setColor(Graphics.COLOR_BLUE, Graphics.COLOR_TRANSPARENT);
    dc.drawRoundedRectangle(
      ((dc.getWidth() / 18) * 10) - 4,
      (dc.getHeight() / 6) * 1,
      (dc.getWidth() / 18) * 8,
      (dc.getHeight() / 6),
      4
    );
  }
}
