import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubit/notes_cubit.dart';
import 'cubit/notes_state.dart';

void main() {
  runApp(const NotesApp());
}

class NotesApp extends StatelessWidget {
  const NotesApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Аналог схемы из лекции: BlocProvider → MaterialApp
    return BlocProvider(
      create: (_) => NotesCubit(),
      child: MaterialApp(
        title: 'Заметки',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
          useMaterial3: true,
        ),
        home: const NotesScreen(),
      ),
    );
  }
}

class NotesScreen extends StatefulWidget {
  const NotesScreen({super.key});

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // Сохранение: Cubit сам разберётся — добавить или обновить
  void _onSave() {
    context.read<NotesCubit>().saveNote(_controller.text);
    _controller.clear();
  }

  // Переход в режим редактирования
  void _onStartEdit(String text, int index) {
    _controller.text = text;
    _controller.selection =
        TextSelection.collapsed(offset: text.length);
    context.read<NotesCubit>().startEditing(index);
  }

  // Отмена редактирования
  void _onCancel() {
    context.read<NotesCubit>().cancelEditing();
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Заметки'),
        centerTitle: true,
      ),
      body: BlocBuilder<NotesCubit, NotesState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // Поле ввода
                TextField(
                  controller: _controller,
                  minLines: 1,
                  maxLines: 3,
                  decoration: InputDecoration(
                    hintText: 'Введите текст заметки...',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 12),

                // Кнопки — зависят от state.isEditing
                Row(
                  children: [
                    Expanded(
                      child: FilledButton.icon(
                        onPressed: _onSave,
                        icon: Icon(state.isEditing
                            ? Icons.check
                            : Icons.save),
                        label: Text(state.isEditing
                            ? 'Сохранить изменения'
                            : 'Сохранить'),
                      ),
                    ),
                    if (state.isEditing) ...[
                      const SizedBox(width: 12),
                      OutlinedButton(
                        onPressed: _onCancel,
                        child: const Text('Отмена'),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 16),

                // Список заметок
                Expanded(
                  child: state.notes.isEmpty
                      ? const Center(
                          child: Text(
                            'Заметок пока нет',
                            style: TextStyle(
                                color: Colors.grey, fontSize: 16),
                          ),
                        )
                      : ListView.builder(
                          itemCount: state.notes.length,
                          itemBuilder: (context, index) {
                            final note = state.notes[index];
                            return Card(
                              margin: const EdgeInsets.only(bottom: 8),
                              child: ListTile(
                                leading: CircleAvatar(
                                    child: Text('${index + 1}')),
                                title: Text(note),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.edit,
                                          color: Colors.blue),
                                      tooltip: 'Редактировать',
                                      onPressed: () =>
                                          _onStartEdit(note, index),
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.delete,
                                          color: Colors.red),
                                      tooltip: 'Удалить',
                                      onPressed: () => context
                                          .read<NotesCubit>()
                                          .deleteNote(index),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}