using Toybox.WatchUi as Ui;
using Toybox.Graphics;
using Toybox.Lang;

class ActiveDataFieldView extends Ui.DataField
{
  hidden var batteryPercentage;
  hidden var clockTime;
  hidden var elapsedTime;
  hidden var calculator = new ActiveDataFieldCalculator();

  const FTP = 306;

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
    new ElapsedTimeField().draw(dc, elapsedTime);
    new CurrentTimeAndBatteryField().draw(dc, clockTime, batteryPercentage);
    new SecondaryFields().draw(dc, calculator, ["speed", "distance", "heartRate", "cadence"]);
    new PowerArcField().draw(dc, calculator.getLatestValue("power"), FTP);
    new MainField().draw(dc, calculator.getLatestFormattedValue("power", "%d"), "W");
  }
}
