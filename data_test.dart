import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:test/test.dart';
import 'package:police/police.dart';

void main() {
  test('Insert and read Employee', () {
    final tempPath = p.join(Directory.current.path, 'test_police.db');
    final db = PoliceDatabase(tempPath);
    final emp = Employee(id: 't1', fullName: 'Тест', rank: 'Рядовой', experienceYears: 1);
    db.insertEmployee(emp);
    final list = db.getAllEmployees();
    expect(list.length, 1);
    expect(list.first.id, 't1');
    db.close();
    File(tempPath).deleteSync();
  });
}