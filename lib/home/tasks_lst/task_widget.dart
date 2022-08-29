import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/Provider/app_provider.dart';
import 'package:todo_app/database/my_database.dart';
import 'package:todo_app/database/task.dart';
import 'package:todo_app/loadingAndMassege.dart';
import 'package:todo_app/home/edit_task/editTaskScreen.dart';
import 'package:todo_app/home/tasks_lst/task_widget.dart';
import 'package:todo_app/my_theme.dart';

class TaskWidget extends StatefulWidget {
  Task task;
  TaskWidget(this.task);

  @override
  State<TaskWidget> createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  @override
  Widget build(BuildContext context) {
    var provider=Provider.of<AppProvider>(context);
    return InkWell(
      onTap: (){
        Navigator.push(context,
            MaterialPageRoute(
          builder: (context)=> EditTaskScreen(widget.task),
        ));
      },
      child: Container(
        margin: EdgeInsets.all(8),
        child: Slidable(
          startActionPane: ActionPane(
            motion: DrawerMotion(),
            children: [
              SlidableAction(
                onPressed: (_) {
                  MyDatabase.deleteTask(widget.task).then((value) {
                     showMassege(context, 'Task deleted successfully',
                        posActionName: 'Ok');
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
                color: provider.isDark()?Colors.black:Colors.white, borderRadius: BorderRadius.circular(12)),
            padding: EdgeInsets.all(24),
            child: Row(
              children: [
                Container(
                  width: 4,
                  height: 62,
                  decoration: BoxDecoration(
                      color:widget.task.isDone!?MyTheme.green :Theme.of(context).primaryColor,
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
                        widget.task.title ?? "",
                        style:widget.task.isDone!?Theme.of(context).textTheme.titleMedium!.copyWith(color: MyTheme.green)
                            :Theme.of(context).textTheme.titleMedium,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        children: [
                          Text(
                            '${widget.task.desc}' ,
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: (){
                    editIsDone();
                    widget.task.isDone=!widget.task.isDone!;
                  },
                  child:
                  widget.task.isDone!?   Text('Done!',style: TextStyle(
                    color: MyTheme.green,
                    fontWeight: FontWeight.bold,
                    fontSize: 22
                  ),)
                      :
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void editIsDone(){
  var taskRef = MyDatabase.getTasksCollection();
  taskRef.doc(widget.task.id).update({
    'isDone':!widget.task.isDone!,
  });
  }
}
