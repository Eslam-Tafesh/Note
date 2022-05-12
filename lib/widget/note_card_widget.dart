import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../model/note.dart';

final _lightColors = [
  Colors.amber.shade300,
  Colors.lightGreen.shade300,
  Colors.lightBlue.shade300,
  Colors.orange.shade300,
  Colors.pinkAccent.shade100,
  Colors.tealAccent.shade100
];
git add .
final colors_DB = [
  0xff1321E0,
  0xffFFFFFF,
  0xffF28B81,
  0xffF7BD02,
  0xffFBF476,
  0xffCDFF90,
  0xffA7FEEB,
  0xffCBF0F8,
  0xffAFCBFA,
  0xffD7AEFC,
  0xffFBCFE9,
  0xffE6C9A9,
  0xffE9EAEE,

];

class NoteCardWidget extends StatelessWidget {
  NoteCardWidget({
    Key? key,
    required this.note,
    required this.index,
  }) : super(key: key);

  final Note note;
  final int index;

  @override
  Widget build(BuildContext context) {
    /// Pick colors from the accent colors based on index
    final color = _lightColors[index % _lightColors.length];
    final time = DateFormat.yMMMd().format(note.createdTime);

    return ClipRRect(

      borderRadius: BorderRadius.circular(20.0),
      child: Card(
        elevation: 5,
        child: Container(

          decoration: BoxDecoration(
            border: Border(
              left: BorderSide(width: 8.0, color: Color(colors_DB[note.color])),
            ),

          ),

          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.85,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                  note.title
                  ,style: TextStyle(fontSize: 18,color: Colors.blue,fontWeight: FontWeight.bold,fontFamily: "OpenSans"),),
                ),
              )
              ,
              Container(
                width: MediaQuery.of(context).size.width * 0.85,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                  note.description
                  ,style: TextStyle(fontSize: 14,color: Colors.black,fontFamily: "OpenSans")),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


}
