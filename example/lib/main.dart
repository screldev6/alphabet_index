import 'package:example/home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        // backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text('Example'),
        ),
        body: AlphabetIndexUi(),
      ),
    );
  }
}

class AlphabetIndexUi extends StatelessWidget {
  const AlphabetIndexUi({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: MyWidget(),
    );
  }
}
