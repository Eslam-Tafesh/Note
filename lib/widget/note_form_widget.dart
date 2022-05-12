import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NoteFormWidget extends StatelessWidget {
  final int? color;
  final String? title;
  final String? description;
  final String createdTime;
  final ValueChanged<int> onChangedColor;
  final ValueChanged<String> onChangedTitle;
  final ValueChanged<String> onChangedDescription;


  const NoteFormWidget({
    Key? key,
    this.color = 0,
    this.title = '',
    this.description = '',
    this.createdTime = '',
    required this.onChangedColor,
    required this.onChangedTitle,
    required this.onChangedDescription,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
    color: Colors.white,
    child: SingleChildScrollView(

          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 8),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Text(
                    "$createdTime",
                    style: TextStyle(color: Colors.grey),
                    textAlign: TextAlign.left,
                  ),
                ),
                SizedBox(height: 16),
                buildTitle(),
                SizedBox(height: 4),
                buildDescription(),
                SizedBox(height: 16),
              ],
            ),
          ),
        ),
  );

  Widget buildTitle() => TextFormField(
        maxLines: 1,
        initialValue: title,
        style: TextStyle(
          color: Colors.black54,
          fontWeight: FontWeight.bold,
          fontSize: 24,
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: 'Title',
          hintStyle: TextStyle(color: Colors.black54),
        ),
        validator: (title) =>
            title != null && title.isEmpty ? 'The title cannot be empty' : null,
        onChanged: onChangedTitle,
      );

  Widget buildDescription() => TextFormField(
        maxLines: 5,
        initialValue: description,
        style: TextStyle(color: Colors.black54, fontSize: 18),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: 'Type something...',
          hintStyle: TextStyle(color: Colors.black54),
        ),
        validator: (title) => title != null && title.isEmpty
            ? 'The description cannot be empty'
            : null,
        onChanged: onChangedDescription,
      );
}
