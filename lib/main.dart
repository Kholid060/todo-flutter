import 'package:flutter/material.dart';
import 'package:todo/database.dart';
import 'package:todo/pages/todo_page.dart';

extension DefaultNaN on double {
  double defaultIfNaN(double value) => isNaN ? value : this;
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await TodoDatabase.initDB();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({ Key? key }) : super(key: key);


  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: 'To-Do App',
      home: const TodoPage(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Poppins',
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.cyanAccent,
        ),
      ),
    );
  }
}