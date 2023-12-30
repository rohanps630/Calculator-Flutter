import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:calculator/viewmodels/calculator_viewmodel.dart';

class HeaderDisplay extends StatelessWidget {
  const HeaderDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    var viewmodel = context.watch<CalculatorViewModel>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        const Spacer(),
        FittedBox(
          fit: BoxFit.scaleDown,
          alignment: Alignment.centerRight,
          child: Text(
            viewmodel.displayText,
            style: TextStyle(
              fontSize: 70,
              color: Theme.of(context).colorScheme.onBackground,
            ),
            textAlign: TextAlign.end,
          ),
        ),
      ],
    );
  }
}
