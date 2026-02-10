import 'dart:math';
import 'dart:io';

void main() {
  print('Добро пожаловать в калькулятор!');
  print('Доступные операции:');
  print('1. Арифметические операции (+, -, *, /, ~/, %, pow)');
  print('2. Операции сравнения (==, !=, >, <, >=, <=)');
  print('3. Логические операции (&&, ||, !)');
  print('4. Выход (exit)');
  
  while (true) {
    print('\nВведите операцию (или "exit" для выхода):');
    String operation = stdin.readLineSync()!.trim().toLowerCase();
    
    if (operation == 'exit') {
      print('Выход из программы...');
      break;
    }
    
    switch (operation) {
      case '+':
        performArithmetic('+');
        break;
      case '-':
        performArithmetic('-');
        break;
      case '*':
        performArithmetic('*');
        break;
      case '/':
        performArithmetic('/');
        break;
      case '~':
        performArithmetic('~');
        break;
      case '%':
        performArithmetic('%');
        break;
      case 'pow':
        performArithmetic('pow');
        break;
      
      case '==':
        performComparison('==');
        break;
      case '!=':
        performComparison('!=');
        break;
      case '>':
        performComparison('>');
        break;
      case '<':
        performComparison('<');
        break;
      case '>=':
        performComparison('>=');
        break;
      case '<=':
        performComparison('<=');
        break;
      
      case '&&':
        performLogical('&&');
        break;
      case '||':
        performLogical('||');
        break;
      case '!':
        performLogical('!');
        break;
      
      default:
        print('Неизвестная операция. Попробуйте снова.');
    }
  }
}

void performArithmetic(String operation) {
  try {
    print('Введите первое число:');
    double num1 = double.parse(stdin.readLineSync()!);
    
    print('Введите второе число:');
    double num2 = double.parse(stdin.readLineSync()!);
    
    double? result;
    
    if (operation == '+') {
      result = num1 + num2;
    } else if (operation == '-') {
      result = num1 - num2;
    } else if (operation == '*') {
      result = num1 * num2;
    } else if (operation == '/') {
      if (num2 == 0) {
        print('Ошибка: деление на ноль');
        return;
      }
      result = num1 / num2;
    } else if (operation == '~') {
      if (num2 == 0) {
        print('Ошибка: деление на ноль');
        return;
      }
      result = (num1 ~/ num2).toDouble();
    } else if (operation == '%') {
      result = num1 % num2;
    } else if (operation == 'pow') {
      result = pow(num1, num2).toDouble();
    }
    
    print('Результат: $num1 $operation $num2 = $result');
  } catch (e) {
    print('Ошибка ввода. Введите корректные числа.');
  }
}

void performComparison(String operation) {
  try {
    print('Введите первое число:');
    double num1 = double.parse(stdin.readLineSync()!);
    
    print('Введите второе число:');
    double num2 = double.parse(stdin.readLineSync()!);
    
    bool result;
    
    if (operation == '==') {
      result = num1 == num2;
    } else if (operation == '!=') {
      result = num1 != num2;
    } else if (operation == '>') {
      result = num1 > num2;
    } else if (operation == '<') {
      result = num1 < num2;
    } else if (operation == '>=') {
      result = num1 >= num2;
    } else {
      result = num1 <= num2;
    }
    
    print('Результат: $num1 $operation $num2 = $result');
  } catch (e) {
    print('Ошибка ввода. Введите корректные числа.');
  }
}

void performLogical(String operation) {
  try {
    bool value1, value2;
    
    if (operation == '!') {
      print('Введите логическое значение (true/false):');
      value1 = stdin.readLineSync()!.toLowerCase() == 'true';
      
      bool result = !value1;
      print('Результат: !$value1 = $result');
    } else {
      print('Введите первое логическое значение (true/false):');
      value1 = stdin.readLineSync()!.toLowerCase() == 'true';
      
      print('Введите второе логическое значение (true/false):');
      value2 = stdin.readLineSync()!.toLowerCase() == 'true';
      
      bool result;
      if (operation == '&&') {
        result = value1 && value2;
        print('Результат: $value1 && $value2 = $result');
      } else if (operation == '||') {
        result = value1 || value2;
        print('Результат: $value1 || $value2 = $result');
      }
    }
  } catch (e) {
    print('Ошибка ввода. Введите true или false.');
  }
}