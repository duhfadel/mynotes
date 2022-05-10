import 'package:cloud_firestore/cloud_firestore.dart';

class Note {
  String title;
  String description;
  DateTime time;
  String? id;

  Note({required this.title, required this.description, DateTime? dateTime,})
      : time = dateTime ?? DateTime.now();

  Map<String, String> newNote = {};

  Note.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        description = json['description'],
        time = json['time'];

  Map<String, dynamic> toJson() =>
      {'title': title, 'description': description, 'time': time};

//PAY ATTENTION TO TRANSFORM OBJECT INTO ANOTHER TYPE
  factory Note.fromSnapshot(QueryDocumentSnapshot<Object?> snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    return Note(
        title: data['title'],
        description: data['description'] ?? '',
        dateTime: DateTime.fromMillisecondsSinceEpoch((data['time'] as Timestamp).millisecondsSinceEpoch));
  }
}
