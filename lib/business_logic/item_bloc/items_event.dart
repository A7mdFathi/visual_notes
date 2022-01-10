part of 'items_bloc.dart';

abstract class ItemsEvent extends Equatable {
  const ItemsEvent();
}

class ItemsFetched extends ItemsEvent {
  @override
  List<Object?> get props => [];
}

class SaveItem extends ItemsEvent {
  final Item item;
  final ItemType itemType;

  const SaveItem(this.item, this.itemType);

  @override
  List<Object?> get props => [item, itemType];
}

class DeleteItem extends ItemsEvent {
  final int id;

  const DeleteItem(this.id);

  @override
  List<Object?> get props => [id];
}
