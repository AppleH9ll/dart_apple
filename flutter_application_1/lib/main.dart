import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubit/note.dart';
import 'cubit/notes_cubit.dart';
import 'cubit/notes_state.dart';

void main() {
  runApp(const NotesApp());
}

class NotesApp extends StatelessWidget {
  const NotesApp({super.key});

  @override
  Widget build(BuildContext context) {
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

  //Действия через Cubit

  void _onSave() {
    context.read<NotesCubit>().saveNote(_controller.text);
    _controller.clear();
  }

  void _onStartEdit(Note note) {
    _controller.text = note.text;
    _controller.selection =
        TextSelection.collapsed(offset: note.text.length);
    context.read<NotesCubit>().startEditing(note.id);
  }

  void _onCancel() {
    context.read<NotesCubit>().cancelEditing();
    _controller.clear();
  }

  void _onDoubleTap(Note note) {
    context.read<NotesCubit>().toggleImportant(note.id);
    _showSnackBar(
      note.isImportant
          ? 'Статус «важная» снят'
          : 'Заметка отмечена как важная ⭐️',
    );
  }

  void _onSwipeRight(Note note) {
    final changed = context.read<NotesCubit>().restoreNormal(note.id);
    _showSnackBar(
      changed
          ? 'Статус «важная» снят'
          : 'Заметка уже имеет обычный статус',
    );
  }

  void _showNoteDialog(Note note) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            if (note.isImportant) ...[
              const Icon(Icons.star, color: Colors.amber),
              const SizedBox(width: 8),
            ],
            const Text('Заметка'),
          ],
        ),
        content: SingleChildScrollView(
          child: Text(note.text, style: const TextStyle(fontSize: 16)),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Закрыть'),
          ),
        ],
      ),
    );
  }

  void _showSnackBar(String text) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(
        duration: const Duration(milliseconds: 900),
        content: Text(text),
      ));
  }

  //UI

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
                // Подсказка по жестам
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.indigo.shade50,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Text(
                    'Тап — открыть • Двойной тап — ⭐️ важная\n'
                    'Долгое нажатие — редактировать\n'
                    'Свайп влево — удалить • Свайп вправо — снять ⭐️',
                    style: TextStyle(fontSize: 12),
                  ),
                ),
                const SizedBox(height: 12),

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

                // Кнопки
                Row(
                  children: [
                    Expanded(
                      child: FilledButton.icon(
                        onPressed: _onSave,
                        icon: Icon(
                            state.isEditing ? Icons.check : Icons.save),
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

                            return Dismissible(
                              key: ValueKey(note.id),
                              direction: DismissDirection.horizontal,

                              // Фон свайпа ВПРАВО
                              background: Container(
                                margin:
                                    const EdgeInsets.only(bottom: 8),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20),
                                alignment: Alignment.centerLeft,
                                decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius:
                                      BorderRadius.circular(12),
                                ),
                                child: const Row(
                                  children: [
                                    Icon(Icons.star_border,
                                        color: Colors.white),
                                    SizedBox(width: 8),
                                    Text('Снять «важную»',
                                        style: TextStyle(
                                            color: Colors.white)),
                                  ],
                                ),
                              ),

                              // Фон свайпа ВЛЕВО
                              secondaryBackground: Container(
                                margin:
                                    const EdgeInsets.only(bottom: 8),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20),
                                alignment: Alignment.centerRight,
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius:
                                      BorderRadius.circular(12),
                                ),
                                child: const Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.end,
                                  children: [
                                    Text('Удалить',
                                        style: TextStyle(
                                            color: Colors.white)),
                                    SizedBox(width: 8),
                                    Icon(Icons.delete,
                                        color: Colors.white),
                                  ],
                                ),
                              ),

                              // Свайп вправо — снять ⭐️; влево — удалить
                              confirmDismiss: (direction) async {
                                if (direction ==
                                    DismissDirection.startToEnd) {
                                  _onSwipeRight(note);
                                  return false; // карточка возвращается
                                }
                                return true; // влево — удаляем
                              },
                              onDismissed: (_) => context
                                  .read<NotesCubit>()
                                  .deleteNote(note.id),

                              // Жесты на самой карточке
                              child: GestureDetector(
                                onTap: () => _showNoteDialog(note),
                                onDoubleTap: () => _onDoubleTap(note),
                                onLongPress: () => _onStartEdit(note),
                                child: Card(
                                  margin: const EdgeInsets.only(bottom: 8),
                                  color: note.isImportant
                                      ? Colors.amber.shade100
                                      : null,
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(12),
                                    side: note.isImportant
                                        ? BorderSide(
                                            color:
                                                Colors.amber.shade700,
                                            width: 2,
                                          )
                                        : BorderSide.none,
                                  ),
                                  child: ListTile(
                                    leading: CircleAvatar(
                                      child: Text('${index + 1}'),
                                    ),
                                    title: Row(
                                      children: [
                                        if (note.isImportant) ...[
                                          const Text('⭐️ '),
                                        ],
                                        Expanded(
                                          child: Text(
                                            note.text,
                                            maxLines: 2,
                                            overflow:
                                                TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
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