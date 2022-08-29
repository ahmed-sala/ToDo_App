import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_app/database/task.dart';

class Task {
  static const String collectionName = 'tasks';
  String? id;
  String? title;
  String? desc;
  DateTime? dateTime;

  bool? isDone;
  Task({this.id, this.title, this.desc, this.dateTime, this.isDone});
  Task.fromFirestore(Map<String, dynamic> data)
      : this(
            id: data['id'],
            title: data['title'],
            desc: data['desc'],
            dateTime: DateTime.fromMillisecondsSinceEpoch(data['dateTime']),
            isDone: data['isDone']);
  Map<String, dynamic> toFirestore() {
    return {
      'id': id,
      'title': title,
      'desc': desc,
      'dateTime': dateTime?.millisecondsSinceEpoch,
      'isDone': isDone
    };
  }

}
