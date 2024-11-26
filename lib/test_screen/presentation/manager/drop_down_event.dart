part of 'drop_down_bloc.dart';

@immutable
abstract class DropDownEvent {}

class UpdateSearchQuery extends DropDownEvent {
  final String query;

  UpdateSearchQuery(this.query);
}

class UpdateSelection extends DropDownEvent {
  final String id;

  UpdateSelection(this.id);
}

class ToggleMultiSelect extends DropDownEvent {}