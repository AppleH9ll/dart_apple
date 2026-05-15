import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:sqlite3/sqlite3.dart';
import '../domain/models/employee.dart';
import '../domain/models/person.dart';
import '../domain/models/incident.dart';
import '../domain/models/involvement.dart';

class PoliceDatabase {
  final Database _db;

  PoliceDatabase(String filePath) : _db = sqlite3.open(filePath) {
    _createTables();
  }

  factory PoliceDatabase.inApp() {
    final path = p.join(Directory.current.path, 'police.db');
    return PoliceDatabase(path);
  }

  void _createTables() {
    _db.execute('''
      CREATE TABLE IF NOT EXISTS employees (
        id TEXT PRIMARY KEY,
        fullName TEXT NOT NULL,
        rank TEXT NOT NULL,
        experienceYears INTEGER NOT NULL
      );
    ''');

    _db.execute('''
      CREATE TABLE IF NOT EXISTS persons (
        id TEXT PRIMARY KEY,
        fullName TEXT NOT NULL,
        birthDate TEXT NOT NULL,
        passport TEXT NOT NULL UNIQUE
      );
    ''');

    _db.execute('''
      CREATE TABLE IF NOT EXISTS incidents (
        id TEXT PRIMARY KEY,
        title TEXT NOT NULL,
        description TEXT NOT NULL,
        dateTime TEXT NOT NULL,
        location TEXT NOT NULL,
        status TEXT NOT NULL,
        responsibleEmployeeId TEXT NOT NULL,
        FOREIGN KEY (responsibleEmployeeId) REFERENCES employees(id)
      );
    ''');

    _db.execute('''
      CREATE TABLE IF NOT EXISTS involvements (
        id TEXT PRIMARY KEY,
        incidentId TEXT NOT NULL,
        personId TEXT NOT NULL,
        role TEXT NOT NULL,
        FOREIGN KEY (incidentId) REFERENCES incidents(id) ON DELETE CASCADE,
        FOREIGN KEY (personId) REFERENCES persons(id) ON DELETE CASCADE
      );
    ''');
  }

  // --- Employee CRUD ---
  void insertEmployee(Employee e) {
    _db.execute(
      'INSERT OR REPLACE INTO employees(id,fullName,rank,experienceYears) VALUES(?,?,?,?)',
      [e.id, e.fullName, e.rank, e.experienceYears],
    );
  }

  List<Employee> getAllEmployees() {
    final rows = _db.select('SELECT id,fullName,rank,experienceYears FROM employees');
    return rows.map((r) => Employee.fromMap(r)).toList();
  }

  Employee? getEmployee(String id) {
    final rows = _db.select('SELECT id,fullName,rank,experienceYears FROM employees WHERE id=?', [id]);
    return rows.isEmpty ? null : Employee.fromMap(rows.first);
  }

  void deleteEmployee(String id) {
    _db.execute('DELETE FROM employees WHERE id=?', [id]);
  }

  // --- Person CRUD ---
  void insertPerson(Person p) {
    _db.execute(
      'INSERT OR REPLACE INTO persons(id,fullName,birthDate,passport) VALUES(?,?,?,?)',
      [p.id, p.fullName, p.birthDate.toIso8601String(), p.passport],
    );
  }

  List<Person> getAllPersons() {
    final rows = _db.select('SELECT id,fullName,birthDate,passport FROM persons');
    return rows.map((r) => Person.fromMap(r)).toList();
  }

  Person? getPerson(String id) {
    final rows = _db.select('SELECT id,fullName,birthDate,passport FROM persons WHERE id=?', [id]);
    return rows.isEmpty ? null : Person.fromMap(rows.first);
  }

  void deletePerson(String id) {
    _db.execute('DELETE FROM persons WHERE id=?', [id]);
  }

  // --- Incident CRUD ---
  void insertIncident(Incident i) {
    _db.execute(
      'INSERT OR REPLACE INTO incidents(id,title,description,dateTime,location,status,responsibleEmployeeId) VALUES(?,?,?,?,?,?,?)',
      [i.id, i.title, i.description, i.dateTime.toIso8601String(), i.location, i.status, i.responsibleEmployeeId],
    );
  }

  List<Incident> getAllIncidents() {
    final rows = _db.select('SELECT id,title,description,dateTime,location,status,responsibleEmployeeId FROM incidents');
    return rows.map((r) => Incident.fromMap(r)).toList();
  }

  Incident? getIncident(String id) {
    final rows = _db.select('SELECT id,title,description,dateTime,location,status,responsibleEmployeeId FROM incidents WHERE id=?', [id]);
    return rows.isEmpty ? null : Incident.fromMap(rows.first);
  }

  void deleteIncident(String id) {
    _db.execute('DELETE FROM incidents WHERE id=?', [id]);
  }

  // --- Involvement CRUD ---
  void insertInvolvement(Involvement inv) {
    _db.execute(
      'INSERT OR REPLACE INTO involvements(id,incidentId,personId,role) VALUES(?,?,?,?)',
      [inv.id, inv.incidentId, inv.personId, inv.role],
    );
  }

  List<Involvement> getAllInvolvements() {
    final rows = _db.select('SELECT id,incidentId,personId,role FROM involvements');
    return rows.map((r) => Involvement.fromMap(r)).toList();
  }

  void deleteInvolvement(String id) {
    _db.execute('DELETE FROM involvements WHERE id=?', [id]);
  }

  void close() => _db.dispose();
}