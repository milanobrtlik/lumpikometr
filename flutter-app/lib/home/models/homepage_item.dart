import 'package:flutter/cupertino.dart';

class HomepageItem {
  final int index;
  final Function widgetBuilder;
  final Icon icon;
  final Icon activeIcon;
  final String label;
  Widget? _initialised;

  HomepageItem({
    required this.index,
    required this.widgetBuilder,
    required IconData icon,
    required this.label,
    required IconData activeIcon,
  }) : icon = Icon(icon), activeIcon = Icon(activeIcon);

  Widget get page {
    if (_initialised is! Widget) {
      _initialised = widgetBuilder();
    }
    return _initialised!;
  }
}
