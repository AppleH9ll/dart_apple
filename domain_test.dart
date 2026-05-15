import 'package:test/test.dart';
import 'package:police/police.dart';

void main() {
  test('Employee toMap/fromMap', () {
    final original = Employee(id: 'e1', fullName: 'Иванов И.И.', rank: 'Майор', experienceYears: 12);
    final map = original.toMap();
    final restored = Employee.fromMap(map);
    expect(restored.id, 'e1');
    expect(restored.experienceYears, 12);
  });
}