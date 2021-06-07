class MainField {
  function draw(dc, field) {
    var valueDimension = dc.getTextDimensions(field.get(:formattedValue), 8);
    var unitDimension = dc.getTextDimensions(field.get(:unit), 2);

    dc.drawText(
      (dc.getWidth() * 0.5),
      dc.getHeight() * 0.210,
      8,
      field.get(:formattedValue),
      1
    );

    dc.drawText(
      (dc.getWidth() * 0.52) + (valueDimension[0] / 2.0),
      (dc.getHeight() * 0.170) + valueDimension[1] - unitDimension[1],
      2,
      field.get(:unit),
      2
    );

    dc.setColor(Colors.get(field.get(:colors)), -1);

    dc.drawText(
      dc.getWidth() * 0.50,
      dc.getHeight() * 0.120,
      3,
      field.get(:label),
      1
    );
  }
}
