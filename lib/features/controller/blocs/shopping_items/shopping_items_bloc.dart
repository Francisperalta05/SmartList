import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lista_super/features/data/shopping_repository.dart';
import 'package:lista_super/features/model/shopping_item.dart';

import '../../../../../core/utils/date_utils.dart';

import 'shopping_items_event.dart';
import 'shopping_items_state.dart';

class ShoppingItemsBloc extends Bloc<ShoppingItemsEvent, ShoppingItemsState> {
  final ShoppingRepository repo;

  ShoppingItemsBloc(this.repo) : super(ShoppingItemsInitial()) {
    on<LoadShoppingItems>(_onLoad);
    on<CreateShoppingItem>(_onCreate);
    on<ToggleShoppingItemDone>(_onToggleDone);
    on<UpdateShoppingItem>(_onUpdate);
    on<DeleteShoppingItem>(_onDelete);
    on<ClearDoneItems>(_onClearDone);
  }

  Future<void> _onLoad(
    LoadShoppingItems event,
    Emitter<ShoppingItemsState> emit,
  ) async {
    emit(ShoppingItemsLoading());
    try {
      final items = await repo.getItemsByList(event.listId);
      emit(ShoppingItemsLoaded(listId: event.listId, items: items));
    } catch (e) {
      emit(ShoppingItemsError(e.toString()));
    }
  }

  Future<void> _onCreate(
    CreateShoppingItem event,
    Emitter<ShoppingItemsState> emit,
  ) async {
    try {
      final item = ShoppingItem(
        listId: event.listId,
        name: event.name.trim(),
        quantity: event.quantity,
        isDone: false,
        createdAt: AppDateUtils.nowIso(),
      );

      await repo.createItem(item);
      final items = await repo.getItemsByList(event.listId);
      emit(ShoppingItemsLoaded(listId: event.listId, items: items));
    } catch (e) {
      emit(ShoppingItemsError(e.toString()));
    }
  }

  Future<void> _onToggleDone(
    ToggleShoppingItemDone event,
    Emitter<ShoppingItemsState> emit,
  ) async {
    try {
      await repo.toggleItemDone(itemId: event.itemId, isDone: event.isDone);
      final items = await repo.getItemsByList(event.listId);
      emit(ShoppingItemsLoaded(listId: event.listId, items: items));
    } catch (e) {
      emit(ShoppingItemsError(e.toString()));
    }
  }

  Future<void> _onUpdate(
    UpdateShoppingItem event,
    Emitter<ShoppingItemsState> emit,
  ) async {
    try {
      await repo.updateItem(
        itemId: event.itemId,
        name: event.name.trim(),
        quantity: event.quantity,
      );
      final items = await repo.getItemsByList(event.listId);
      emit(ShoppingItemsLoaded(listId: event.listId, items: items));
    } catch (e) {
      emit(ShoppingItemsError(e.toString()));
    }
  }

  Future<void> _onDelete(
    DeleteShoppingItem event,
    Emitter<ShoppingItemsState> emit,
  ) async {
    try {
      await repo.deleteItem(event.itemId);
      final items = await repo.getItemsByList(event.listId);
      emit(ShoppingItemsLoaded(listId: event.listId, items: items));
    } catch (e) {
      emit(ShoppingItemsError(e.toString()));
    }
  }

  Future<void> _onClearDone(
    ClearDoneItems event,
    Emitter<ShoppingItemsState> emit,
  ) async {
    try {
      await repo.clearDoneItems(event.listId);
      final items = await repo.getItemsByList(event.listId);
      emit(ShoppingItemsLoaded(listId: event.listId, items: items));
    } catch (e) {
      emit(ShoppingItemsError(e.toString()));
    }
  }
}
