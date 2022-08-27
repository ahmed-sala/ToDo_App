import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/Provider/app_provider.dart';
import 'package:todo_app/my_theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ThemeBottomSheet extends StatefulWidget {
  @override
  State<ThemeBottomSheet> createState() => _ThemeBottomSheetState();
}

class _ThemeBottomSheetState extends State<ThemeBottomSheet> {
  @override
  Widget build(BuildContext context) {
    var provider=Provider.of<AppProvider>(context);
    return Container(
      padding: EdgeInsets.all(30),
      child: Column(
        children: [
          InkWell(
            onTap: (){
              provider.changeTheme(ThemeMode.light);
            },
            child: Container(

              child: provider.isDark()?getUnSelectedItem(AppLocalizations.of(context)!.light):
              getSelectedItem(AppLocalizations.of(context)!.light)
            ),
          ),
          SizedBox(height: 20,),
          InkWell(
            onTap: (){
              provider.changeTheme(ThemeMode.dark);

            },
            child: Container(

              child:provider.isDark()?getSelectedItem(AppLocalizations.of(context)!.dark):
              getUnSelectedItem(AppLocalizations.of(context)!.dark)
            ),
          ),
        ],
      ),
    );
  }

  Widget getSelectedItem(String text){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 20),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
        color: Colors.grey.shade400
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(text,style: Theme.of(context).textTheme.titleMedium!.copyWith(
              fontSize: 20,
            color: Colors.black
          ),),
          Icon(Icons.check,color: Colors.black,),
        ],
      ),
    );
}

Widget getUnSelectedItem(String text){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 20),
      decoration: BoxDecoration(
          border: Border.all(color: MyTheme.lightPrimary)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(text,style: Theme.of(context).textTheme.titleMedium!.copyWith(
              fontSize: 20
          ),),

        ],
      ),
    );
}
}
