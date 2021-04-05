using Toybox.WatchUi as Ui;
using Toybox.Graphics;
using Toybox.Lang;

class ActiveDataFieldView extends Ui.DataField
{
  hidden var batteryPercentage;
  hidden var clockTime;
  hidden var calculator = new ActiveDataFieldCalculator();

  const FTP = 306;

  function initialize() {
    DataField.initialize();
  }

  function compute(info) {
    batteryPercentage = System.getSystemStats().battery;
    clockTime = System.getClockTime();
    calculator.logInfo(info);
  }

  function onUpdate(dc) {
    new BatteryPercentageField().draw(dc, batteryPercentage);
    new CurrentTimeField().draw(dc, clockTime);
    new SecondaryFields().draw(dc, calculator);
    new PowerArcField().draw(dc, calculator.getLatestValue("power"), FTP);
    new MainPowerField().draw(dc, calculator.getLatestFormattedValue("power", "%d"));
  }
}
