import 'dart:io';
import '../data/police_database.dart';
import '../domain/models/employee.dart';
import '../domain/models/person.dart';
import '../domain/models/incident.dart';
import '../domain/models/involvement.dart';
import 'input_helper.dart';

void runMenu(PoliceDatabase db) {
  while (true) {
    print('ОТДЕЛЕНИЕ ПОЛИЦИИ');
    print('1 — список сотрудников');
    print('2 — добавить сотрудника');
    print('3 — удалить сотрудника');
    print('4 — список лиц');
    print('5 — добавить лицо');
    print('6 — удалить лицо');
    print('7 — список происшествий');
    print('8 — добавить происшествие');
    print('9 — удалить происшествие');
    print('10 — список участников (связей)');
    print('11 — добавить участника');
    print('12 — удалить участника');
    print('13 — показать всё из БД');
    print('0 — выход');
    final choice = stdin.readLineSync()?.trim() ?? '';

    switch (choice) {
      case '1': _listEmployees(db); break;
      case '2': _addEmployee(db); break;
      case '3': _deleteEmployee(db); break;
      case '4': _listPersons(db); break;
      case '5': _addPerson(db); break;
      case '6': _deletePerson(db); break;
      case '7': _listIncidents(db); break;
      case '8': _addIncident(db); break;
      case '9': _deleteIncident(db); break;
      case '10': _listInvolvements(db); break;
      case '11': _addInvolvement(db); break;
      case '12': _deleteInvolvement(db); break;
      case '13': _printAll(db); break;
      case '0': print('До свидания.'); return;
      default: print('Неизвестная команда.');
    }
  }
}

void _listEmployees(PoliceDatabase db) {
  final list = db.getAllEmployees();
  if (list.isEmpty) print('Нет сотрудников.');
  else for (var e in list) print('id: ${e.id} | ${e.fullName} | ${e.rank} | стаж ${e.experienceYears}');
}

void _addEmployee(PoliceDatabase db) {
  final id = askNonEmpty('ID сотрудника: ');
  final name = askNonEmpty('ФИО: ');
  final rank = askNonEmpty('Звание: ');
  final exp = askPositiveInt('Стаж (лет): ');
  db.insertEmployee(Employee(id: id, fullName: name, rank: rank, experienceYears: exp));
  print('Сотрудник добавлен.');
}

void _deleteEmployee(PoliceDatabase db) {
  final id = askNonEmpty('ID сотрудника для удаления: ');
  db.deleteEmployee(id);
  print('Удалён (если существовал).');
}

void _listPersons(PoliceDatabase db) {
  final list = db.getAllPersons();
  if (list.isEmpty) print('Нет лиц.');
  else for (var p in list) print('id: ${p.id} | ${p.fullName} | ${p.birthDate.toLocal()} | паспорт: ${p.passport}');
}

void _addPerson(PoliceDatabase db) {
  final id = askNonEmpty('ID лица: ');
  final name = askNonEmpty('ФИО: ');
  final birth = askDateTime('Дата рождения (YYYY-MM-DD): ');
  final passport = askNonEmpty('Паспорт (серия номер): ');
  db.insertPerson(Person(id: id, fullName: name, birthDate: birth, passport: passport));
  print('Лицо добавлено.');
}

void _deletePerson(PoliceDatabase db) {
  final id = askNonEmpty('ID лица для удаления: ');
  db.deletePerson(id);
  print('Удалён.');
}

void _listIncidents(PoliceDatabase db) {
  final list = db.getAllIncidents();
  if (list.isEmpty) print('Нет происшествий.');
  else for (var inc in list) {
    print('id: ${inc.id} | ${inc.title} | ${inc.status} | ${inc.location} | ответственный: ${inc.responsibleEmployeeId}');
  }
}

void _addIncident(PoliceDatabase db) {
  final id = askNonEmpty('ID происшествия: ');
  final title = askNonEmpty('Название: ');
  final desc = askNonEmpty('Описание: ');
  final dt = askDateTime('Дата/время (YYYY-MM-DD HH:MM): ');
  final location = askNonEmpty('Место: ');
  final status = askNonEmpty('Статус (открыто/в работе/закрыто): ');
  final empId = askNonEmpty('ID ответственного сотрудника: ');
  db.insertIncident(Incident(
    id: id,
    title: title,
    description: desc,
    dateTime: dt,
    location: location,
    status: status,
    responsibleEmployeeId: empId,
  ));
  print('Происшествие добавлено.');
}

void _deleteIncident(PoliceDatabase db) {
  final id = askNonEmpty('ID происшествия для удаления: ');
  db.deleteIncident(id);
  print('Удалено.');
}

void _listInvolvements(PoliceDatabase db) {
  final list = db.getAllInvolvements();
  if (list.isEmpty) print('Нет связей.');
  else for (var inv in list) {
    print('id: ${inv.id} | происшествие: ${inv.incidentId} | лицо: ${inv.personId} | роль: ${inv.role}');
  }
}

void _addInvolvement(PoliceDatabase db) {
  final id = askNonEmpty('ID связи: ');
  final incId = askNonEmpty('ID происшествия: ');
  final persId = askNonEmpty('ID лица: ');
  final role = askNonEmpty('Роль (заявитель/подозреваемый/свидетель): ');
  db.insertInvolvement(Involvement(id: id, incidentId: incId, personId: persId, role: role));
  print('Связь добавлена.');
}

void _deleteInvolvement(PoliceDatabase db) {
  final id = askNonEmpty('ID связи для удаления: ');
  db.deleteInvolvement(id);
  print('Удалено.');
}

void _printAll(PoliceDatabase db) {
  print('\nСОТРУДНИКИ');
  _listEmployees(db);
  print('\nЛИЦА');
  _listPersons(db);
  print('\nПРОИСШЕСТВИЯ');
  _listIncidents(db);
  print('\nУЧАСТНИКИ');
  _listInvolvements(db);
}