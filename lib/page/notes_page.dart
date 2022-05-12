import 'package:flutter/material.dart';
import '../db/notes_database.dart';
import'../model/note.dart';
import '../page/edit_note_page.dart';
import '../widget/note_card_widget.dart';

class NotesPage extends StatefulWidget {
  @override
  _NotesPageState createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  late List<Note> notes;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    refreshNotes();
  }

  @override
  void dispose() {
    NotesDatabase.instance.close();

    super.dispose();
  }

  Future refreshNotes() async {
    setState(() => isLoading = true);

    this.notes = await NotesDatabase.instance.readAllNotes();

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.blue.shade800,
          title: Center(
            child: Text(
              'MYNotes',
              style: TextStyle(fontSize: 24,),
            ),
          ),
        ),
        body: Center(
          child: isLoading
              ? CircularProgressIndicator()
              : notes.isEmpty
                  ? Column(
                      children: [
                        SizedBox(
                          height: 70,
                        ),
                        Image.asset("images/notes.png",width: 200,height: 200,),
                        SizedBox(
                          height: 60,
                        ),

                        Text("No Notes :(",style: TextStyle(fontSize: 24 , color: Color.fromARGB(255,85, 78, 143) , fontWeight: FontWeight.bold , fontFamily: "OpenSans"),),
                        SizedBox(
                          height: 20,
                        ),
                        Text("You have no task to do.",style: TextStyle(fontSize: 18 , color: Color.fromARGB(255,132, 161, 184) , fontWeight: FontWeight.bold , fontFamily: "OpenSans"),)

            ],
          )
                  : buildNotes(),
        ),
        floatingActionButton: FloatingActionButton(
          child: Container(
            width: 60,
            height: 60,
            child: Icon(
              Icons.add,
              size: 40,
            ),
            decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    stops: [
                      0.4,
                      1.0,
                    ],
                    colors: [  Color.fromARGB(255, 19, 33, 224) ,Colors.red]
                )
            ),
          ),
          onPressed: () async {
            await Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => AddEditNotePage()),
            );

            refreshNotes();
          },
        ),
      );

  Widget buildNotes() => ListView.builder(
        padding: EdgeInsets.all(8),
        itemCount: notes.length,
        itemBuilder: (context, index) {
          final note = notes[index];

          return GestureDetector(
            onTap: () async {
              await Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => AddEditNotePage(note: note),
              ));

              refreshNotes();
            },
            child: NoteCardWidget(note: note, index: index),
          );
        },
      );
}


