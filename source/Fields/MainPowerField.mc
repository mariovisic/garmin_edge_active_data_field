class MainPowerField {
  function draw(dc, powerValueText) {
    dc.drawText(
      (dc.getWidth() / 2),
      (dc.getHeight() / 18) * 8,
      Graphics.FONT_LARGE,
      powerValueText,
      Graphics.TEXT_JUSTIFY_CENTER
    );

    var powerDimension = dc.getTextDimensions(powerValueText, Graphics.FONT_LARGE);
    var powerLabelDimension = dc.getTextDimensions("W", Graphics.FONT_SMALL);

    dc.drawText(
      (dc.getWidth() / 2) + (powerDimension[0] / 2) + (dc.getWidth() / 100),
      ((dc.getHeight() / 18) * 8) + powerDimension[1] - powerLabelDimension[1] - 4,
      Graphics.FONT_SMALL,
      "W",
      Graphics.TEXT_JUSTIFY_LEFT
    );
  }
}
