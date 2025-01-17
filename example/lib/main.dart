import 'package:alphabet_index/ui/alphabet_index.dart';
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
        body: const AlphabetIndexUi(),
      ),
    );
  }
}

class AlphabetIndexUi extends StatelessWidget {
  const AlphabetIndexUi({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> items = ['Banana', 'Banana','Favourites', 'Hot Selling', 'Banana', 'Banana', 'Banana', 'Banana', 'Banana', 'Banana', 'Banana', 'Banana', 'Banana', 'Banana', 'Banana', 'Banana', 'Banana', 'Banana', 'Banana', 'Banana', 'Banana', 'Banana', 'Banana', 'Banana', 'Banana', 'Banana', 'Banana', 'Banana', 'Banana', 'Banana', 'Banana', 'Banana', 'Banana', 'Banana', 'Banana', 'Banana', 'Banana', 'Banana', 'Banana', 'Banana', 'Banana', 'Banana', 'Banana', 'Banana', 'Banana', 'Banana', 'Banana', 'Banana', 'Banana', 'Banana', 'Banana', 'Banana', 'Banana', 'Banana', 'Banana', 'Banana', 'Banana', 'Banana', 'Banana', 'Apple', 'Apple', 'Apple', 'Apple', 'Apple', 'Apple', 'Apple', 'Apple', 'Apple', 'Apple', 'Apple', 'Apple', 'Apple', 'Apple', 'Apple', 'Apple', 'Apple', 'Apple', 'Apple', 'Apple', 'Apple', 'Apple', 'Apple', 'Apple', 'Apple', 'Apple', 'Apple', 'Apple', 'Apple', 'Apple', 'Apple', 'Apple', 'Apple', 'Apple', 'Apple', 'Apple', 'Apple', 'Apple', 'Apple', 'Apple', 'Apple', 'Apple', 'Apple', 'Apple', 'Apple', 'Apple', 'Apple', 'Apple', 'Dragonfruit', 'Apple', 'Avocado', 'Apple', 'Avocado', 'Apple', 'Avocado', 'Apple', 'Avocado', 'Apple', 'Blueberry', 'Cherry', 'Cherry', 'Cucumber', 'Avocado', 'Date', 'Cucumber', 'Eggplant', 'Elderberry', 'Kiwi', 'Kale', 'Xylophone', '2345276tv', '5gguggyds'];
    return Container(
        width: MediaQuery.sizeOf(context).width,
        height: MediaQuery.sizeOf(context).height,
        color: Colors.black,
        child: AlphabetIndex(
          favItems: ['Favourites', 'Hot Selling'],
          initialSelectedIndexes: [5, 10],
          onTap: (s) {
            print(s);
          },
          tileBackgroundColor: Colors.amber,
          // physics: NeverScrollableScrollPhysics(),
          selectedColor: Colors.white,
          sideBarBackgroundColor: Colors.black,
          borderColor: Colors.black,
          backgroundColor: Colors.black,
          labelColor: Colors.white,
          items: items,
        ));
  }
}
