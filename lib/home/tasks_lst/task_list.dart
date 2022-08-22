import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/database/my_database.dart';
import 'package:todo_app/database/task.dart';
import 'package:todo_app/home/tasks_lst/task_widget.dart';

class TaskListTab extends StatefulWidget {
  @override
  State<TaskListTab> createState() => _TaskListTabState();
}

class _TaskListTabState extends State<TaskListTab> {
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
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
              });
              // on user choose new date
            },
            leftMargin: 20,
            monthColor: Colors.black,
            dayColor: Colors.black,
            activeDayColor: Theme.of(context).primaryColor,
            activeBackgroundDayColor: Colors.white,
            dotsColor: Theme.of(context).primaryColor,
            selectableDayPredicate: (date) => true,
            locale: 'en_ISO',
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot<Task>>(
              //future: MyDatabase.getAllTasks(),
              stream: MyDatabase.listenForTasksRealTimeUpdate(selectedDate),
              builder: (buldContext, snapshot) {
                if (snapshot.hasError) {
                  return Text('Error loading dada,'
                      'please try again later');
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                var data = snapshot.data?.docs.map((e) => e.data()).toList();
                return ListView.builder(
                  itemBuilder: (buldContext, index) {
                    return TaskWidget(data![index]);
                  },
                  itemCount: data!.length,
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
