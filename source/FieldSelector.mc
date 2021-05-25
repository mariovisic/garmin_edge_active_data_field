class FieldSelector {
  hidden var calculator;

  // FIXME: Move these to a shared external class
  const FIELD_DATA = {
    :power => { :colors => [ Graphics.COLOR_PURPLE, Graphics.COLOR_PURPLE ], :label => "Power", :unit => "W", :format => "%d" },
    :averagePower => { :colors => [ Graphics.COLOR_PURPLE, Graphics.COLOR_PURPLE ], :label => "Avg Power", :unit => "W", :format => "%d" },
    :maxPower => { :colors => [ Graphics.COLOR_PURPLE, Graphics.COLOR_PURPLE ], :label => "Max Power", :unit => "W", :format => "%d" },
    :heartRate => { :colors => [ Graphics.COLOR_RED, Graphics.COLOR_RED ], :label => "Heart Rate", :unit => "bpm", :format => "%d" },
    :averageHeartRate => { :colors => [ Graphics.COLOR_RED, Graphics.COLOR_RED ], :label => "Avg HR", :unit => "bpm", :format => "%d" },
    :speed => { :colors => [ Graphics.COLOR_BLUE, Graphics.COLOR_BLUE ], :label => "Speed", :unit => "km/h", :format => "%d" },
    :averageSpeed => { :colors => [ Graphics.COLOR_BLUE, Graphics.COLOR_BLUE ], :label => "Avg Speed", :unit => "km/h", :format => "%.1f" },
    :cadence => { :colors => [ Graphics.COLOR_DK_GREEN, Graphics.COLOR_GREEN ], :label => "Cadence", :unit => "rpm", :format => "%d" },
    :averageCadence => { :colors => [ Graphics.COLOR_DK_GREEN, Graphics.COLOR_GREEN ], :label => "Avg Cadence", :unit => "rpm", :format => "%d" },
    :distance => { :colors => [ Graphics.COLOR_BLACK, Graphics.COLOR_WHITE ], :label => "Distance", :unit => "km", :format => "%.1f" },
    :heading => { :colors => [ Graphics.COLOR_BLACK, Graphics.COLOR_WHITE ], :label => "Heading", :unit => "", :format => null },
    :altitude => { :colors => [ Graphics.COLOR_BLACK, Graphics.COLOR_WHITE ], :label => "Altitude", :unit => "m", :format => "%d" },
    :totalAscent => { :colors => [ Graphics.COLOR_BLACK, Graphics.COLOR_WHITE ], :label => "Total Ascent", :unit => "m", :format => "%d" },
  };

  const FIELDS_FOR_MODE = {
    :stopped => [ :distance, :averageHeartRate, :averagePower, :averageSpeed, :averageCadence, :maxPower, :totalAscent ],
    :flat => [ :power, :heartRate, :speed, :distance, :cadence, :heading, :altitude, :totalAscent  ],
  };

  function initialize(_calculator) {
    calculator = _calculator;
  }

  function mainField() {
    var fields = FIELDS_FOR_MODE[calculator.mode];
    for (var i = 0; i < fields.size() - 1; i++) {
      if(calculator.hasField(fields[i])) {
        return mapField(fields[i]);
      }
    }
    return mapField(fields[0]);
  }

  function secondaryFields() {
    var fields = FIELDS_FOR_MODE[calculator.mode];
    var secondaryFields = [];
    for (var i = 0; i < fields.size() - 1; i++) {
      if(calculator.hasField(fields[i])) {
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
      :value => calculator.getLatestValue(field),
      :formattedValue => calculator.getLatestFormattedValue(field, FIELD_DATA.get(field).get(:format))
    });
  }
}
