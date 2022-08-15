import 'package:flutter/material.dart';

class BottomSheetWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(18),
      child: Column(
        children: [
          Text(
            'Add new task',
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(color: Colors.black),
          ),
          Form(child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'enter your task',
                  labelStyle: TextStyle(
                    fontSize: 14
                  ),
                ),
              ),
              TextFormField(
              maxLines: 5,
                minLines: 5,
                decoration: InputDecoration(
                  hintMaxLines: 5,
                  labelText: 'describtion',
                  labelStyle: TextStyle(
                      fontSize: 14
                  ),
                ),
              ),

              ElevatedButton(onPressed: (){}, child: Text('Add'))
            ],
          ),)
        ],
      ),
    );
  }
}
