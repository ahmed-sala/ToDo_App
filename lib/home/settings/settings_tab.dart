import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/Provider/app_provider.dart';
import 'package:todo_app/home/settings/Lang_bottom_sheet.dart';
import 'package:todo_app/home/settings/theme_bottom_sheet.dart';
import 'package:todo_app/my_theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Settings_tab extends StatefulWidget {
  @override
  State<Settings_tab> createState() => _Settings_tabState();
}

class _Settings_tabState extends State<Settings_tab> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppProvider>(context);
    return Container(
      padding: EdgeInsets.symmetric(vertical: 30, horizontal: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            AppLocalizations.of(context)!.lang,
            style: Theme.of(context)
                .textTheme
                .bodySmall!
                .copyWith(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          InkWell(
            onTap: (){
              showLangBottomSheet();
            },
            child: Container(
              width: 319,
              height: 48,
              padding: EdgeInsets.symmetric(horizontal: 10),
              margin: EdgeInsets.only(top: 20, left: 25),
              decoration: BoxDecoration(
                  color: provider.isDark() ? MyTheme.darkScafoldBackground : Colors.white,
                  border: Border.all(color: MyTheme.lightPrimary)),
              child: Row(
                children: [
                  Text(
                    provider.currentLang=='en'?'English':'العربية',
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(fontSize: 14),
                  ),
                  Spacer(),
                  Icon(
                    Icons.arrow_drop_down,
                    color: MyTheme.lightPrimary,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Text(
            AppLocalizations.of(context)!.theme,
            style: Theme.of(context)
                .textTheme
                .bodySmall!
                .copyWith(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          InkWell(
            onTap: () {
              showThemeBottomSheet();
            },
            child: Container(
              width: 319,
              height: 48,
              padding: EdgeInsets.symmetric(horizontal: 10),
              margin: EdgeInsets.only(top: 20, left: 25),
              decoration: BoxDecoration(
                  color: provider.isDark() ? MyTheme.darkScafoldBackground : Colors.white,
                  border: Border.all(color: MyTheme.lightPrimary)),
              child: Row(
                children: [
                  Text(
                    provider.isDark()?AppLocalizations.of(context)!.dark:AppLocalizations.of(context)!.light,
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(fontSize: 14),
                  ),
                  Spacer(),
                  Icon(
                    Icons.arrow_drop_down,
                    color: MyTheme.lightPrimary,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  showThemeBottomSheet() {
    showModalBottomSheet(

        context: context,
        builder: (_) {
          return ThemeBottomSheet();
        });
  }
  showLangBottomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return LangBottomSheet();
        });
  }
}
