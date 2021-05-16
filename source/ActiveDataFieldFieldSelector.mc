using Toybox.System;

class ActiveDataFieldsSelector {
  hidden var calculator;

  const FIELD_DATA = {
    :power => { :color => Graphics.COLOR_PURPLE, :label => "Power", :unit => "W", :format => "%d" },
    :averagePower => { :color => Graphics.COLOR_PURPLE, :label => "Avg Power", :unit => "W", :format => "%d" },
    :maxPower => { :color => Graphics.COLOR_PURPLE, :label => "Max Power", :unit => "W", :format => "%d" },
    :heartRate => { :color => Graphics.COLOR_RED, :label => "Heart Rate", :unit => "bpm", :format => "%d" },
    :averageHeartRate => { :color => Graphics.COLOR_RED, :label => "Avg HR", :unit => "bpm", :format => "%d" },
    :speed => { :color => Graphics.COLOR_BLUE, :label => "Speed", :unit => "km/h", :format => "%d" },
    :averageSpeed => { :color => Graphics.COLOR_BLUE, :label => "Avg Speed", :unit => "km/h", :format => "%d" },
    :cadence => { :color => Graphics.COLOR_DK_GREEN, :label => "Cadence", :unit => "rpm", :format => "%d" },
    :averageCadence => { :color => Graphics.COLOR_DK_GREEN, :label => "Avg Cadence", :unit => "rpm", :format => "%d" },
    :distance => { :color => Graphics.COLOR_BLACK, :label => "Distance", :unit => "km", :format => "%.1f" },
    :heading => { :color => Graphics.COLOR_BLACK, :label => "Heading", :unit => "", :format => null },
    :altitude => { :color => Graphics.COLOR_BLACK, :label => "Altitude", :unit => "m", :format => "%d" },
    :totalAscent => { :color => Graphics.COLOR_BLACK, :label => "Total Ascent", :unit => "m", :format => "%d" },
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
    return mapField(fields[fields.size() - 1]);
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
      :color => FIELD_DATA.get(field).get(:color),
      :label => FIELD_DATA.get(field).get(:label),
      :unit => FIELD_DATA.get(field).get(:unit),
      :value => calculator.getLatestValue(field),
      :formattedValue => calculator.getLatestFormattedValue(field, FIELD_DATA.get(field).get(:format))
    });
  }
}
