class FieldSelector {
  // FIXME: Move these to a shared external class
  const FIELD_DATA = {
    :power => { :colors => [ 0xAA00FF, 0xAA00FF ], :label => "Power", :unit => "W", :format => "%d" },
    :averagePower => { :colors => [ 0xAA00FF, 0xAA00FF ], :label => "Avg Power", :unit => "W", :format => "%d" },
    :maxPower => { :colors => [ 0xAA00FF, 0xAA00FF ], :label => "Max Power", :unit => "W", :format => "%d" },
    :heartRate => { :colors => [ 0xFF0000, 0xFF0000 ], :label => "Heart Rate", :unit => "bpm", :format => "%d" },
    :averageHeartRate => { :colors => [ 0xFF0000, 0xFF0000 ], :label => "Avg HR", :unit => "bpm", :format => "%d" },
    :speed => { :colors => [ 0x00AAFF, 0x00AAFF ], :label => "Speed", :unit => "km/h", :format => "%d" },
    :averageSpeed => { :colors => [ 0x00AAFF, 0x00AAFF ], :label => "Avg Speed", :unit => "km/h", :format => "%.1f" },
    :cadence => { :colors => [ 0x00AA00, 0x00FF00 ], :label => "Cadence", :unit => "rpm", :format => "%d" },
    :averageCadence => { :colors => [ 0x00AA00, 0x00FF00 ], :label => "Avg Cadence", :unit => "rpm", :format => "%d" },
    :distance => { :colors => [ 0x000000, 0xffffff ], :label => "Distance", :unit => "km", :format => "%.1f" },
    :heading => { :colors => [ 0x000000, 0xffffff ], :label => "Heading", :unit => "", :format => null },
    :altitude => { :colors => [ 0x000000, 0xffffff ], :label => "Altitude", :unit => "m", :format => "%d" },
    :totalAscent => { :colors => [ 0x000000, 0xffffff ], :label => "Total Ascent", :unit => "m", :format => "%d" },
  };

  const FIELDS_FOR_MODE = {
    :stopped => [ :distance, :averageHeartRate, :averagePower, :averageSpeed, :averageCadence, :maxPower, :totalAscent ],
    :flat => [ :power, :heartRate, :speed, :distance, :cadence, :heading, :altitude, :totalAscent  ],
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

    return mapFields(secondaryFields.slice(1, 5));
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
      :colors => FIELD_DATA.get(field).get(:colors),
      :label => FIELD_DATA.get(field).get(:label),
      :unit => FIELD_DATA.get(field).get(:unit),
      :value => Calculator.getLatestValue(field),
      :formattedValue => Calculator.getLatestFormattedValue(field, FIELD_DATA.get(field).get(:format))
    });
  }
}
