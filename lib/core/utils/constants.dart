class AppConstants {
  // DB
  static const String dbName = 'shopping_app.db';
  static const int dbVersion = 1;

  // Tables
  static const String tableShoppingLists = 'shopping_lists';
  static const String tableShoppingItems = 'shopping_items';

  // Common columns
  static const String colId = 'id';
  static const String colCreatedAt = 'created_at';

  // Shopping Lists columns
  static const String colListName = 'name';

  // Shopping Items columns
  static const String colListId = 'list_id';
  static const String colItemName = 'name';
  static const String colQuantity = 'quantity';
  static const String colIsDone = 'is_done';
}
