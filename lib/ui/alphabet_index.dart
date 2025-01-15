import 'package:alphabet_index/alphabet_list_view.dart';
import 'package:flutter/material.dart';

class AlphabetIndex extends StatelessWidget {
  final List<String> items;
  final Color? backgroundColor;
  final Color? sideBArBackgroundColor;
  final Color? labelColor;
  const AlphabetIndex({super.key, required this.items, this.backgroundColor, this.sideBArBackgroundColor, this.labelColor});
  static List<String> alphabets = List.generate(26, (index) => String.fromCharCode(65 + index));

  // List<String> items = ['Banana', 'Banana', 'Banana', 'Banana', 'Banana', 'Banana', 'Banana', 'Banana', 'Banana', 'Banana', 'Banana', 'Banana', 'Banana', 'Banana', 'Banana', 'Banana', 'Banana', 'Banana', 'Banana', 'Banana', 'Banana', 'Banana', 'Banana', 'Banana', 'Banana', 'Banana', 'Banana', 'Banana', 'Banana', 'Banana', 'Banana', 'Banana', 'Banana', 'Banana', 'Banana', 'Banana', 'Banana', 'Banana', 'Banana', 'Banana', 'Banana', 'Banana', 'Banana', 'Banana', 'Banana', 'Banana', 'Banana', 'Banana', 'Banana', 'Banana', 'Banana', 'Banana', 'Banana', 'Banana', 'Banana', 'Banana', 'Banana', 'Apple', 'Apple', 'Apple', 'Apple', 'Apple', 'Apple', 'Apple', 'Apple', 'Apple', 'Apple', 'Apple', 'Apple', 'Apple', 'Apple', 'Apple', 'Apple', 'Apple', 'Apple', 'Apple', 'Apple', 'Apple', 'Apple', 'Apple', 'Apple', 'Apple', 'Apple', 'Apple', 'Apple', 'Apple', 'Apple', 'Apple', 'Apple', 'Apple', 'Apple', 'Apple', 'Apple', 'Apple', 'Apple', 'Apple', 'Apple', 'Apple', 'Apple', 'Apple', 'Apple', 'Apple', 'Apple', 'Apple', 'Apple', 'Dragonfruit', 'Apple', 'Avocado', 'Apple', 'Avocado', 'Apple', 'Avocado', 'Apple', 'Avocado', 'Apple', 'Blueberry', 'Cherry', 'Cherry', 'Cucumber', 'Avocado', 'Date', 'Cucumber', 'Eggplant', 'Elderberry', 'Kiwi', 'Kale', 'Xylophone', '2345276tv', '5gguggyds'];

  List<AlphabetListViewItemGroup> generateItems({required List<String> items}) {
    items.sort();
    Map<String, List<String>> alphabeticMap = {};
    for (String item in items) {
      String startingLetter = item[0].toUpperCase();
      alphabeticMap.putIfAbsent(startingLetter, () => []).add(item);
    }
    final List<String> alphabets = List.generate(26, (index) => String.fromCharCode(65 + index));
    for (String letter in alphabets) {
      alphabeticMap.putIfAbsent(letter, () => []);
    }

    final List<AlphabetListViewItemGroup> groupedItems = alphabets.map((alphabet) {
      final children = alphabeticMap[alphabet] ?? [];
      return AlphabetListViewItemGroup(
        tag: alphabet,
        children: children.map((child) => Padding(padding: const EdgeInsets.only(left: 12.0, right: 12.0, bottom: 8), child: Text(child, style: TextStyle(fontWeight: FontWeight.bold, color: labelColor)))).toList(),
      );
    }).toList();

    return groupedItems;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor ?? Colors.white,
      padding: const EdgeInsets.only(right: 10),
      child: AlphabetListView(
        items: generateItems(items: items),
        options: AlphabetListViewOptions(
          overlayOptions: OverlayOptions(
            alignment: Alignment.centerRight,
            overlayBuilder: (context, symbol) {
              return SizedBox(
                width: 50,
                height: 50,
                child: Padding(
                  padding: const EdgeInsets.only(left: 12),
                  child: FittedBox(
                    child: Text(
                      symbol,
                      textScaler: TextScaler.noScaling,
                      style: const TextStyle(
                        color: Color.fromARGB(100, 225, 0, 0),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
          scrollbarOptions: ScrollbarOptions(
            width: 20,
            jumpToSymbolsWithNoEntries: true,
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(color: sideBArBackgroundColor ?? const Color.fromARGB(255, 238, 238, 238), borderRadius: const BorderRadius.all(Radius.circular(20))),
            symbolBuilder: (context, symbol, state) {
              final color = switch (state) {
                AlphabetScrollbarItemState.active => Colors.red,
                AlphabetScrollbarItemState.deactivated => Colors.grey,
                _ => Colors.grey,
              };

              final size = switch (state) { AlphabetScrollbarItemState.active => 14.0, AlphabetScrollbarItemState.deactivated => 10.0, _ => 12.0 };

              return Center(
                child: FittedBox(
                  child: Text(
                    symbol,
                    style: TextStyle(color: color, fontSize: size),
                  ),
                ),
              );
            },
          ),
          listOptions: ListOptions(
            backgroundColor: backgroundColor ?? Colors.white,
            stickySectionHeader: true,
            showSectionHeaderForEmptySections: false,
            listHeaderBuilder: (context, symbol) => Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.horizontal(
                      right: Radius.circular(5),
                    ),
                    color: backgroundColor ?? Colors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 12, top: 8, right: 16, bottom: 5),
                    child: Text(
                      symbol,
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
