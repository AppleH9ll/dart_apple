import 'identity.dart';

class Employee implements Identity {
  @override
  final String id;
  final String fullName;
  final String rank;
  final int experienceYears;

  const Employee({
    required this.id,
    required this.fullName,
    required this.rank,
    required this.experienceYears,
  });

  Map<String, dynamic> toMap() => {
        'id': id,
        'fullName': fullName,
        'rank': rank,
        'experienceYears': experienceYears,
      };

  factory Employee.fromMap(Map<String, dynamic> map) {
    return Employee(
      id: map['id'] as String,
      fullName: map['fullName'] as String,
      rank: map['rank'] as String,
      experienceYears: map['experienceYears'] as int,
    );
  }

  @override
  String toString() => '$fullName ($rank), стаж $experienceYears лет';
}