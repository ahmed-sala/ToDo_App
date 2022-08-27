import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/Provider/app_provider.dart';
import 'package:todo_app/database/my_database.dart';
import 'package:todo_app/database/task.dart';
import 'package:todo_app/date_utils.dart';
import 'package:todo_app/home/home_screen.dart';
import 'package:todo_app/loadingAndMassege.dart';
import 'package:todo_app/my_theme.dart';
import 'package:todo_app/selectDate.dart';


class EditTaskScreen extends StatefulWidget {
  static const String routeName = 'edit';
  @override
  State<EditTaskScreen> createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  var formKey = GlobalKey<FormState>();
  late TextEditingController titleController ;
  late TextEditingController descController ;
  late DateTime selectedDate ;


  late Task task;
  @override
  Widget build(BuildContext context) {

    var provider = Provider.of<AppProvider>(context);
    Size size = MediaQuery.of(context).size;
    task=ModalRoute.of(context)!.settings.arguments as Task;

    titleController = TextEditingController(text: task.title);
    descController = TextEditingController(text: task.desc);
    selectedDate=task.dateTime!;

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
                      color: provider.isDark()?MyTheme.darkScafoldBackground:Colors.white,
                      borderRadius: BorderRadius.circular(30)),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'Edit Task',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        SizedBox(height: 10,),
                        Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: MyTheme.lightPrimary)),
                          child: TextFormField(
                            controller: titleController,
                            validator: (text) {
                              if (text == null || text.trim().isEmpty) {
                                return 'please enter title';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                labelText: 'Title',
                                labelStyle: TextStyle(
                                    color: provider.isDark()
                                        ? Colors.white54
                                        : Colors.grey)),
                          ),
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: MyTheme.lightPrimary)),
                          child: TextFormField(
                            controller: descController,
                            validator: (text) {
                              if (text == null || text.trim().isEmpty) {
                                return 'please enter description';
                              }
                              return null;
                            },
                            style: Theme.of(context).textTheme.titleSmall,
                            minLines: 4,
                            maxLines: 4,
                            decoration: InputDecoration(
                              labelText: 'Description',
                              labelStyle: TextStyle(
                                  color: provider.isDark()
                                      ? Colors.white54
                                      : Colors.grey),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Text('Select Date',
                            style: Theme.of(context).textTheme.titleMedium),
                        DateWidget(selectedDate),
                        ElevatedButton(
                            onPressed: () {
                              editTask();
                              Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
                            },
                            child: Text('Add')),
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


  void editTask() {
    if(formKey.currentState?.validate()==true){
      String title=titleController.text;
      String desc=descController.text;
      Task editedTask=Task(
        id:task.id ,
        title: title,
          desc: desc,
          dateTime: dateOnly(selectedDate),
        isDone: task.isDone
          );
      showLoading(context, 'Loading....');
      var taskRef = MyDatabase.getTasksCollection();
      taskRef.doc(task.id).update(editedTask.toFirestore());
    }
  }
  void showLoading (BuildContext context, String loadingMassege,
      {bool isCancelable = true}) => showDialog(
      context: context,
      builder: (buildContext) {
        return AlertDialog(
          content: Row(
            children: [
              CircularProgressIndicator(),
              SizedBox(
                width: 12,
              ),
              Text(loadingMassege),
            ],
          ),
        );
      },barrierDismissible: isCancelable);
}

