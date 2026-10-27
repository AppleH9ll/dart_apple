import 'package:flutter_bloc/flutter_bloc.dart';
import 'notes_state.dart';

class NotesCubit extends Cubit<NotesState> {
  NotesCubit() : super(const NotesState());

  /// Единая точка сохранения — сама определяет,
  /// добавить новую заметку или обновить существующую.
  void saveNote(String text) {
    final trimmed = text.trim();
    if (trimmed.isEmpty) return; // пустые заметки не сохраняем

    if (state.isEditing) {
      _updateNote(trimmed);
    } else {
      _addNote(trimmed);
    }
  }

  void _addNote(String text) {
    emit(state.copyWith(notes: [...state.notes, text]));
  }

  void _updateNote(String text) {
    final updated = List<String>.from(state.notes);
    updated[state.editingIndex!] = text;
    emit(state.copyWith(notes: updated, clearEditing: true));
  }

  /// Включить режим редактирования для заметки с указанным индексом.
  void startEditing(int index) {
    if (index < 0 || index >= state.notes.length) return;
    emit(state.copyWith(editingIndex: index));
  }

  /// Отменить редактирование.
  void cancelEditing() {
    emit(state.copyWith(clearEditing: true));
  }

  /// Удалить заметку. При необходимости — скорректировать индекс редактирования.
  void deleteNote(int index) {
    if (index < 0 || index >= state.notes.length) return;

    final updated = List<String>.from(state.notes)..removeAt(index);

    int? newEditing = state.editingIndex;
    if (newEditing == index) {
      newEditing = null; // удалили редактируемую — выходим из режима
    } else if (newEditing != null && newEditing > index) {
      newEditing = newEditing - 1; // индекс сдвинулся после удаления
    }

    emit(NotesState(notes: updated, editingIndex: newEditing));
  }
}