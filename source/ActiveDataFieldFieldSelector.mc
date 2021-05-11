using Toybox.System;

class ActiveDataFieldsSelector {
  hidden var calculator;

  const FIELD_DATA = {
    :power => { :color => Graphics.COLOR_BLACK, :label => "Power", :unit => "W", :format => "%d" },
    :heartRate => { :color => Graphics.COLOR_RED, :label => "Heart Rate", :unit => "bpm", :format => "%d" },
    :speed => { :color => Graphics.COLOR_BLUE, :label => "Speed", :unit => "km/h", :format => "%d" },
    :cadence => { :color => Graphics.COLOR_DK_GREEN, :label => "Cadence", :unit => "rpm", :format => "%d" },
    :distance => { :color => Graphics.COLOR_PURPLE, :label => "Distance", :unit => "km", :format => "%.1f" },
  };

  function initialize(_calculator) {
    calculator = _calculator;
  }

  function mainField() {
    if(calculator.hasField(:power)) {
      return mapField(:power);
    } else {
      return mapField(:heartRate);
    }
  }

  function secondaryFields() {
    return mapFields([:speed, :distance, :heartRate, :cadence]);
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
