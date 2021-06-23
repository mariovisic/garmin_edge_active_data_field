class FieldSelector {
  // Color, Label, Unit, Format
  const FIELD_DATA = {
    :power3s => [[0xAA00FF ], "Power (3s)", "W", "%d", null],
    :power1m => [[0xAA00FF ], "Power (1m)", "W", "%d", null],
    :normalizedAveragePower => [[0xAA00FF ], "NP", "W", "%d", null],
    :maxPower => [[0xAA00FF ], "Max Power", "W", "%d", null],
    :heartRate => [[0xFF0000 ], "Heart Rate", "bpm", "%d", null],
    :averageHeartRate => [[0xFF0000 ], "Avg HR", "bpm", "%d", null],
    :speed => [[0x00AAFF ], "Speed", unit(:speed), "%d", unit_multiplier(:speed)],
    :averageSpeed => [[0x00AAFF ], "Avg Speed", unit(:speed), "%.1f", unit_multiplier(:speed)],
    :cadence => [[0x00AA00, 0x00FF00 ], "Cadence", "rpm", "%d", null],
    :averageCadence => [[0x00AA00, 0x00FF00 ], "Avg Cadence", "rpm", "%d", null],
    :distance => [[0x000000, 0xffffff ], "Distance", unit(:distance), "%.1f", unit_multiplier(:distance)],
    :heading => [[0x000000, 0xffffff ], "Heading", "", null, null],
    :altitude => [[0x000000, 0xffffff ], "Altitude", unit(:elevation), "%d", unit_multiplier(:elevation)],
    :totalAscent => [[0x000000, 0xffffff ], "Total Ascent", unit(:elevation), "%d", unit_multiplier(:elevation)],
    :elevationGrade => [[0x000000, 0xffffff ], "Grade", "%", "%d", null]
  };

  function unit(type) {
    if(type == :speed) {
      return System.getDeviceSettings().distanceUnits == 0 ? "km/h" : "mph";
    } else if(type == :distance) {
      return System.getDeviceSettings().distanceUnits == 0 ? "km" : "m";
    } else if(type == :elevation) {
      return System.getDeviceSettings().distanceUnits == 0 ? "m" : "ft";
    }
  }

  function unit_multiplier(type) {
    if(type == :speed) {
      return System.getDeviceSettings().distanceUnits == 0 ? 3.6 : 2.23694;
    } else if(type == :distance) {
      return System.getDeviceSettings().distanceUnits == 0 ? 0.001 : 0.000621371;
    } else if(type == :elevation) {
      return System.getDeviceSettings().distanceUnits == 0 ? null : 3.28084;
    }
  }

  const FIELDS_FOR_MODE = {
    :descending => [:speed, :elevationGrade, :distance, :power3s, :heartRate, :altitude, :heading, :cadence, :totalAscent],
    :climbing => [:power3s, :power1m, :heartRate, :elevationGrade, :speed, :distance, :cadence, :heading, :altitude, :totalAscent],
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
      :value => Calculator.getLatestValue(field, FIELD_DATA.get(field)[4]),
      :colors => FIELD_DATA.get(field)[0],
      :label => FIELD_DATA.get(field)[1],
      :unit => FIELD_DATA.get(field)[2],
      :formattedValue => Calculator.getLatestFormattedValue(field, FIELD_DATA.get(field)[3], FIELD_DATA.get(field)[4])
    });
  }
}
