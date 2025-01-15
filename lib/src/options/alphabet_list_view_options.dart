import 'package:alphabet_index/alphabet_list_view.dart';

/// Options class.
///
/// Optional class containing all options for the AlphabetListView.
class AlphabetListViewOptions {
  /// Constructor of AlphabetListViewOptions
  const AlphabetListViewOptions({
    this.listOptions = const ListOptions(),
    this.scrollbarOptions = const ScrollbarOptions(),
    this.overlayOptions = const OverlayOptions(),
  });

  /// Customisation options for the list.
  final ListOptions listOptions;

  /// Customisation options for the scrollbar.
  final ScrollbarOptions scrollbarOptions;

  /// Customisation options for the overlay.
  final OverlayOptions overlayOptions;
}
