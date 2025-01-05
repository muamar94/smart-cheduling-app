// main.dart

import 'package:flutter/material.dart';
import 'welcome.dart';
import 'root.dart';
import 'permissions.dart';
import 'calendar.dart';
import 'add_task.dart';
import 'add_event.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const WelcomePage(),
        '/root': (context) => const RootPage(),
        '/permissions': (context) => const PermissionsPage(),
        '/calendar': (context) => const CalendarPage(),
        '/addTask': (context) => const AddTaskPage(
              tasks: [],
            ),
        '/addEvent': (context) => const AddEventPage(
              events: [],
            ),
      },
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.transparent,
      ),
      builder: (BuildContext context, Widget? child) {
        return Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.blue, Colors.teal],
            ),
          ),
          child: child,
        );
      },
    );
  }
}
