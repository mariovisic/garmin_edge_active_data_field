using Toybox.WatchUi as Ui;
using Toybox.Graphics;
using Toybox.Lang;

class ActiveDataFieldView extends Ui.DataField
{
  hidden var batteryPercentage;
  hidden var clockTime;
  hidden var elapsedTime;
  hidden var calculator = new ActiveDataFieldCalculator();

  // FIXME: These should eventually be set by the user!0
  const FTP = 306;
  const MAX_HR = 191;

  function initialize() {
    DataField.initialize();
  }

  function compute(info) {
    batteryPercentage = System.getSystemStats().battery;
    clockTime = System.getClockTime();
    elapsedTime = info.elapsedTime;
    calculator.logInfo(info);
  }

  function onUpdate(dc) {
    var fieldsSelector = new ActiveDataFieldsSelector(calculator);

    new ElapsedTimeField().draw(dc, elapsedTime);
    new CurrentTimeAndBatteryField().draw(dc, clockTime, batteryPercentage);
    new SecondaryFields().draw(dc, fieldsSelector.secondaryFields());

    var mainField = fieldsSelector.mainField();

    // FIXME: Remove this condition and have a way of using the same code path
    // for power/heart rate/speed etc...
    if (mainField.get(:name) == :power) {
      new PowerArcField().draw(dc, calculator.getLatestValue(:power), FTP);
    } else if(mainField.get(:name) == :heartRate) {
      new HeartRateArcField().draw(dc, calculator.getLatestValue(:heartRate), MAX_HR);
    }

    new MainField().draw(dc, mainField);
  }
}
