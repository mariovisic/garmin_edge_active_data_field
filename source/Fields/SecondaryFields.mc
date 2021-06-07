class SecondaryFields {
  function draw(dc, fields) {
    var coords = [
      [0.25, 0.405],
      [0.75, 0.405],
      [0.25, 0.60],
      [0.75, 0.60],
      [0.25, 0.795],
      [0.75, 0.795]]
    ;

    for( var i = 0; i < fields.size(); i++) {
      var valueDimension = dc.getTextDimensions(fields[i].get(:formattedValue), 6);
      var unitDimension = dc.getTextDimensions(fields[i].get(:unit), 0);
      var labelDimension = dc.getTextDimensions(fields[i].get(:label), 3);

      dc.setColor(Colors.get(fields[i].get(:colors)), -1);

      dc.drawText(
        dc.getWidth() * coords[i][0],
        dc.getHeight() * (coords[i][1] + 0.005),
        3,
        fields[i].get(:label),
        1
      );

      dc.setColor(Colors.get([0x000000, 0xffffff]), -1);

      dc.drawText(
        dc.getWidth() * coords[i][0],
        dc.getHeight() * (coords[i][1] - 0.005) + labelDimension[1],
        6,
        fields[i].get(:formattedValue),
        1
      );

      dc.drawText(
        dc.getWidth() * (coords[i][0] + 0.01) + (valueDimension[0] / 2.0),
        dc.getHeight() * (coords[i][1] - 0.035) + labelDimension[1] + valueDimension[1] - unitDimension[1],
        0,
        fields[i].get(:unit),
        2
      );

    }
  }
}
