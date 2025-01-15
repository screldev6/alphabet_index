import 'package:alphabet_index/alphabet_list_view.dart';
import 'package:flutter/material.dart';

class AlphabetIndex extends StatelessWidget {
  final List<String> items;
  final Color? backgroundColor;
  final Color? sideBarBackgroundColor;
  final Color? labelColor;
  final Color? selectedColor; 
  final Color? borderColor; 
  const AlphabetIndex({super.key, required this.items, this.backgroundColor, this.sideBarBackgroundColor, this.labelColor, this.selectedColor, this.borderColor});
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
        children: children
            .map(
              (child) => Padding(
                padding: const EdgeInsets.only(left: 12.0, right: 12.0, bottom: 12),
                child: Container(
                  padding: const EdgeInsets.only(bottom: 13),
                  decoration: BoxDecoration(border: Border(bottom: BorderSide(color:borderColor?? Colors.grey))),
                  child: Text(
                    child,
                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 12, color: labelColor ?? Color(0xff353535)),
                  ),
                ),
              ),
            )
            .toList(),
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
                      style: TextStyle(color: selectedColor ?? Colors.red),
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
            decoration: BoxDecoration(color: sideBarBackgroundColor ?? Colors.red, borderRadius: const BorderRadius.all(Radius.circular(20))),
            symbolBuilder: (context, symbol, state) {
              final color = switch (state) {
                AlphabetScrollbarItemState.active => selectedColor ?? Colors.red,
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
                    padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                    child: Container(
                      decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey))),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 18, right: 16, bottom: 10),
                        child: Text(
                          symbol,
                          style: TextStyle(fontSize: 12, color: labelColor ?? Colors.grey),
                        ),
                      ),
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
