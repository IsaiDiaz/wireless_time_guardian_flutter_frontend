import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wireless_time_guardian_flutter_frontend/bloc/page_bloc.dart';
import 'package:wireless_time_guardian_flutter_frontend/pages/home.dart';

void main() {
  runApp(BlocProvider(create: (context) => PageBloc(), child: const MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.green, brightness: Brightness.light),
          textTheme: const TextTheme(
              displayLarge: TextStyle(
            fontSize: 72,
            fontWeight: FontWeight.bold,
          ))),
      home: const Scaffold(body: HomePage()),
    );
  }
}
