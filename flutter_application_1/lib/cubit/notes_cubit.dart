import 'package:flutter_bloc/flutter_bloc.dart';
import 'note.dart';
import 'notes_state.dart';

class NotesCubit extends Cubit<NotesState> {
  NotesCubit() : super(const NotesState());

  int _nextId = 1;

  //Сохранение / редактирование

  void saveNote(String text) {
    final trimmed = text.trim();
    if (trimmed.isEmpty) return;

    if (state.isEditing) {
      _updateNote(trimmed);
    } else {
      _addNote(trimmed);
    }
  }

  void _addNote(String text) {
    final newNote = Note(id: _nextId++, text: text);
    emit(state.copyWith(notes: [...state.notes, newNote]));
  }

  void _updateNote(String text) {
    final updated = state.notes
        .map((n) => n.id == state.editingId ? n.copyWith(text: text) : n)
        .toList();
    emit(state.copyWith(notes: updated, clearEditing: true));
  }

  void startEditing(int id) {
    if (!state.notes.any((n) => n.id == id)) return;
    emit(state.copyWith(editingId: id));
  }

  void cancelEditing() {
    emit(state.copyWith(clearEditing: true));
  }

  //Удаление

  void deleteNote(int id) {
    final updated = state.notes.where((n) => n.id != id).toList();
    emit(NotesState(
      notes: updated,
      editingId: state.editingId == id ? null : state.editingId,
    ));
  }

  //Жестовые действия

  /// Двойной тап: переключить статус «важная».
  void toggleImportant(int id) {
    final updated = state.notes
        .map((n) => n.id == id ? n.copyWith(isImportant: !n.isImportant) : n)
        .toList();
    emit(state.copyWith(notes: updated));
  }

  /// Свайп вправо: снять статус «важная», если он установлен.
  /// Возвращает true, если статус действительно был снят
  /// (для отображения SnackBar в UI).
  bool restoreNormal(int id) {
    final note = state.notes.firstWhere((n) => n.id == id);
    if (!note.isImportant) return false;

    final updated =
        state.notes.map((n) => n.id == id ? n.copyWith(isImportant: false) : n).toList();
    emit(state.copyWith(notes: updated));
    return true;
  }
}