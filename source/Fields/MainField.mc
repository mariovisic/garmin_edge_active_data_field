class MainField {
  function draw(dc, field) {
    var valueDimension = dc.getTextDimensions(field.get(:formattedValue), 7);
    var labelDimension = dc.getTextDimensions(field.get(:unit), 2);

    dc.drawText(
      L.w(50) - (labelDimension[0] / 2.0),
      L.h(46.5),
      7,
      field.get(:formattedValue),
      1
    );

    dc.drawText(
      L.w(51) + (valueDimension[0] / 2.0) - (labelDimension[0] / 2.0),
      L.h(43.75) + valueDimension[1] - labelDimension[1],
      2,
      field.get(:unit),
      2
    );

      dc.drawText(
        L.w(50),
        L.h(38),
        3,
        field.get(:label),
        1
      );
  }
}
