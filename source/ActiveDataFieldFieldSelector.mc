using Toybox.System;

class ActiveDataFieldsSelector {
  hidden var calculator;

  const FIELD_DATA = {
    "heartRate" => { "color" => Graphics.COLOR_RED, "label" => "Heart Rate", "unit" => "bpm", "format" => "%d" },
    "speed" => { "color" => Graphics.COLOR_BLUE, "label" => "Speed", "unit" => "km/h", "format" => "%d" },
    "cadence" => { "color" => Graphics.COLOR_DK_GREEN, "label" => "Cadence", "unit" => "rpm", "format" => "%d" },
    "distance" => { "color" => Graphics.COLOR_PURPLE, "label" => "Distance", "unit" => "km", "format" => "%.1f" },
  };

  function initialize(_calculator) {
    calculator = _calculator;
  }

  function secondaryFields() {
    return mapFields(["speed", "distance", "heartRate", "cadence"]);
  }

  hidden function mapFields(fields) {
    var outputFields = [];
    for (var i = 0; i < fields.size(); i++) {
      outputFields.add({
        "name" => fields[i],
        "color" => FIELD_DATA.get(fields[i]).get("color"),
        "label" => FIELD_DATA.get(fields[i]).get("label"),
        "unit" => FIELD_DATA.get(fields[i]).get("unit"),
        "formattedValue" => calculator.getLatestFormattedValue(fields[i], FIELD_DATA.get(fields[i]).get("format")),
      });
    }
    return outputFields;
  }
}
