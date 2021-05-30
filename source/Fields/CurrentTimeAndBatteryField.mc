module CurrentTimeAndBatteryField {
  function draw(dc, clockTime, batteryPercentage) {
    dc.setColor(Colors.get([0x000000, 0xffffff]), -1);

    var amOrPm = clockTime.hour < 12 ? "am" : "pm";
    var hour = clockTime.hour % 12 == 0 ? 12 : clockTime.hour % 12;

    dc.drawText(
      (L.w(4)),
      (L.w(4)),
      2,
      hour.format("%2d") + ":" + clockTime.min.format("%02d") + amOrPm + " / " + batteryPercentage.format("%2d") + "%",
      2
    );
  }
}
