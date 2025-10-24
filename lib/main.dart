import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubit/book_cubit.dart';
import 'screens/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Book Club',
      theme: ThemeData(
        primaryColor: const Color.fromARGB(255, 255, 232, 239),
        scaffoldBackgroundColor: const Color.fromARGB(255, 255, 255, 255),
        appBarTheme: AppBarTheme(
          backgroundColor: const Color.fromARGB(255, 255, 226, 236),
          foregroundColor: const Color.fromARGB(255, 0, 0, 0),
          elevation: 0,
        ),
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
          titleMedium: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
          headlineSmall: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
          headlineMedium: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
        ),
      ),
      home: BlocProvider(
        create: (context) => BookCubit()..init(),
        child: const HomePage(),
      ),
    );
  }
}
