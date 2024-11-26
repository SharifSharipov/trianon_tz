
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

import '../../data/models/drop_down_item_model.dart';
part 'drop_down_event.dart';
part 'drop_down_state.dart';

class DropDownBloc extends Bloc<DropDownEvent, DropDownState> {
  DropDownBloc(List<DropDownItem> items)
      : super(DropDownState(items: items));

  Stream<DropDownState> mapEventToState(DropDownEvent event) async* {
    if (event is UpdateSearchQuery) {
      yield state.copyWith(searchQuery: event.query);
    } else if (event is UpdateSelection) {
      final updatedItems = state.items.map((item) {
        if (item.id == event.id) {
          return DropDownItem(
            id: item.id,
            title: item.title,
            isSelected: !item.isSelected,
          );
        }
        return item;
      }).toList();
      yield state.copyWith(items: updatedItems);
    } else if (event is ToggleMultiSelect) {
      yield state.copyWith(isMultiSelect: !state.isMultiSelect);
    }
  }
}