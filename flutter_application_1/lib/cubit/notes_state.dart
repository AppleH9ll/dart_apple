import 'package:equatable/equatable.dart';
import 'note.dart';

class NotesState extends Equatable {
  const NotesState({
    this.notes = const [],
    this.editingId,
  });

  final List<Note> notes;
  final int? editingId;

  bool get isEditing => editingId != null;

  Note? get editingNote {
    if (editingId == null) return null;
    for (final n in notes) {
      if (n.id == editingId) return n;
    }
    return null;
  }

  NotesState copyWith({
    List<Note>? notes,
    int? editingId,
    bool clearEditing = false,
  }) {
    return NotesState(
      notes: notes ?? this.notes,
      editingId: clearEditing ? null : (editingId ?? this.editingId),
    );
  }

  @override
  List<Object?> get props => [notes, editingId];
}