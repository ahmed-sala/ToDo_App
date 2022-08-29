import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_app/database/task.dart';
import 'package:todo_app/date_utils.dart';
import 'package:todo_app/extention/date.dart';

class MyDatabase {
  static CollectionReference<Task> getTasksCollection() {
    return FirebaseFirestore.instance
        .collection(Task.collectionName)
        .withConverter<Task>(fromFirestore: (snapshot, options) {
      return Task.fromFirestore(snapshot.data()!);
    }, toFirestore: (task, options) {
      return task.toFirestore();
    });
  }

  static Future<void> insertTask(Task task) {
    var tasksCollection = getTasksCollection();
    var taskDoc = tasksCollection.doc(); //create new doc
    task.id = taskDoc.id;
    return taskDoc.set(task);
  }

  static Future<QuerySnapshot<Task>> getAllTasks(DateTime selectedDate) async {
    //read data once
    return await getTasksCollection()
        .where('dateTime',
            isEqualTo: dateOnly(selectedDate).millisecondsSinceEpoch)
        .get();
  }

  static Stream<QuerySnapshot<Task>> listenForTasksRealTimeUpdate(
      DateTime selectedDate) {
    // listen for real time update
    return getTasksCollection()
        .where(
          'dateTime',
          isEqualTo: dateOnly(selectedDate).millisecondsSinceEpoch,
        )
        .snapshots();
  }

  static Future<void> deleteTask(Task task) {
    var doc = getTasksCollection().doc(task.id);
    return doc.delete();
  }

  static editIsDone(Task task) {
    var taskRef = MyDatabase.getTasksCollection();
    taskRef.doc(task.id).update({
      'isDone': !task.isDone!,
    });
  }

  static Future<void> editTaskDetails(Task task) {
    var toDoRef = getTasksCollection();
    return toDoRef.doc(task.id).update({
      'title': task.title,
      'desc': task.desc,
       'dateTime':dateOnly( task.dateTime!).millisecondsSinceEpoch,
    });
  }
}
