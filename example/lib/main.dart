import 'package:flutter/material.dart';
import 'package:responsive_utility/responsive_utility.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return Scaffold(
            appBar: AppBar(title: const Text('LinearWidget Example')),
            body: Linear(
              direction: MediaQuery.of(context).size.width <= 425
                  ? LinearDirection.column
                  : LinearDirection.row,
              spacing: 10.0,
              padding: const EdgeInsets.all(10.0),
              children: [
                Container(width: 300, height: 300, color: Colors.red),
                Container(width: 300, height: 300, color: Colors.green),
                Container(width: 300, height: 300, color: Colors.blue),
              ],
            ),
          );
        },
      ),
    );
  }
}
