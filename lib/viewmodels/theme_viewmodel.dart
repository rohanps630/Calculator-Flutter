import 'package:flutter/material.dart';

/// ViewModel for managing the app's theme.
class ThemeViewModel extends ChangeNotifier {
  // Default seed color for the theme.
  Color get primaryColor => _primaryColor;

  static const Color _primaryColor = Colors.amber;

  // Get or set the brightness of the theme.
  Brightness get themeBrightness => _themeBrightness;
  Brightness _themeBrightness = Brightness.light;

  set themeBrightness(Brightness value) {
    _themeBrightness = value;
    notifyListeners();
  }
}
