class MainField {
  function draw(dc, valueText, unit) {
    var powerDimension = dc.getTextDimensions(valueText, Graphics.FONT_LARGE);
    var powerLabelDimension = dc.getTextDimensions(unit, Graphics.FONT_SMALL);

    dc.drawText(
      (dc.getWidth() / 2) - (powerLabelDimension[0] / 2),
      (dc.getHeight() / 18) * 9,
      Graphics.FONT_LARGE,
      valueText,
      Graphics.TEXT_JUSTIFY_CENTER
    );

    dc.drawText(
      (dc.getWidth() / 2) + (powerDimension[0] / 2) - (powerLabelDimension[0] / 2) + (dc.getWidth() / 100),
      ((dc.getHeight() / 18) * 9) + powerDimension[1] - powerLabelDimension[1] - 3,
      Graphics.FONT_SMALL,
      unit,
      Graphics.TEXT_JUSTIFY_LEFT
    );
  }
}
