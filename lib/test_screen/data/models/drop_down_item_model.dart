class DropDownItem {
  final String id;
  final String title;
  bool isSelected;

  DropDownItem({
    required this.id,
    required this.title,
    this.isSelected = false,
  });
}
