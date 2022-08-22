import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo_app/database/my_database.dart';
import 'package:todo_app/database/task.dart';
import 'package:todo_app/diaogeUtlis.dart';
import 'package:todo_app/home/tasks_lst/task_widget.dart';
import 'package:todo_app/my_theme.dart';

class TaskWidget extends StatelessWidget {
  Task task;
  TaskWidget(this.task);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8),
      child: Slidable(
        startActionPane: ActionPane(
          motion: DrawerMotion(),
          children: [
            SlidableAction(
              onPressed: (_) {
                MyDatabase.deleteTask(task).then((value) {
                  // showMassege(context, 'Task deleted successfully',
                  //     posActionName: 'Ok');
                  print('done');
                }).onError((error, stackTrace) {
                  showMassege(
                      context,
                      'Something went wrong,'
                      'Please try again later',
                      posActionName: 'Ok');
                }).timeout(Duration(seconds: 5), onTimeout: () {
                  showMassege(context, 'Data delete locally',
                      posActionName: 'Ok');
                });
              },
              icon: Icons.delete,
              backgroundColor: MyTheme.red,
              label: 'Delete',
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  bottomLeft: Radius.circular(12)),
            ),
          ],
        ),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(12)),
          padding: EdgeInsets.all(24),
          child: Row(
            children: [
              Container(
                width: 4,
                height: 62,
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(12)),
              ),
              SizedBox(
                width: 15,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      task.title ?? "",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        Text(
                          task.desc ?? "",
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 24),
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(10)),
                child: Icon(
                  Icons.check,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
