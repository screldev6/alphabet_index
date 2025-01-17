import 'package:alphabet_index/alphabet_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class AlphabetIndex extends HookWidget {
  final List<String> items;
  final List<String>? favItems;
  final List<int>? initialSelectedIndexes;
  final Color? backgroundColor;
  final Color? sideBarBackgroundColor;
  final ScrollViewKeyboardDismissBehavior keyboardDismissBehavior;
  final Color? labelColor;
  final Color? selectedColor;
  final Color? borderColor;
  final Color? tileBackgroundColor;
  final double? height;
  final double? scrollBarHeight;
  final double? width;
  final ScrollPhysics? physics;
  final void Function(String)? onTap;

  const AlphabetIndex({
    super.key,
    required this.items,
    this.favItems,
    this.initialSelectedIndexes,
    this.backgroundColor,
    this.tileBackgroundColor,
    this.scrollBarHeight,
    this.sideBarBackgroundColor,
    required this.keyboardDismissBehavior,
    this.onTap,
    this.labelColor,
    this.selectedColor,
    this.borderColor,
    this.height,
    this.width,
    this.physics,
  });

  static List<String> alphabets = List.generate(26, (index) => String.fromCharCode(65 + index));

  @override
  Widget build(BuildContext context) {
    // Initialize selectedIndexes using the initialSelectedIndexes parameter
    var selectedIndexes = useState<List<int>>(initialSelectedIndexes ?? []);

    // Helper function to build a list item widget
    Widget buildListItem({
      required List<String> items,
      required int index,
    }) {
      return InkWell(
        onTap: () {
          if (onTap != null) {
            onTap!(items[index]);
            if (selectedIndexes.value.contains(index)) {
              // Remove the item from the selection
              selectedIndexes.value = selectedIndexes.value.where((i) => i != index).toList();
            } else {
              // Add the item to the selection
              selectedIndexes.value = [...selectedIndexes.value, index];
            }
          }
        },
        child: Padding(
          padding: const EdgeInsets.only(left: 12.0, right: 12.0, bottom: 10),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: borderColor ?? Colors.grey)),
              borderRadius: BorderRadius.circular(10),
              color: selectedIndexes.value.contains(index) ? (tileBackgroundColor ?? Colors.blue) : Colors.transparent,
            ),
            child: Text(
              items[index],
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 12,
                color: selectedIndexes.value.contains(index) ? (selectedColor ?? Colors.white) : (labelColor ?? const Color(0xff353535)),
              ),
            ),
          ),
        ),
      );
    }

    List<AlphabetListViewItemGroup> generateItems({
      required List<String> items,
      List<String>? favItems, // Optional favorite items
    }) {
      // Sort items alphabetically
      items.sort((a, b) => a.toLowerCase().compareTo(b.toLowerCase()));

      // Map to hold indices grouped by their starting alphabet
      Map<String, List<int>> alphabeticMap = {};

      // Group items under "★" if they're in favItems, otherwise group alphabetically
      final favoriteIndices = <int>[];
      for (int i = 0; i < items.length; i++) {
        if (favItems != null && favItems.contains(items[i])) {
          favoriteIndices.add(i);
        } else {
          String startingChar = items[i][0].toUpperCase();
          if (!AlphabetIndex.alphabets.contains(startingChar)) {
            startingChar = '#';
          }
          alphabeticMap.putIfAbsent(startingChar, () => []).add(i);
        }
      }

      // Ensure all alphabet groups are present, even if empty
      final List<String> alphabets = ['★'] + AlphabetIndex.alphabets + ['#'];
      for (String letter in alphabets) {
        alphabeticMap.putIfAbsent(letter, () => []);
      }

      // Build grouped items with "★" for favorites and others alphabetically
      final List<AlphabetListViewItemGroup> groupedItems = [
        AlphabetListViewItemGroup(
          tag: '★',
          children: favoriteIndices
              .map(
                (index) => buildListItem(
                  items: items,
                  index: index,
                ),
              )
              .toList(),
        ),
        ...alphabets.skip(1).map((alphabet) {
          final indices = alphabeticMap[alphabet] ?? [];
          return AlphabetListViewItemGroup(
            tag: alphabet,
            children: indices
                .map(
                  (index) => buildListItem(
                    items: items,
                    index: index,
                  ),
                )
                .toList(),
          );
        }).toList(),
      ];

      return groupedItems;
    }

    return Container(
      width: width ?? MediaQuery.sizeOf(context).width,
      height: height ?? MediaQuery.sizeOf(context).height,
      color: backgroundColor ?? Colors.white,
      child: AlphabetListView(
        items: generateItems(items: items, favItems: favItems),
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
            width: 40,
            height: scrollBarHeight ?? 500,
            jumpToSymbolsWithNoEntries: true,
            padding: const EdgeInsets.symmetric(vertical: 20),
            decoration: BoxDecoration(color: sideBarBackgroundColor ?? Colors.red, borderRadius: const BorderRadius.all(Radius.circular(20))),
            symbolBuilder: (context, symbol, state) {
              final color = switch (state) {
                AlphabetScrollbarItemState.active => selectedColor ?? Colors.red,
                AlphabetScrollbarItemState.deactivated => Colors.grey,
                _ => Colors.grey,
              };
              final size = switch (state) { AlphabetScrollbarItemState.active => 18.0, AlphabetScrollbarItemState.deactivated => 14.0, _ => 14.0 };

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
            keyboardDismissBehavior: keyboardDismissBehavior,
            physics: physics,
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
                      decoration: BoxDecoration(border: Border(bottom: BorderSide(color: borderColor ?? Colors.grey))),
                      child: Padding(
                        padding: const EdgeInsets.only(right: 16, bottom: 5),
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
