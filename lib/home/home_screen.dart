import 'package:flutter/material.dart';
import 'package:todo_app/home/settings/settings_tab.dart';
import 'package:todo_app/home/tasks_lst/bottom_navigation.dart';
import 'package:todo_app/home/tasks_lst/task_list.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = 'home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabs[selectedIndex],
      appBar: AppBar(
        title: Text('To Do List'),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 8,
        child: BottomNavigationBar(
          currentIndex: selectedIndex,
          onTap: (index) {
            setState(() {
              selectedIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.list), label: ''),
            BottomNavigationBarItem(icon: Icon(Icons.settings), label: ''),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        shape: StadiumBorder(
          side: BorderSide(color: Colors.white, width: 5),
        ),
        onPressed: () {
          showBottomSheet();
        },
        child: Icon(Icons.add),
      ),
    );
  }
  void showBottomSheet(){
    showModalBottomSheet(context: context, builder: (_){
      return BottomSheetWidget();
    });
  }

  List<Widget> tabs = [TaskListTab(), Settings_tab()];
}
