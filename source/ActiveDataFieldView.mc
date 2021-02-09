using Toybox.WatchUi as Ui;
using Toybox.Graphics;
using Toybox.Lang;

class ActiveDataFieldView extends Ui.DataField
{
  hidden var batteryPercentage;
  hidden var clockTime;
  hidden var calculator = new ActiveDataFieldCalculator();

  function initialize() {
    DataField.initialize();
  }

  function compute(info) {
    batteryPercentage = System.getSystemStats().battery;
    clockTime = System.getClockTime();
    calculator.logInfo(info);
  }

  function onUpdate(dc) {
    new BatteryPercentageIndicator().draw(dc, batteryPercentage);
    new CurrentTimeIndicator().draw(dc, clockTime);

    dc.setPenWidth(2);

    dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_TRANSPARENT);
    dc.drawText(
      ((dc.getWidth() / 18) * 4.5) + 2,
      ((dc.getHeight() / 6) * 1) + 2,
      Graphics.FONT_LARGE,
      calculator.getLatestValue("heartRate"),
      Graphics.TEXT_JUSTIFY_CENTER
    );

    dc.drawText(
      ((dc.getWidth() / 18) * 13.5) + 2,
      ((dc.getHeight() / 6) * 1) + 2,
      Graphics.FONT_LARGE,
      (calculator.getLatestValue("speed") * 3.6).format("%.0f"),
      Graphics.TEXT_JUSTIFY_CENTER
    );

    dc.setColor(Graphics.COLOR_RED, Graphics.COLOR_TRANSPARENT);
    dc.drawRoundedRectangle(
      ((dc.getWidth() / 18) * 1) - 4,
      (dc.getHeight() / 6) * 1,
      (dc.getWidth() / 18) * 8,
      (dc.getHeight() / 6),
      4
    );

    dc.setColor(Graphics.COLOR_BLUE, Graphics.COLOR_TRANSPARENT);
    dc.drawRoundedRectangle(
      ((dc.getWidth() / 18) * 10) - 4,
      (dc.getHeight() / 6) * 1,
      (dc.getWidth() / 18) * 8,
      (dc.getHeight() / 6),
      4
    );
  }
}
