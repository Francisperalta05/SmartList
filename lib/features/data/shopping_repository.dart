import 'package:lista_super/features/model/shopping_item.dart';
import 'package:lista_super/features/model/shopping_list.dart';

abstract class ShoppingRepository {
  // Lists
  Future<List<ShoppingList>> getLists();
  Future<int> createList(ShoppingList list);
  Future<int> updateListName({required int listId, required String name});
  Future<int> deleteList(int listId);

  // Items
  Future<List<ShoppingItem>> getItemsByList(int listId);
  Future<int> createItem(ShoppingItem item);
  Future<int> toggleItemDone({required int itemId, required bool isDone});
  Future<int> updateItem({
    required int itemId,
    required String name,
    int? quantity,
  });
  Future<int> deleteItem(int itemId);
  Future<int> clearDoneItems(int listId);

  // Counts
  Future<int> countPendingItems(int listId);
}
