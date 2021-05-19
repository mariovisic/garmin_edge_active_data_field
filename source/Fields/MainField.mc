class MainField {
  function draw(dc, field) {
    var powerDimension = dc.getTextDimensions(field.get(:formattedValue), Graphics.FONT_NUMBER_MEDIUM);
    var powerLabelDimension = dc.getTextDimensions(field.get(:unit), Graphics.FONT_SMALL);

    dc.drawText(
      (dc.getWidth() / 2) - (powerLabelDimension[0] / 2),
      (dc.getHeight() / 18) * 9,
      Graphics.FONT_NUMBER_MEDIUM,
      field.get(:formattedValue),
      Graphics.TEXT_JUSTIFY_CENTER
    );

    dc.drawText(
      (dc.getWidth() / 2) + (powerDimension[0] / 2) - (powerLabelDimension[0] / 2) + (dc.getWidth() / 100),
      ((dc.getHeight() / 18) * 9) + powerDimension[1] - powerLabelDimension[1] - 5,
      Graphics.FONT_SMALL,
      field.get(:unit),
      Graphics.TEXT_JUSTIFY_LEFT
    );

      dc.drawText(
        (dc.getWidth() / 2),
        (dc.getHeight() / 18) * 7.5,
        Graphics.FONT_SMALL,
        field.get(:label),
        Graphics.TEXT_JUSTIFY_CENTER
      );
  }
}
