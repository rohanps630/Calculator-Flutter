// calculator_viewmodel.dart

import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

import 'package:calculator/models/input_type.dart';

const _maxInputLength = 15;
const _maxDecimalLength = 5;

class CalculatorViewModel extends ChangeNotifier {
  String _inputExpression = '';
  double result = 0;

  String get displayText => _inputExpression.isEmpty
      ? _doubleToDisplayText(result)
      : _convertOperatorForDisplay(_inputExpression);

  bool get _canAddInput => _inputExpression.length < _maxInputLength;

  void onPressButton({
    required InputType inputType,
    required VoidCallback onTextOverflow,
  }) {
    switch (inputType) {
      case InputType.number0:
      case InputType.number1:
      case InputType.number2:
      case InputType.number3:
      case InputType.number4:
      case InputType.number5:
      case InputType.number6:
      case InputType.number7:
      case InputType.number8:
      case InputType.number9:
      case InputType.point:
        _handleNumberInput(inputType, onTextOverflow);
      case InputType.addition:
      case InputType.subtraction:
      case InputType.multiplication:
      case InputType.division:
      case InputType.percent:
        _handleOperatorInput(inputType, onTextOverflow);
        break;
      case InputType.equality:
        _onPressEquality();
        break;
      case InputType.clear:
        _onPressClear();
        break;
      case InputType.delete:
        _onPressDelete();
        break;
    }
  }

  void _handleNumberInput(InputType inputType, VoidCallback onTextOverflow) {
    var number = inputType.value.toString().replaceFirst('number', '');

    if (!_isNumber(number) && !_isLastInputNumber) {
      _inputExpression =
          _inputExpression.substring(0, _inputExpression.length - 1) + number;
      notifyListeners();
      return;
    }

    if (!_canAddInput) {
      onTextOverflow.call();
      return;
    }

    if (_inputExpression == '0') {
      _inputExpression = '';
    }

    _inputExpression += number;
    notifyListeners();
  }

  void _handleOperatorInput(InputType inputType, VoidCallback onTextOverflow) {
    var operator = inputType.value.toString();

    if (!_isNumber(operator) && !_isLastInputNumber) {
      _inputExpression =
          _inputExpression.substring(0, _inputExpression.length - 1) + operator;
      notifyListeners();
      return;
    }

    if (!_canAddInput) {
      onTextOverflow.call();
      return;
    }

    _inputExpression += operator;
    notifyListeners();
  }

  bool get _isLastInputNumber {
    if (_inputExpression.isEmpty) {
      return false;
    }

    var lastInput = _inputExpression[_inputExpression.length - 1];
    return _isNumber(lastInput);
  }

  String _convertOperatorForDisplay(String expression) {
    expression = expression.replaceAll('*', '×');
    expression = expression.replaceAll('/', '÷');
    return expression;
  }

  bool _isNumber(String input) {
    return int.tryParse(input) != null;
  }

  void _onPressClear() {
    _inputExpression = '';
    result = 0;
    notifyListeners();
  }

  void _onPressDelete() {
    _inputExpression =
        _inputExpression.substring(0, _inputExpression.length - 1);
    result = 0;
    notifyListeners();
  }

  void _onPressEquality() {
    if (!_isLastInputNumber) {
      _inputExpression =
          _inputExpression.substring(0, _inputExpression.length - 1);
    }

    _evaluateExpression();
  }

  void _evaluateExpression() {
    try {
      Expression exp = Parser().parse(_inputExpression);
      var eval = exp.evaluate(EvaluationType.REAL, ContextModel());
      result = eval;
      _inputExpression = _doubleToDisplayText(result);
    } catch (e) {
      log(e.toString());
    }

    notifyListeners();
  }

  String _doubleToDisplayText(double value) {
    if (value.truncateToDouble() == value) {
      return value.truncate().toString();
    } else {
      var text = value.toString();
      var decimalIndex = text.indexOf('.');
      var decimalLength = text.length - decimalIndex - 1;
      if (decimalLength > _maxDecimalLength) {
        text = value.toStringAsFixed(_maxDecimalLength);
      }

      return text;
    }
  }
}
