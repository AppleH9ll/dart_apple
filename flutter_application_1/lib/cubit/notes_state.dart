import 'package:equatable/equatable.dart';

class NotesState extends Equatable {
  const NotesState({
    this.notes = const [],
    this.editingIndex,
  });

  final List<String> notes;
  final int? editingIndex;

  bool get isEditing => editingIndex != null;

  NotesState copyWith({
    List<String>? notes,
    int? editingIndex,
    bool clearEditing = false,
  }) {
    return NotesState(
      notes: notes ?? this.notes,
      editingIndex: clearEditing ? null : (editingIndex ?? this.editingIndex),
    );
  }

  @override
  List<Object?> get props => [notes, editingIndex];
}