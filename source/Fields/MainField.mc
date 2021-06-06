class MainField {
  function draw(dc, field) {
    var valueDimension = dc.getTextDimensions(field.get(:formattedValue), 7);
    var labelDimension = dc.getTextDimensions(field.get(:unit), 2);

    dc.drawText(
      (dc.getWidth() * 0.5) - (labelDimension[0] / 2.0),
      dc.getHeight() * 0.155,
      7,
      field.get(:formattedValue),
      1
    );

    dc.drawText(
      (dc.getWidth() * 0.51) + (valueDimension[0] / 2.0) - (labelDimension[0] / 2.0),
      (dc.getHeight() * 0.1275) + valueDimension[1] - labelDimension[1],
      2,
      field.get(:unit),
      2
    );

      dc.drawText(
        dc.getWidth() * 0.50,
        dc.getHeight() * 0.08,
        3,
        field.get(:label),
        1
      );
  }
}
