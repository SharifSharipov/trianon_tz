part of 'drop_down_bloc.dart';

@immutable

class DropDownState  extends Equatable  {
  final List<DropDownItem> items;
  final String searchQuery;
  final bool isMultiSelect;

  const DropDownState({
    required this.items,
    this.searchQuery = '',
    this.isMultiSelect = false,
  });

  DropDownState copyWith({
    List<DropDownItem>? items,
    String? searchQuery,
    bool? isMultiSelect,
  }) {
    return DropDownState(
      items: items ?? this.items,
      searchQuery: searchQuery ?? this.searchQuery,
      isMultiSelect: isMultiSelect ?? this.isMultiSelect,
    );
  }

  @override
  List<Object> get props => [items, isMultiSelect, searchQuery];
}
