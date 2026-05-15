import 'package:test/test.dart';
import 'package:police/police.dart';

void main() {
  test('Valid date time', () {
    expect(isValidDateTime('2026-05-14T10:30:00'), true);
    expect(isValidDateTime('2026-05-14 10:30'), true);
  });

  test('Invalid date time', () {
    expect(isValidDateTime('not a date'), false);
    expect(isValidDateTime('32.13.9999'), false);
  });
}