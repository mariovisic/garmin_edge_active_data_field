using Toybox.Graphics;

module Colors {
  var backgroundColor = Graphics.COLOR_BLACK;

  // LIGHT THEN DARK COLORS
  var COLORS = {
    :text => [ Graphics.COLOR_BLACK, Graphics.COLOR_WHITE ],
    :active_recovery => [ 0x777777, 0x999999 ],
    :endurance => [ 0x8EC6FF, 0x8EC6FF ],
    :tempo => [ 0x00A746, 0x00A746 ],
    :threshold => [ 0xc2c219, 0xc2c219 ],
    :vo2_max => [ 0xFF6111, 0xFF6111 ],
    :anaerobic => [ 0xFF0F17, 0xFF0F17 ],
    :neuromuscular => [ 0xBC0722, 0xBC0722 ],
    :speed_10 => [ 0x0084ff, 0x0084ff ],
    :speed_20 => [ 0x297dcc, 0x339cff ],
    :speed_30 => [ 0x3d6d99, 0x66b5ff ],
    :speed_40 => [ 0x3d5266, 0x99ceff ],
    :speed_50 => [ 0x292e33, 0xcce6ff ],
    :speed_60 => [ 0x000000, 0xffffff ],
    :power => [ Graphics.COLOR_PURPLE, Graphics.COLOR_PURPLE ],
    :heartRate => [ Graphics.COLOR_RED, Graphics.COLOR_RED ],
    :speed => [ Graphics.COLOR_BLUE, Graphics.COLOR_BLUE ],
    :cadence => [ Graphics.COLOR_DK_GREEN, Graphics.COLOR_GREEN ]
  };

  function get(label) {
    if (backgroundColor == Graphics.COLOR_WHITE) {
      return COLORS.get(label)[0];
    } else {
      return COLORS.get(label)[1];
    }
  }
}
