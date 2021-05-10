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
    new ElapsedTimeField().draw(dc, elapsedTime);
    new CurrentTimeAndBatteryField().draw(dc, clockTime, batteryPercentage);
    // FIXME: Rather than passing the calculator in here, we should instead have an object we can get from the calculator to pass in here instead
    // This would be super useful as we can ask the calculator to generate a list of secondary fields based on what is available
    new SecondaryFields().draw(dc, calculator, ["speed", "distance", "heartRate", "cadence"]);

    // FIXME: Rather than doing this condition here, instead we should just ask the calculator to output it's "main" field!
    if (calculator.hasField("power")) {
      new PowerArcField().draw(dc, calculator.getLatestValue("power"), FTP);
      new MainField().draw(dc, calculator.getLatestFormattedValue("power", "%d"), "W");
    } else if(calculator.hasField("heartRate")) {
      new HeartRateArcField().draw(dc, calculator.getLatestValue("heartRate"), MAX_HR);
      new MainField().draw(dc, calculator.getLatestFormattedValue("heartRate", "%d"), "bpm");
    }
  }
}
