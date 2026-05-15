import 'package:police/police.dart';

void main() {
  final db = PoliceDatabase.inApp();
  try {
    runMenu(db);
  } finally {
    db.close();
  }
}