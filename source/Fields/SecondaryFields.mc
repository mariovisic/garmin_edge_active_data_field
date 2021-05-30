class SecondaryFields {
  function draw(dc, fields) {
    var coords = [[25, 15], [75, 15], [25, 76.5], [75, 76.5]];

    dc.setPenWidth(2);

    for( var i = 0; i < fields.size(); i++) {
      var valueDimension = dc.getTextDimensions(fields[i].get(:formattedValue), 6);
      var unitDimension = dc.getTextDimensions(fields[i].get(:unit), 0);
      var labelDimension = dc.getTextDimensions(fields[i].get(:label), 3);

      dc.setColor(Colors.get([0x000000, 0xffffff]), -1);

      dc.drawText(
        L.w(coords[i][0]),
        L.h(coords[i][1] + 1.5) + labelDimension[1],
        6,
        fields[i].get(:formattedValue),
        1
      );

      dc.drawText(
        L.w(coords[i][0] + 1) + (valueDimension[0] / 2.0),
        L.h(coords[i][1] - 1.25) + labelDimension[1] + valueDimension[1] - unitDimension[1],
        0,
        fields[i].get(:unit),
        2
      );

      dc.setColor(Colors.get(fields[i].get(:colors)), -1);


      dc.drawText(
        L.w(coords[i][0]),
        L.h(coords[i][1]),
        3,
        fields[i].get(:label),
        1
      );

      dc.setPenWidth(L.h(1.25));

      dc.drawLine(
        L.w(coords[i][0] - 17.5),
        L.h(coords[i][1] + 0.75) + labelDimension[1],
        L.w(coords[i][0] + 17.5),
        L.h(coords[i][1] + 0.75) + labelDimension[1]
      );
    }
  }
}
