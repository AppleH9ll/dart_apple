import 'identity.dart';

class Person implements Identity {
  @override
  final String id;
  final String fullName;
  final DateTime birthDate;
  final String passport;

  const Person({
    required this.id,
    required this.fullName,
    required this.birthDate,
    required this.passport,
  });

  Map<String, dynamic> toMap() => {
        'id': id,
        'fullName': fullName,
        'birthDate': birthDate.toIso8601String(),
        'passport': passport,
      };

  factory Person.fromMap(Map<String, dynamic> map) {
    return Person(
      id: map['id'] as String,
      fullName: map['fullName'] as String,
      birthDate: DateTime.parse(map['birthDate'] as String),
      passport: map['passport'] as String,
    );
  }

  @override
  String toString() => '$fullName (паспорт: $passport)';
}