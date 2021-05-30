// Layout class :)
// TODO: Remove this and direclty use getWidth() and getHeight()
// multiply by float, eg:
// dc.getWidth() * (0.43)
module L {
  var width;
  var height;

  function w(percent) {
    return percent.toFloat() * width / 100f;
  }

  function h(percent) {
    return percent.toFloat() * height / 100f;
  }
}
