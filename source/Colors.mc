using Toybox.Graphics;

class Colors {
  static var backgroundColor = Graphics.COLOR_BLACK;

  static const COLORS = {
    :text => { :light => Graphics.COLOR_BLACK, :dark => Graphics.COLOR_WHITE },
    :active_recovery => { :light => 0x777777, :dark => 0x999999 },
    :endurance => { :light => 0x8EC6FF, :dark => 0x8EC6FF },
    :tempo => { :light => 0x00A746, :dark => 0x00A746 },
    :threshold => { :light => 0xc2c219, :dark => 0xc2c219 },
    :vo2_max => { :light => 0xFF6111, :dark => 0xFF6111 },
    :anaerobic => { :light => 0xFF0F17, :dark => 0xFF0F17 },
    :neuromuscular => { :light => 0xBC0722, :dark => 0xBC0722 },
    :speed_10 => { :light => 0x0084ff, :dark => 0x0084ff },
    :speed_20 => { :light => 0x297dcc, :dark => 0x339cff },
    :speed_30 => { :light => 0x3d6d99, :dark => 0x66b5ff },
    :speed_40 => { :light => 0x3d5266, :dark => 0x99ceff },
    :speed_50 => { :light => 0x292e33, :dark => 0xcce6ff },
    :speed_60 => { :light => 0x000000, :dark => 0xffffff },
    :power => { :light => Graphics.COLOR_PURPLE, :dark => Graphics.COLOR_PURPLE },
    :heartRate => { :light => Graphics.COLOR_RED, :dark => Graphics.COLOR_RED },
    :speed => { :light => Graphics.COLOR_BLUE, :dark => Graphics.COLOR_BLUE },
    :cadence => { :light => Graphics.COLOR_DK_GREEN, :dark => Graphics.COLOR_GREEN }
  };

  static function get(label) {
    if (backgroundColor == Graphics.COLOR_WHITE) {
      return COLORS.get(label).get(:light);
    } else {
      return COLORS.get(label).get(:dark);
    }
  }
}
