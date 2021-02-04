using Toybox.WatchUi as Ui;
using Toybox.Graphics;
using Toybox.Lang;

class ActiveDataFieldView extends Ui.DataField
{
  hidden var heartRateValue;
  hidden var currentSpeedValue;
  hidden var historicalSpeedValues = new [0];

  function initialize() {
    DataField.initialize();
    heartRateValue = 0.0f;
  }

  function compute(info) {
    if (info has :currentSpeed) {
          if (info.currentSpeed != null) {
            currentSpeedValue = info.currentSpeed * 3.6;
            historicalSpeedValues.add(currentSpeedValue);
            historicalSpeedValues = historicalSpeedValues.slice(-5, null);
            System.print("speeds: ");
            System.println(historicalSpeedValues);

            //System.println(Lang.format("currentSpeed $1", ["cats"]));
          }
    }


    
    if (info has :currentHeartRate) {
      if (info.currentHeartRate != null) {
          heartRateValue = info.currentHeartRate;
      } else {
          heartRateValue = 0.0f;
      }
    }
  }

  function onUpdate(dc) {
    dc.setColor(Graphics.COLOR_RED, Graphics.COLOR_TRANSPARENT);

       
    dc.drawText(
        (dc.getWidth() / 9) * 2.5,                      // gets the width of the device and divides by 2
        (dc.getHeight() / 6) * 2.5,                     // gets the height of the device and divides by 2
        Graphics.FONT_LARGE,                    // sets the font size
        heartRateValue,                          // the String to display
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