import 'package:lista_super/core/errors/exceptions.dart';
import 'package:lista_super/core/utils/constants.dart';
import 'package:lista_super/features/model/shopping_item.dart';
import 'package:lista_super/features/model/shopping_item_mapper.dart';
import 'package:lista_super/features/model/shopping_list.dart';
import 'package:lista_super/features/model/shopping_list_mapper.dart';
import 'package:sqflite/sqflite.dart';

abstract class ShoppingLocalDataSource {
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

  // Counts (para UI)
  Future<int> countPendingItems(int listId);
}

class ShoppingLocalDataSourceImpl implements ShoppingLocalDataSource {
  final Database db;

  ShoppingLocalDataSourceImpl(this.db);

  // -----------------------
  // Lists
  // -----------------------
  @override
  Future<List<ShoppingList>> getLists() async {
    try {
      final rows = await db.query(
        AppConstants.tableShoppingLists,
        orderBy: '${AppConstants.colId} DESC',
      );
      return rows.map(ShoppingListMapper.fromMap).toList();
    } catch (e) {
      throw DatabasesException('Error obteniendo listas: $e');
    }
  }

  @override
  Future<int> createList(ShoppingList list) async {
    try {
      return await db.insert(
        AppConstants.tableShoppingLists,
        ShoppingListMapper.toMap(list),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      throw DatabasesException('Error creando lista: $e');
    }
  }

  @override
  Future<int> updateListName({
    required int listId,
    required String name,
  }) async {
    try {
      return await db.update(
        AppConstants.tableShoppingLists,
        {AppConstants.colListName: name},
        where: '${AppConstants.colId} = ?',
        whereArgs: [listId],
      );
    } catch (e) {
      throw DatabasesException('Error actualizando lista: $e');
    }
  }

  @override
  Future<int> deleteList(int listId) async {
    try {
      // Si el FK cascade no aplica por configuración del engine,
      // esto asegura limpieza.
      await db.delete(
        AppConstants.tableShoppingItems,
        where: '${AppConstants.colListId} = ?',
        whereArgs: [listId],
      );

      return await db.delete(
        AppConstants.tableShoppingLists,
        where: '${AppConstants.colId} = ?',
        whereArgs: [listId],
      );
    } catch (e) {
      throw DatabasesException('Error eliminando lista: $e');
    }
  }

  // -----------------------
  // Items
  // -----------------------
  @override
  Future<List<ShoppingItem>> getItemsByList(int listId) async {
    try {
      final rows = await db.query(
        AppConstants.tableShoppingItems,
        where: '${AppConstants.colListId} = ?',
        whereArgs: [listId],
        // Pendientes arriba, luego por más recientes
        orderBy: '${AppConstants.colIsDone} ASC, ${AppConstants.colId} DESC',
      );
      return rows.map(ShoppingItemMapper.fromMap).toList();
    } catch (e) {
      throw DatabasesException('Error obteniendo items: $e');
    }
  }

  @override
  Future<int> createItem(ShoppingItem item) async {
    try {
      return await db.insert(
        AppConstants.tableShoppingItems,
        ShoppingItemMapper.toMap(item),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      throw DatabasesException('Error creando item: $e');
    }
  }

  @override
  Future<int> toggleItemDone({
    required int itemId,
    required bool isDone,
  }) async {
    try {
      return await db.update(
        AppConstants.tableShoppingItems,
        {AppConstants.colIsDone: isDone ? 1 : 0},
        where: '${AppConstants.colId} = ?',
        whereArgs: [itemId],
      );
    } catch (e) {
      throw DatabasesException('Error cambiando estado item: $e');
    }
  }

  @override
  Future<int> updateItem({
    required int itemId,
    required String name,
    int? quantity,
  }) async {
    try {
      return await db.update(
        AppConstants.tableShoppingItems,
        {AppConstants.colItemName: name, AppConstants.colQuantity: quantity},
        where: '${AppConstants.colId} = ?',
        whereArgs: [itemId],
      );
    } catch (e) {
      throw DatabasesException('Error actualizando item: $e');
    }
  }

  @override
  Future<int> deleteItem(int itemId) async {
    try {
      return await db.delete(
        AppConstants.tableShoppingItems,
        where: '${AppConstants.colId} = ?',
        whereArgs: [itemId],
      );
    } catch (e) {
      throw DatabasesException('Error eliminando item: $e');
    }
  }

  @override
  Future<int> clearDoneItems(int listId) async {
    try {
      return await db.delete(
        AppConstants.tableShoppingItems,
        where:
            '${AppConstants.colListId} = ? AND ${AppConstants.colIsDone} = 1',
        whereArgs: [listId],
      );
    } catch (e) {
      throw DatabasesException('Error limpiando items comprados: $e');
    }
  }

  // -----------------------
  // Counts
  // -----------------------
  @override
  Future<int> countPendingItems(int listId) async {
    try {
      final result = await db.rawQuery(
        '''
        SELECT COUNT(*) as cnt
        FROM ${AppConstants.tableShoppingItems}
        WHERE ${AppConstants.colListId} = ?
          AND ${AppConstants.colIsDone} = 0
      ''',
        [listId],
      );

      return Sqflite.firstIntValue(result) ?? 0;
    } catch (e) {
      throw DatabasesException('Error contando pendientes: $e');
    }
  }
}
