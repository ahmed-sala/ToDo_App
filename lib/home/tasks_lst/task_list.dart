import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/Provider/app_provider.dart';
import 'package:todo_app/Provider/taskProvider.dart';
import 'package:todo_app/database/my_database.dart';
import 'package:todo_app/database/task.dart';
import 'package:todo_app/home/tasks_lst/task_widget.dart';

class TaskListTab extends StatefulWidget {
  @override
  State<TaskListTab> createState() => _TaskListTabState();
}

class _TaskListTabState extends State<TaskListTab> {
  DateTime selectedDate = DateTime.now();
  late TaskProvider taskProvider;
  @override
  void initState(){
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      taskProvider.refreshTasks(selectedDate);
    });
  }

  @override
  Widget build(BuildContext context) {
     taskProvider=Provider.of<TaskProvider>(context);
    var provider=Provider.of<AppProvider>(context);
    return Container(
      child: Column(
        children: [
          CalendarTimeline(
            initialDate: selectedDate,
            firstDate: DateTime.now().subtract(Duration(days: 365)),
            lastDate: DateTime.now().add(Duration(days: 365)),
            onDateSelected: (date) {
              if (date == null) return;
              setState(() {
                selectedDate = date;
                taskProvider.refreshTasks(selectedDate);
              });
              // on user choose new date
            },
            leftMargin: 20,
            monthColor: provider.isDark()?Colors.white:Colors.black,
            dayColor: provider.isDark()?Colors.white:Colors.black,
            activeDayColor: Theme.of(context).primaryColor,
            activeBackgroundDayColor: provider.isDark()?Colors.black:Colors.white,
            dotsColor: Theme.of(context).primaryColor,
            selectableDayPredicate: (date) => true,
            locale: 'en',
          ),
          Expanded(
            child: ListView.builder(
                  itemBuilder: (buldContext, index) {
                    return TaskWidget(taskProvider.tasks[index]);
                  },
                  itemCount: taskProvider.tasks.length,
                )

            ),

        ],
      ),
    );
  }
}
