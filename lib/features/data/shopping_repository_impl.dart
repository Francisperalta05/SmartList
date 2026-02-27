import 'package:lista_super/features/data/shopping_local_ds.dart';
import 'package:lista_super/features/model/shopping_item.dart';
import 'package:lista_super/features/model/shopping_list.dart';

import 'shopping_repository.dart';

class ShoppingRepositoryImpl implements ShoppingRepository {
  final ShoppingLocalDataSource local;

  ShoppingRepositoryImpl(this.local);

  // Lists
  @override
  Future<List<ShoppingList>> getLists() => local.getLists();

  @override
  Future<int> createList(ShoppingList list) => local.createList(list);

  @override
  Future<int> updateListName({required int listId, required String name}) =>
      local.updateListName(listId: listId, name: name);

  @override
  Future<int> deleteList(int listId) => local.deleteList(listId);

  // Items
  @override
  Future<List<ShoppingItem>> getItemsByList(int listId) =>
      local.getItemsByList(listId);

  @override
  Future<int> createItem(ShoppingItem item) => local.createItem(item);

  @override
  Future<int> toggleItemDone({required int itemId, required bool isDone}) =>
      local.toggleItemDone(itemId: itemId, isDone: isDone);

  @override
  Future<int> updateItem({
    required int itemId,
    required String name,
    int? quantity,
  }) => local.updateItem(itemId: itemId, name: name, quantity: quantity);

  @override
  Future<int> deleteItem(int itemId) => local.deleteItem(itemId);

  @override
  Future<int> clearDoneItems(int listId) => local.clearDoneItems(listId);

  // Counts
  @override
  Future<int> countPendingItems(int listId) => local.countPendingItems(listId);
}
