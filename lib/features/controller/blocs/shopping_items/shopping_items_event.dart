import 'package:equatable/equatable.dart';

abstract class ShoppingItemsEvent extends Equatable {
  const ShoppingItemsEvent();

  @override
  List<Object?> get props => [];
}

class LoadShoppingItems extends ShoppingItemsEvent {
  final int listId;

  const LoadShoppingItems(this.listId);

  @override
  List<Object?> get props => [listId];
}

class CreateShoppingItem extends ShoppingItemsEvent {
  final int listId;
  final String name;
  final int? quantity;

  const CreateShoppingItem({
    required this.listId,
    required this.name,
    this.quantity,
  });

  @override
  List<Object?> get props => [listId, name, quantity];
}

class ToggleShoppingItemDone extends ShoppingItemsEvent {
  final int listId;
  final int itemId;
  final bool isDone;

  const ToggleShoppingItemDone({
    required this.listId,
    required this.itemId,
    required this.isDone,
  });

  @override
  List<Object?> get props => [listId, itemId, isDone];
}

class UpdateShoppingItem extends ShoppingItemsEvent {
  final int listId;
  final int itemId;
  final String name;
  final int? quantity;

  const UpdateShoppingItem({
    required this.listId,
    required this.itemId,
    required this.name,
    this.quantity,
  });

  @override
  List<Object?> get props => [listId, itemId, name, quantity];
}

class DeleteShoppingItem extends ShoppingItemsEvent {
  final int listId;
  final int itemId;

  const DeleteShoppingItem({
    required this.listId,
    required this.itemId,
  });

  @override
  List<Object?> get props => [listId, itemId];
}

class ClearDoneItems extends ShoppingItemsEvent {
  final int listId;

  const ClearDoneItems(this.listId);

  @override
  List<Object?> get props => [listId];
}