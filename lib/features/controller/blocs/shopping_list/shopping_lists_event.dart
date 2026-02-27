import 'package:equatable/equatable.dart';

abstract class ShoppingListsEvent extends Equatable {
  const ShoppingListsEvent();

  @override
  List<Object?> get props => [];
}

class LoadShoppingLists extends ShoppingListsEvent {
  const LoadShoppingLists();
}

class CreateShoppingList extends ShoppingListsEvent {
  final String name;

  const CreateShoppingList(this.name);

  @override
  List<Object?> get props => [name];
}

class RenameShoppingList extends ShoppingListsEvent {
  final int listId;
  final String name;

  const RenameShoppingList({required this.listId, required this.name});

  @override
  List<Object?> get props => [listId, name];
}

class DeleteShoppingList extends ShoppingListsEvent {
  final int listId;

  const DeleteShoppingList(this.listId);

  @override
  List<Object?> get props => [listId];
}
