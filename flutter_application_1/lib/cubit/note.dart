import 'package:equatable/equatable.dart';

class Note extends Equatable {
  const Note({
    required this.id,
    required this.text,
    this.isImportant = false,
  });

  final int id;
  final String text;
  final bool isImportant;

  Note copyWith({String? text, bool? isImportant}) {
    return Note(
      id: id,
      text: text ?? this.text,
      isImportant: isImportant ?? this.isImportant,
    );
  }

  @override
  List<Object?> get props => [id, text, isImportant];
}