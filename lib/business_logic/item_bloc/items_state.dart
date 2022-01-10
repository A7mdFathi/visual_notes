part of 'items_bloc.dart';

abstract class ItemsState extends Equatable {
  const ItemsState();
}

class ItemsInitial extends ItemsState {
  @override
  List<Object> get props => [];
}

class ItemsLoadInProgress extends ItemsState {
  @override
  List<Object?> get props => [];
}

class ItemsLoaded extends ItemsState {
  final List<Item> items;

  const ItemsLoaded(this.items);

  @override
  List<Object?> get props => [items];
}

class ItemsFailure extends ItemsState {
  final String msg;

  const ItemsFailure(this.msg);

  @override
  List<Object?> get props => [];
}
