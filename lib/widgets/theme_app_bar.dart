import 'package:flutter/material.dart';
import 'package:calculator/viewmodels/theme_viewmodel.dart';
import 'package:provider/provider.dart';

class ThemeAppBar {
  static AppBar getAppBar(BuildContext context) {
    var viewmodel = context.watch<ThemeViewModel>();

    return AppBar(
      actions: [
        _buildAnimatedSwitch(context, viewmodel),
        const SizedBox(width: 10),
      ],
    );
  }

  static Widget _buildAnimatedSwitch(
      BuildContext context, ThemeViewModel viewmodel) {
    return GestureDetector(
      onTap: () {
        viewmodel.themeBrightness = viewmodel.themeBrightness == Brightness.dark
            ? Brightness.light
            : Brightness.dark;
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: 60,
        height: 35,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: viewmodel.themeBrightness == Brightness.dark
              ? Colors.grey
              : Theme.of(context).colorScheme.primary,
        ),
        child: Stack(
          children: [
            AnimatedPositioned(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              top: (35 - 30) / 2,
              left: viewmodel.themeBrightness == Brightness.dark ? 25 : 0,
              right: viewmodel.themeBrightness == Brightness.dark ? 0 : 25,
              child: Container(
                width: 30,
                height: 30,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
