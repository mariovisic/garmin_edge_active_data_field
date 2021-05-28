using Toybox.WatchUi as Ui;

class ActiveDataFieldView extends Ui.DataField
{
  hidden var batteryPercentage;
  hidden var clockTime;
  hidden var elapsedTime;

  function initialize() {
    DataField.initialize();
  }

  function compute(info) {
    batteryPercentage = System.getSystemStats().battery;
    clockTime = System.getClockTime();
    elapsedTime = info.elapsedTime;
    Calculator.logInfo(info);
    Calculator.updateMode();
  }

  function onUpdate(dc) {
    Colors.backgroundColor = getBackgroundColor();
    var fieldsSelector = new FieldSelector();

    ElapsedTimeField.draw(dc, elapsedTime);
    CurrentTimeAndBatteryField.draw(dc, clockTime, batteryPercentage);
    new SecondaryFields().draw(dc, fieldsSelector.secondaryFields());

    var mainField = fieldsSelector.mainField();

    new ArcField().draw(dc, mainField);
    new MainField().draw(dc, mainField);
  }
}
