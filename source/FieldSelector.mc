using Toybox.System;

class FieldSelector {
  hidden var calculator;

  // FIXME: Move these to a shared external class
  const FIELD_DATA = {
    :power => { :color => :power, :label => "Power", :unit => "W", :format => "%d" },
    :averagePower => { :color => :power, :label => "Avg Power", :unit => "W", :format => "%d" },
    :maxPower => { :color => :power, :label => "Max Power", :unit => "W", :format => "%d" },
    :heartRate => { :color => :heartRate, :label => "Heart Rate", :unit => "bpm", :format => "%d" },
    :averageHeartRate => { :color => :heartRate, :label => "Avg HR", :unit => "bpm", :format => "%d" },
    :speed => { :color => :speed, :label => "Speed", :unit => "km/h", :format => "%d" },
    :averageSpeed => { :color => :speed, :label => "Avg Speed", :unit => "km/h", :format => "%.1f" },
    :cadence => { :color => :cadence, :label => "Cadence", :unit => "rpm", :format => "%d" },
    :averageCadence => { :color => :cadence, :label => "Avg Cadence", :unit => "rpm", :format => "%d" },
    :distance => { :color => :text, :label => "Distance", :unit => "km", :format => "%.1f" },
    :heading => { :color => :text, :label => "Heading", :unit => "", :format => null },
    :altitude => { :color => :text, :label => "Altitude", :unit => "m", :format => "%d" },
    :totalAscent => { :color => :text, :label => "Total Ascent", :unit => "m", :format => "%d" },
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
      :color => FIELD_DATA.get(field).get(:color),
      :label => FIELD_DATA.get(field).get(:label),
      :unit => FIELD_DATA.get(field).get(:unit),
      :value => calculator.getLatestValue(field),
      :formattedValue => calculator.getLatestFormattedValue(field, FIELD_DATA.get(field).get(:format))
    });
  }
}
