class Tables {
  // ---------------------------
  // Shopping Lists Table
  // ---------------------------
  static const String createShoppingLists = '''
    CREATE TABLE shopping_lists (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT NOT NULL,
      created_at TEXT NOT NULL
    );
  ''';

  // ---------------------------
  // Shopping Items Table
  // ---------------------------
  static const String createShoppingItems = '''
    CREATE TABLE shopping_items (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      list_id INTEGER NOT NULL,
      name TEXT NOT NULL,
      quantity INTEGER,
      is_done INTEGER NOT NULL DEFAULT 0,
      created_at TEXT NOT NULL,
      FOREIGN KEY (list_id) REFERENCES shopping_lists (id) ON DELETE CASCADE
    );
  ''';
}
