import 'package:flutter/material.dart';
import 'package:sqflite_database_example/db/notes_database.dart';
import 'package:sqflite_database_example/model/note.dart';
import 'package:sqflite_database_example/widget/note_form_widget.dart';

class AddEditNotePage extends StatefulWidget {
  final Note? note;

  const AddEditNotePage({
    Key? key,
    this.note,
  }) : super(key: key);
  @override
  _AddEditNotePageState createState() => _AddEditNotePageState();
}

class _AddEditNotePageState extends State<AddEditNotePage> {
  final _formKey = GlobalKey<FormState>();
  late bool isImportant;
  late int number;
  late String won;
  late String lost;
  late String title;
  

  @override
  void initState() {
    super.initState();

    isImportant = widget.note?.isImportant ?? false;
    number = widget.note?.number ?? 0;
    won = widget.note?.won ?? '';
    lost = widget.note?.lost ?? '';
    title = widget.note?.title ?? '';
    
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          actions: [buildButton()],
        ),
        body: Form(
          key: _formKey,
          child: NoteFormWidget(
            isImportant: isImportant,
            number: number,
            won: won,
            lost: lost,
            title: title,
            onChangedImportant: (isImportant) =>
                setState(() => this.isImportant = isImportant),
            onChangedNumber: (number) => setState(() => this.number = number),
            onChangedWon: (won) => setState(() => this.won = won),
            onChangedLost: (lost) => setState(() => this.lost = lost),
            onChangedTitle: (title) => setState(() => this.title = title),
            
          ),
        ),
      );

  Widget buildButton() {
    final isFormValid = title.isNotEmpty && won.isNotEmpty;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          onPrimary: Colors.white,
          primary: isFormValid ? null : Colors.grey.shade700,
        ),
        onPressed: addOrUpdateNote,
        child: Text('Save'),
      ),
    );
  }

  void addOrUpdateNote() async {
    final isValid = _formKey.currentState!.validate();

    if (isValid) {
      final isUpdating = widget.note != null;

      if (isUpdating) {
        await updateNote();
      } else {
        await addNote();
      }

      Navigator.of(context).pop();
    }
  }

  Future updateNote() async {
    final note = widget.note!.copy(
      isImportant: isImportant,
      number: number,
      won: won,
      lost: lost,
      title: title,
      
    );

    await NotesDatabase.instance.update(note);
  }

  Future addNote() async {
    final note = Note(
      isImportant: true,
      number: number,
      won: won,
      lost: lost,
      title: title,
      createdTime: DateTime.now(),
    );

    await NotesDatabase.instance.create(note);
  }
}
