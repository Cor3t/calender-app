import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skeme/config/app_config.dart';
import 'package:skeme/config/template.dart';
import 'package:skeme/screens/calender.dart';
import 'package:skeme/screens/show_info.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<CalendarProvider>(
            create: (context) => CalendarProvider()),
        ChangeNotifierProvider<EditProvider>(
            create: (context) => EditProvider())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        darkTheme: darkTheme,
        theme: lightTheme,
        home: Scaffold(body: CalendarPage()),
      ),
    );
  }
}
