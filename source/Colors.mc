using Toybox.Graphics;

module Colors {
  var backgroundColor = Graphics.COLOR_BLACK;

  function get(colors) {
    return (backgroundColor == Graphics.COLOR_WHITE) ? colors[0] : colors[1];
  }
}
