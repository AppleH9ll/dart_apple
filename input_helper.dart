import 'dart:io';
import '../domain/validators/validators.dart';

String askNonEmpty(String prompt) {
  while (true) {
    stdout.write(prompt);
    final input = stdin.readLineSync()?.trim() ?? '';
    if (isNotEmptyString(input)) return input;
    print('Ошибка: поле не может быть пустым.');
  }
}

int askPositiveInt(String prompt) {
  while (true) {
    stdout.write(prompt);
    final input = stdin.readLineSync()?.trim() ?? '';
    final int? value = int.tryParse(input);
    if (value != null && isPositiveInt(value)) return value;
    print('Ошибка: введите целое число > 0.');
  }
}

DateTime askDateTime(String prompt) {
  while (true) {
    stdout.write(prompt);
    final input = stdin.readLineSync()?.trim() ?? '';
    if (isValidDateTime(input)) return DateTime.parse(input);
    print('Ошибка: укажите дату в формате YYYY-MM-DD HH:MM или YYYY-MM-DDTHH:MM:SS');
  }
}