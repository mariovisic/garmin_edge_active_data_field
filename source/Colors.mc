module Colors {
  var backgroundColor = 0x000000;

  function get(colors) {
    return (colors.size() == 1 || backgroundColor == 0xffffff) ? colors[0] : colors[1];
  }
}
