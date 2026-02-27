import 'package:equatable/equatable.dart';
import 'package:lista_super/features/model/shopping_list.dart';

abstract class ShoppingListsState extends Equatable {
  const ShoppingListsState();

  @override
  List<Object?> get props => [];
}

class ShoppingListsInitial extends ShoppingListsState {}

class ShoppingListsLoading extends ShoppingListsState {}

class ShoppingListsLoaded extends ShoppingListsState {
  final List<ShoppingList> lists;

  const ShoppingListsLoaded(this.lists);

  @override
  List<Object?> get props => [lists];
}

class ShoppingListsError extends ShoppingListsState {
  final String message;

  const ShoppingListsError(this.message);

  @override
  List<Object?> get props => [message];
}
