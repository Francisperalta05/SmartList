class ShoppingItem {
  final int? id;
  final int listId;
  final String name;
  final int? quantity;
  final bool isDone;
  final String createdAt;

  const ShoppingItem({
    this.id,
    required this.listId,
    required this.name,
    this.quantity,
    required this.isDone,
    required this.createdAt,
  });

  ShoppingItem copyWith({
    int? id,
    int? listId,
    String? name,
    int? quantity,
    bool? isDone,
    String? createdAt,
  }) {
    return ShoppingItem(
      id: id ?? this.id,
      listId: listId ?? this.listId,
      name: name ?? this.name,
      quantity: quantity ?? this.quantity,
      isDone: isDone ?? this.isDone,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}