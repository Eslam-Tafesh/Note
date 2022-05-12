
import 'package:flutter/material.dart';
import 'package:note_2/db/notes_database.dart';
import 'package:note_2/model/note.dart';

import 'note_card_widget.dart';

class Modal_Bottom_Sheet extends StatefulWidget {

  int color;
  final int? id;
  final String title;
  final String description;
  final bool isValid;
  final bool condition;
  final ValueChanged<int> onChangedColor;

   Modal_Bottom_Sheet({
    Key? key,
    this.color = 0,
    this.id = 0,
    this.title="",
    this.description="",
     this.condition=false,
    this.isValid=false,
    required this.onChangedColor,
  }) : super(key: key);


  @override
  _Modal_Bottom_SheetState createState() => _Modal_Bottom_SheetState();
}

class _Modal_Bottom_SheetState extends State<Modal_Bottom_Sheet> {

  List<bool> _selected_color = List.generate(colors_DB.length, (i) => false);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    check_color_DB(widget.color);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ListView(
        children:  [
          SizedBox(
            height: 20,
          ),
          ListTile(

            leading: SizedBox(
              width: 40,
              height: 40,
              child: CircleAvatar(
                radius: 30,
                backgroundColor: Colors.grey.shade400,
                child: Icon(Icons.share,color: Colors.black54,),
              ),
            ),
            title: const Text('Share with your friends',style: TextStyle(color: Colors.white),textAlign: TextAlign.left,),
            onTap: () {
              // Update the state of the app.
              // ...
            },
          ),
          SizedBox(
            height: 12,
          ),
          ListTile(

            leading: SizedBox(
              width: 40,
              height: 40,
              child: CircleAvatar(
                radius: 30,
                backgroundColor: Colors.grey.shade400,
                child: Icon(Icons.delete,color: Colors.black54,),
              ),
            ),
            title: const Text('Delete',style: TextStyle(color: Colors.white),textAlign: TextAlign.left,),
            onTap: () async {
              if(widget.condition){
              await NotesDatabase.instance.delete(widget.id);
              }
              Navigator.of(context).pop();
              Navigator.of(context).pop();

            },
          ),
          SizedBox(
            height: 12,
          ),
          ListTile(

            leading: SizedBox(
              width: 40,
              height: 40,
              child: CircleAvatar(
                radius: 30,
                backgroundColor: Colors.grey.shade400,
                child: Icon(Icons.content_copy,color: Colors.black54,),
              ),
            ),
            title: const Text('Duplicate',style: TextStyle(color: Colors.white),textAlign: TextAlign.left,),
            onTap: () async {
              if (widget.isValid) {

                  await addNote();


                Navigator.of(context).pop();
              }
            },
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            height: 60.0,
            child: ListView.builder(

              itemCount: colors_DB.length,
              // This next line does the trick.
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(

                  onTap: () => setState(() {
                    widget.onChangedColor(index);
                    check_color(index);
                  } ),

                  child: Container(
                    margin: EdgeInsets.all(5),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50.0),
                      child: SizedBox(
                        width: 50,
                        child: Container(
                          color:Color(colors_DB[index]),
                          child: _selected_color[index] ? Icon(Icons.check_outlined) : Text(""),

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
  }
  void check_color (index){
    final List<bool> _selected_color2 = List.generate(colors_DB.length, (i) => false);
    _selected_color = _selected_color2;
    _selected_color[index] = true;
    widget.color=index;
  }
  void check_color_DB (color){
    final List<bool> _selected_color2 = List.generate(colors_DB.length, (i) => false);
    _selected_color = _selected_color2;
    _selected_color[color] = true;
  }

  Future addNote() async {
    final note = Note(
      title: widget.title,
      color: widget.color,
      description: widget.description,
      createdTime: DateTime.now(),
    );

    await NotesDatabase.instance.create(note);
  }
}



