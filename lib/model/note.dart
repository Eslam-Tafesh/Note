// the name of our table in the database;
final String tableNotes = 'notes';

// we need another class to defined our columns name at the database
class NoteFields {

  // Here we want to make the fields that below in one list
  static final List<String> values = [
    // Add all fields
    id, color, title, description, time,
  ];


  // don't forget the (_) this before the id
  // and all of them are strings because those are the name of the columns
  static final String id = '_id';
  static final String color = 'color';
  static final String title = 'title';
  static final String description = 'description';
  static final String time = 'time';

}

class Note {
  // the ? for the id to make it auto increment
  final int? id;
  final int color;
  final String title;
  final String description;
  final DateTime createdTime;

  const Note({
    this.id,
    required this.color,
    required this.title,
    required this.description,
    required this.createdTime,
});

  Note copy({
  int? id,
  int? color,
  String? title,
  String? description,
  DateTime? createdTime,

  }) =>
      Note(
        id :id?? this.id,
        color :color?? this.color,
        title :title?? this.title,
        description :description?? this.description,
        createdTime :createdTime?? this.createdTime,

      );

  static Note fromJson(Map<String,Object?> json) => Note(
    id: json[NoteFields.id] as int?,
    color: json[NoteFields.color] as int,
    title: json[NoteFields.title] as String,
    description: json[NoteFields.description] as String,
    createdTime: DateTime.parse(json[NoteFields.time] as String),
  );

  Map<String, Object?> toJson() => {
        NoteFields.id : id,
        NoteFields.color : color,
        NoteFields.title : title,
        NoteFields.description : description,
        NoteFields.time : createdTime.toIso8601String(),
  };

}