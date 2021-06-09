class FieldSelector {
  // Color, Label, Unit, Format
  const FIELD_DATA = {
    :power3s => [[0xAA00FF ], "Power (3s)", "W", "%d"],
    :power1m => [[0xAA00FF ], "Power (1m)", "W", "%d"],
    :normalizedAveragePower => [[0xAA00FF ], "NP", "W", "%d"],
    :maxPower => [[0xAA00FF ], "Max Power", "W", "%d"],
    :heartRate => [[0xFF0000 ], "Heart Rate", "bpm", "%d"],
    :averageHeartRate => [[0xFF0000 ], "Avg HR", "bpm", "%d"],
    :speed => [[0x00AAFF ], "Speed", "km/h", "%d"],
    :averageSpeed => [[0x00AAFF ], "Avg Speed", "km/h", "%.1f"],
    :cadence => [[0x00AA00, 0x00FF00 ], "Cadence", "rpm", "%d"],
    :averageCadence => [[0x00AA00, 0x00FF00 ], "Avg Cadence", "rpm", "%d"],
    :distance => [[0x000000, 0xffffff ], "Distance", "km", "%.1f"],
    :heading => [[0x000000, 0xffffff ], "Heading", "", null],
    :altitude => [[0x000000, 0xffffff ], "Altitude", "m", "%d"],
    :totalAscent => [[0x000000, 0xffffff ], "Total Ascent", "m", "%d"],
    :elevationGrade => [[0x000000, 0xffffff ], "Grade", "%", "%d"]
  };

  const FIELDS_FOR_MODE = {
    :descending => [:speed, :distance],
    :climbing => [:power3s, :power1m, :heartRate, :speed, :distance, :elevationGrade, :cadence, :heading, :altitude, :totalAscent],
    :stopped => [:distance, :normalizedAveragePower, :averageHeartRate, :averageSpeed, :averageCadence, :maxPower, :totalAscent],
    :flat => [:power3s, :power1m, :heartRate, :speed, :distance, :cadence, :heading, :elevationGrade, :altitude, :totalAscent],
  };

  function mainField() {
    var fields = FIELDS_FOR_MODE[Calculator.mode];
    for (var i = 0; i < fields.size() - 1; i++) {
      if(Calculator.hasField(fields[i])) {
        return mapField(fields[i]);
      }
    }
    return mapField(fields[0]);
  }

  function secondaryFields() {
    var fields = FIELDS_FOR_MODE[Calculator.mode];
    var secondaryFields = [];
    for (var i = 0; i < fields.size() - 1; i++) {
      if(Calculator.hasField(fields[i])) {
        secondaryFields.add(fields[i]);
      }
    }

    return mapFields(secondaryFields.slice(1, 7));
  }

  hidden function mapFields(fields) {
    var outputFields = [];
    for (var i = 0; i < fields.size(); i++) {
      outputFields.add(mapField(fields[i]));
    }
    return outputFields;
  }

  hidden function mapField(field) {
    return({
      :name => field,
      :value => Calculator.getLatestValue(field),
      :colors => FIELD_DATA.get(field)[0],
      :label => FIELD_DATA.get(field)[1],
      :unit => FIELD_DATA.get(field)[2],
      :formattedValue => Calculator.getLatestFormattedValue(field, FIELD_DATA.get(field)[3])
    });
  }
}
