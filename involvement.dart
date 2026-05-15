import 'identity.dart';

class Involvement implements Identity {
  @override
  final String id;
  final String incidentId;
  final String personId;
  final String role;

  const Involvement({
    required this.id,
    required this.incidentId,
    required this.personId,
    required this.role,
  });

  Map<String, dynamic> toMap() => {
        'id': id,
        'incidentId': incidentId,
        'personId': personId,
        'role': role,
      };

  factory Involvement.fromMap(Map<String, dynamic> map) {
    return Involvement(
      id: map['id'] as String,
      incidentId: map['incidentId'] as String,
      personId: map['personId'] as String,
      role: map['role'] as String,
    );
  }
}