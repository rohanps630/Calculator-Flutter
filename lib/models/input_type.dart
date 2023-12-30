enum InputType {
  // Numbers
  number0,
  number1,
  number2,
  number3,
  number4,
  number5,
  number6,
  number7,
  number8,
  number9,
  point,

  // Operators
  addition,
  subtraction,
  multiplication,
  division,
  equality,

  // Utility actions
  clear,
  delete,
  percent,
}

extension InputTypeValues on InputType {
  dynamic get value {
    switch (this) {
      // Numbers
      case InputType.number0:
        return 0;
      case InputType.number1:
        return 1;
      case InputType.number2:
        return 2;
      case InputType.number3:
        return 3;
      case InputType.number4:
        return 4;
      case InputType.number5:
        return 5;
      case InputType.number6:
        return 6;
      case InputType.number7:
        return 7;
      case InputType.number8:
        return 8;
      case InputType.number9:
        return 9;
      case InputType.point:
        return '.';

      // Operators
      case InputType.addition:
        return '+';
      case InputType.subtraction:
        return '-';
      case InputType.multiplication:
        return '*';
      case InputType.division:
        return '/';
      case InputType.equality:
        return '=';

      // Utility actions
      case InputType.clear:
        return 'C';
      case InputType.delete:
        return 'DEL';
      case InputType.percent:
        return '%';
    }
  }
}
