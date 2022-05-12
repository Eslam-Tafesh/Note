import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../widget/ModalBottomSheet.dart';
import '../widget/note_card_widget.dart';
import '../db/notes_database.dart';
import '../model/note.dart';
import '../widget/note_form_widget.dart';

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
  late int? id;
  late int color;
  late String title;
  late String description;
  late bool check_cond_title_app;
  @override
  void initState() {
    super.initState();

    id = widget.note?.id;
    color = widget.note?.color ?? 0;
    title = widget.note?.title ?? '';
    description = widget.note?.description ?? '';
    check_cond_title_app = title.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: Colors.white,
        appBar: AppBar(
          title:  check_cond_title_app ? Text("Edit Note") : Text("New Note"),
          backgroundColor: check_cond_title_app? Colors.blue.shade400 : Colors.blue.shade900,
          actions: [buildButton()],
        ),
        body: Form(
          key: _formKey,
          child: NoteFormWidget(
            color: color,
            title: title,
            description: description,
            createdTime: DateFormat.yMMMd().format(widget.note?.createdTime != null ? widget.note!.createdTime :DateTime.now()).toString(),


            onChangedColor: (color) => setState(() => this.color = color),
            onChangedTitle: (title) => setState(() => this.title = title),
            onChangedDescription: (description) =>setState(() => this.description = description),
          ),
        ),
      );

  Widget buildButton() {
    final isFormValid = title.isNotEmpty && description.isNotEmpty;

    return Row(
      children: [

        IconButton(
          icon: Icon(Icons.more_vert_outlined),
          onPressed: () async {
            showModalBottomSheet(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(30),
                  ),
                ),
              backgroundColor: Colors.blue,
            context: context,
            builder: (builder) {
            return Modal_Bottom_Sheet(
              onChangedColor: (color) => setState(() => this.color = color),
              id: id,
              isValid: isFormValid,
              condition:check_cond_title_app,
              title:title,
              description:description,
              color: color,
            );
            }
        );}),

        Padding(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: Container(
            width: 50,
            height: 50,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                onPrimary: Colors.white,
                primary: isFormValid ? null : Colors.grey.shade700,
              ),
              onPressed: addOrUpdateNote,
              child: Icon(Icons.check_outlined),
            ),
          ),
        )
      ],
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
      color: color,
      title: title,
      description: description,
      createdTime: DateTime.now()
    );

    await NotesDatabase.instance.update(note);
  }

  Future addNote() async {
    final note = Note(
      title: title,
      color: color,
      description: description,
      createdTime: DateTime.now(),
    );

    await NotesDatabase.instance.create(note);
  }
}
