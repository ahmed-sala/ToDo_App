import 'package:flutter/material.dart';
import 'package:todo_app/database/my_database.dart';
import 'package:todo_app/database/task.dart';
import 'package:todo_app/date_utils.dart';
import 'package:todo_app/diaogeUtlis.dart';

class BottomSheetWidget extends StatefulWidget {
  @override
  State<BottomSheetWidget> createState() => _BottomSheetWidgetState();
}

class _BottomSheetWidgetState extends State<BottomSheetWidget> {
  var formKey=GlobalKey<FormState>();
  var titleController=TextEditingController();
  var descController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height*.7,
      padding: const EdgeInsets.all(12),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Add New Task',textAlign: TextAlign.center,style: Theme.of(context).textTheme.titleMedium,),
            TextFormField(
              controller: titleController,
              validator: (text){
                if (text==null||text.trim().isEmpty){
                  return'please enter title';
                }
                return null;
              },
              decoration: InputDecoration(
                labelText: 'Title',
              ),
            ),
            SizedBox(height: 12,),
            TextFormField(
              controller: descController,
              validator: (text){
                if (text==null||text.trim().isEmpty){
                  return'please enter description';
                }
                 return null;
              },
              style: Theme.of(context).textTheme.titleSmall,
              minLines: 4,
              maxLines: 4,
              decoration: InputDecoration(
                labelText: 'Description',
              ),
            ),
            SizedBox(height: 12,),
            Text('Select Date',style: Theme.of(context).textTheme.titleMedium),
            InkWell(
              onTap: (){
                showDateDialoge();
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text('${selectedDate.year}/${selectedDate.month}/${selectedDate.day}',style: Theme.of(context).textTheme.titleSmall),
              ),
            ),
            ElevatedButton(onPressed: (){
              addTask();
            }, child: Text('Add')),
          ],
        ),
      ),
    );
  }

  void addTask(){
    if(formKey.currentState?.validate()==true){
      String title=titleController.text;
      String desc=descController.text;
    Task task=Task(title: title,
        desc: desc,
        dateTime: dateOnly(selectedDate),
        isDone: false);
      showLoading(context, 'Loading....');
    MyDatabase.insertTask(task).then((value) {
      hideLoading(context);
      //called when future is completed
      showMassege(context, 'Task Added Successfully',posActionName: 'Ok',posAction: (){
        Navigator.pop(context);
      });
    }).
    onError((error, stackTrace) {
      //called when future fail
      hideLoading(context);

      showMassege(context, 'Something went wrong, try again later',posActionName: 'Ok',posAction: (){
        Navigator.pop(context);
      });
    })
      .timeout(Duration(seconds: 5),
        onTimeout:(){
          hideLoading(context);

          //save change in cache
          showMassege(context, 'Task saved locally',posActionName: 'Ok',posAction: (){
            Navigator.pop(context);
          });
        });
    }
  }
  DateTime selectedDate=DateTime.now();
  void showDateDialoge()async{
    DateTime? date= await showDatePicker(context: context,
        initialDate: selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365)));
    if(date!=null){
      selectedDate=date;
      setState((){});
    }
  }

  void showLoading(BuildContext context, String loadingMassege,
      {bool isCancelable = true}) {
    showDialog(
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
}
