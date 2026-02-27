import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lista_super/features/data/shopping_repository.dart';
import 'package:lista_super/features/model/shopping_list.dart';

import '../../../../../core/utils/date_utils.dart';

import 'shopping_lists_event.dart';
import 'shopping_lists_state.dart';

class ShoppingListsBloc extends Bloc<ShoppingListsEvent, ShoppingListsState> {
  final ShoppingRepository repo;

  ShoppingListsBloc(this.repo) : super(ShoppingListsInitial()) {
    on<LoadShoppingLists>(_onLoad);
    on<CreateShoppingList>(_onCreate);
    on<RenameShoppingList>(_onRename);
    on<DeleteShoppingList>(_onDelete);
  }

  Future<void> _onLoad(
    LoadShoppingLists event,
    Emitter<ShoppingListsState> emit,
  ) async {
    emit(ShoppingListsLoading());
    try {
      final lists = await repo.getLists();
      emit(ShoppingListsLoaded(lists));
    } catch (e) {
      emit(ShoppingListsError(e.toString()));
    }
  }

  Future<void> _onCreate(
    CreateShoppingList event,
    Emitter<ShoppingListsState> emit,
  ) async {
    final currentState = state;

    // Mantén lo que haya en pantalla, pero puedes emitir loading si prefieres.
    if (currentState is ShoppingListsLoaded) {
      emit(ShoppingListsLoaded(currentState.lists));
    } else {
      emit(ShoppingListsLoading());
    }

    try {
      final list = ShoppingList(
        name: event.name.trim(),
        createdAt: AppDateUtils.nowIso(),
      );

      await repo.createList(list);
      final lists = await repo.getLists();
      emit(ShoppingListsLoaded(lists));
      add(LoadShoppingLists());
    } catch (e) {
      emit(ShoppingListsError(e.toString()));
    }
  }

  Future<void> _onRename(
    RenameShoppingList event,
    Emitter<ShoppingListsState> emit,
  ) async {
    try {
      await repo.updateListName(listId: event.listId, name: event.name.trim());
      final lists = await repo.getLists();
      emit(ShoppingListsLoaded(lists));
    } catch (e) {
      emit(ShoppingListsError(e.toString()));
    }
  }

  Future<void> _onDelete(
    DeleteShoppingList event,
    Emitter<ShoppingListsState> emit,
  ) async {
    try {
      await repo.deleteList(event.listId);
      final lists = await repo.getLists();
      emit(ShoppingListsLoaded(lists));
    } catch (e) {
      emit(ShoppingListsError(e.toString()));
    }
  }
}
