class SecondaryFields {
  function draw(dc, fields) {
    var coords = [
      [4.5, 2.875, 2, 4],
      [13.5, 2.875, 11, 4],
      [4.5, 15.125, 2, 16.25],
      [13.5, 15.125, 11, 16.25],
    ];

    dc.setPenWidth(2);

    for( var i = 0; i < fields.size(); i++) {
      dc.setColor(Colors.get([0x000000, 0xffffff]), -1);

      dc.drawText(
        ((dc.getWidth() / 18) * coords[i][0]) + 2,
        ((dc.getHeight() / 18) * coords[i][1]) + 18,
        5,
        fields[i].get(:formattedValue),
        1
      );

      var valueDimension = dc.getTextDimensions(fields[i].get(:formattedValue), 5);
      var unitDimension = dc.getTextDimensions(fields[i].get(:unit), 0);

      dc.drawText(
        ((dc.getWidth() / 18) * coords[i][0]) + (valueDimension[0] / 2) + (dc.getWidth() / 100) + 2,
        ((dc.getHeight() / 18) * coords[i][1]) + valueDimension[1] - unitDimension[1] + 13,
        0,
        fields[i].get(:unit),
        2
      );

      dc.setColor(Colors.get(fields[i].get(:colors)), -1);


      dc.drawText(
        ((dc.getWidth() / 18) * coords[i][0]) + 2,
        ((dc.getHeight() / 18) * coords[i][1]) - 6,
        2,
        fields[i].get(:label),
        1
      );

      dc.setPenWidth(3);

      dc.drawLine(
        ((dc.getWidth() / 18) * coords[i][2]) - 4,
        (dc.getHeight() / 18) * coords[i][3],
        ((dc.getWidth() / 18) * coords[i][2]) - 4 + ((dc.getWidth() / 18) * 6),
        (dc.getHeight() / 18) * coords[i][3]
      );
    }
  }
}
