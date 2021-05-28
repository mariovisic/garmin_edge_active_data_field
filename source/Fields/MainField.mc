class MainField {
  function draw(dc, field) {
    var powerDimension = dc.getTextDimensions(field.get(:formattedValue), 6);
    var powerLabelDimension = dc.getTextDimensions(field.get(:unit), 2);

    dc.drawText(
      (dc.getWidth() / 2) - (powerLabelDimension[0] / 2),
      (dc.getHeight() / 18) * 9,
      6,
      field.get(:formattedValue),
      1
    );

    dc.drawText(
      (dc.getWidth() / 2) + (powerDimension[0] / 2) - (powerLabelDimension[0] / 2) + (dc.getWidth() / 100),
      ((dc.getHeight() / 18) * 9) + powerDimension[1] - powerLabelDimension[1] - 5,
      2,
      field.get(:unit),
      2
    );

      dc.drawText(
        (dc.getWidth() / 2),
        (dc.getHeight() / 18) * 7.5,
        2,
        field.get(:label),
        1
      );
  }
}
