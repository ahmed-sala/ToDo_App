import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/Provider/app_provider.dart';
import 'package:todo_app/Provider/taskProvider.dart';
import 'package:todo_app/database/my_database.dart';
import 'package:todo_app/database/task.dart';
import 'package:todo_app/date_utils.dart';
import 'package:todo_app/home/home_screen.dart';
import 'package:todo_app/loadingAndMassege.dart';
import 'package:todo_app/my_theme.dart';
import 'package:todo_app/selectDate.dart';
import 'package:todo_app/extention/date.dart';

class EditTaskScreen extends StatefulWidget {
  static const String routeName = 'edit';
  Task task;

  EditTaskScreen(this.task);

  @override
  State<EditTaskScreen> createState() => _EditTaskScreenState();
}

late TaskProvider taskProvider;

class _EditTaskScreenState extends State<EditTaskScreen> {
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppProvider>(context);
    // taskProvider = Provider.of<TaskProvider>(context);
    Size size = MediaQuery.of(context).size;
    //
    // titleController = TextEditingController();
    // descController = TextEditingController();
    // selectedDate=task.dateTime!;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          'ToDo List',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                height: size.height * 0.1,
                color: Theme.of(context).primaryColor,
              ),
              Center(
                child: Container(
                  padding: EdgeInsets.all(20),
                  height: size.height * 0.7,
                  width: size.width * 0.85,
                  margin: EdgeInsets.only(top: size.height * .04),
                  decoration: BoxDecoration(
                      border: Border.all(color: MyTheme.lightPrimary),
                      color: provider.isDark()
                          ? MyTheme.darkScafoldBackground
                          : Colors.white,
                      borderRadius: BorderRadius.circular(30)),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'Edit Task',
                          textAlign: TextAlign.center,
                          style:
                              Theme.of(context).textTheme.titleMedium!.copyWith(
                                    color: provider.isDark()
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        TextFormField(
                          initialValue: widget.task.title,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(
                                  color: provider.isDark()
                                      ? Colors.white
                                      : Colors.black,
                                  fontSize: 20),
                          decoration: InputDecoration(
                            labelText: 'title',
                          ),
                          onChanged: (String? value) {
                            widget.task.title = value;
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          initialValue: widget.task.desc,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(
                                  color: provider.isDark()
                                      ? Colors.white
                                      : Colors.black,
                                  fontSize: 20),
                          decoration: InputDecoration(
                            labelText: 'description',
                          ),
                          onChanged: (String? value) {
                            widget.task.desc = value;
                          },
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Text(
                          'Select Date',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(
                                  color: provider.isDark()
                                      ? Colors.white
                                      : Colors.black,
                                  fontSize: 20),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        InkWell(
                          onTap: () {
                            showDateDialoge();
                          },
                          child: Center(
                            child: Text(
                              // '${dateOnly(widget.task.dateTime!)}',
                               '${selectedDate.year}/${selectedDate.month}/${selectedDate.day}',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ),
                        ),
                        Spacer(),
                        Container(
                          margin: EdgeInsets.only(bottom: 80),
                          child: MaterialButton(
                            onPressed: () {
                              editTask();
                            },
                            minWidth: 255,
                            height: 55,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25)),
                            child: Text(
                              'Save Changes',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(color: Colors.white),
                            ),
                            color: Theme.of(context).primaryColor,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  DateTime selectedDate = DateTime.now();

  void showDateDialoge() async {
    var date = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365)));
    if (date != null) {
      setState(() {
        selectedDate = date;
        widget.task.dateTime=selectedDate;
      });
    }
  }

  void editTask() async {

    Navigator.pop(context);
    await MyDatabase.editTaskDetails(widget.task);


  }
}

