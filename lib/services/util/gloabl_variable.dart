import 'package:flutter/cupertino.dart';

/// Global variables
/// * [GlobalKey<NavigatorState>]
class GlobalVariable {
  /// This global key is used in material app for navigation through firebase notifications.
  /// [navState] usage can be found in [notification_notifier.dart] file.
  GlobalKey<NavigatorState>? navState;

  static GlobalVariable instance = GlobalVariable();

  GlobalVariable() {
    navState = GlobalKey<NavigatorState>();
  }
}
