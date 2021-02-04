using Toybox.WatchUi as Ui;
using Toybox.Graphics;
using Toybox.Lang;

class ActiveDataFieldView extends Ui.DataField
{
  hidden var calculator = new ActiveDataFieldCalculator();

  function initialize() {
    DataField.initialize();
  }

  function compute(info) {
    calculator.logInfo(info);
  }

  function onUpdate(dc) {
    dc.setColor(Graphics.COLOR_RED, Graphics.COLOR_TRANSPARENT);

       
    dc.drawText(
        (dc.getWidth() / 9) * 2.5,                      // gets the width of the device and divides by 2
        (dc.getHeight() / 6) * 2.5,                     // gets the height of the device and divides by 2
        Graphics.FONT_LARGE,                    // sets the font size
        calculator.getLatestValue("heartRate"),                          // the String to display
        Graphics.TEXT_JUSTIFY_CENTER            // sets the justification for the text
                );


    dc.setPenWidth(2);

    dc.drawRoundedRectangle(
      (dc.getWidth() / 9) * 1,
      (dc.getHeight() / 6) * 2,
      (dc.getWidth() / 9) * 3,
      (dc.getHeight() / 6),
      4
    );

    dc.drawRoundedRectangle(
      (dc.getWidth() / 9) * 5,
      (dc.getHeight() / 6) * 2,
      (dc.getWidth() / 9) * 3,
      (dc.getHeight() / 6),
      4
    );

    // View.onUpdate(dc);
  }
}
