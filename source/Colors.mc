module Colors {
  var backgroundColor = 0x000000;

  function get(colors) {
    return (backgroundColor == 0xffffff) ? colors[0] : colors[1];
  }
}
