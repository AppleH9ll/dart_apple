String formatName(String surname, String name, [String? patronymic]) {
  if (patronymic != null) {
    return '$surname $name $patronymic';
  } else {
    return '$surname $name';
  }
}


double? calculate(double a, double b, String operation) {
  switch (operation) {
    case '+':
      return a + b;
    case '-':
      return a - b;
    case '*':
      return a * b;
    case '/':
      if (b == 0) {
        return null;
      }
      return a / b;
    default:
      return null;
  }
}


void countSigns(List<int> numbers) {
  int positive = 0;
  int negative = 0;
  int zero = 0;

  for (int n in numbers) {
    if (n > 0) {
      positive++;
    } else if (n < 0) {
      negative++;
    } else {
      zero++;
    }
  }
  print('Положительных: $positive, Отрицательных: $negative, Нулевых: $zero');
}


List<int> transformList(List<int> numbers, int Function(int) transformer) {
  List<int> result = [];
  for (int n in numbers) {
    result.add(transformer(n));
  }
  return result;
}


int sumDigits(int n) {
  if (n < 10) {
    return n;
  }
  return n % 10 + sumDigits(n ~/ 10);
}


void main() {
  print('Задача 1:');
  print(formatName('Иванов', 'Иван'));
  print(formatName('Петров', 'Пётр', 'Сергеевич'));

  print('\nЗадача 2:');
  print('2 + 3 = ${calculate(2, 3, '+')}');
  print('5 - 2 = ${calculate(5, 2, '-')}');
  print('4 * 6 = ${calculate(4, 6, '*')}');
  print('10 / 2 = ${calculate(10, 2, '/')}');
  print('10 / 0 = ${calculate(10, 0, '/')}');

  print('\nЗадача 3:');
  countSigns([-5, 0, 3, -1, 7, 0, 2]);

  print('\nЗадача 4:');
  List<int> original = [1, 2, 3, 4, 5];
  List<int> squared = transformList(original, (x) => x * x);
  print('Квадраты: $squared');

  print('\nЗадача 5:');
  print('Сумма цифр числа 12345 = ${sumDigits(12345)}');
  print('Сумма цифр числа 7 = ${sumDigits(7)}');
  print('Сумма цифр числа 0 = ${sumDigits(0)}');
}