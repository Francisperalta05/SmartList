import 'package:equatable/equatable.dart';
import 'package:lista_super/features/model/shopping_item.dart';

abstract class ShoppingItemsState extends Equatable {
  const ShoppingItemsState();

  @override
  List<Object?> get props => [];
}

class ShoppingItemsInitial extends ShoppingItemsState {}

class ShoppingItemsLoading extends ShoppingItemsState {}

class ShoppingItemsLoaded extends ShoppingItemsState {
  final int listId;
  final List<ShoppingItem> items;

  const ShoppingItemsLoaded({required this.listId, required this.items});

  @override
  List<Object?> get props => [listId, items];
}

class ShoppingItemsError extends ShoppingItemsState {
  final String message;

  const ShoppingItemsError(this.message);

  @override
  List<Object?> get props => [message];
}
