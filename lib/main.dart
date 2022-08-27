import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/Provider/app_provider.dart';
import 'package:todo_app/Provider/taskProvider.dart';
import 'package:todo_app/firebase_options.dart';
import 'package:todo_app/home/edit_task/editTaskScreen.dart';
import 'package:todo_app/home/home_screen.dart';
import 'package:todo_app/my_theme.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseFirestore.instance.disableNetwork();
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(
        create: (BuildContext context) => AppProvider(),

      ),
      ChangeNotifierProvider(
        create: (BuildContext context) => TaskProvider(),

      ),
    ],
    child: MyApp(),)
  );
}

class MyApp extends StatelessWidget {
  late AppProvider provider;
  late TaskProvider taskProvider;
  @override
  Widget build(BuildContext context) {
    provider = Provider.of(context);
    taskProvider=Provider.of(context);
    return MaterialApp(
      locale: Locale(provider.currentLang),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      routes: {
        HomeScreen.routeName: (_) => HomeScreen(),
        EditTaskScreen.routeName: (_) => EditTaskScreen(),

      },
      initialRoute: HomeScreen.routeName,
      theme: MyTheme.lightTheme,
      themeMode: provider.currentTheme,
      darkTheme: MyTheme.darkTheme,
      debugShowCheckedModeBanner: false,
    );
  }
}
