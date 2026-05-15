import 'identity.dart';

class Incident implements Identity {
  @override
  final String id;
  final String title;
  final String description;
  final DateTime dateTime;
  final String location;
  final String status;
  final String responsibleEmployeeId;

  const Incident({
    required this.id,
    required this.title,
    required this.description,
    required this.dateTime,
    required this.location,
    required this.status,
    required this.responsibleEmployeeId,
  });

  Map<String, dynamic> toMap() => {
        'id': id,
        'title': title,
        'description': description,
        'dateTime': dateTime.toIso8601String(),
        'location': location,
        'status': status,
        'responsibleEmployeeId': responsibleEmployeeId,
      };

  factory Incident.fromMap(Map<String, dynamic> map) {
    return Incident(
      id: map['id'] as String,
      title: map['title'] as String,
      description: map['description'] as String,
      dateTime: DateTime.parse(map['dateTime'] as String),
      location: map['location'] as String,
      status: map['status'] as String,
      responsibleEmployeeId: map['responsibleEmployeeId'] as String,
    );
  }

  @override
  String toString() => '$title ($status) в $location';
}