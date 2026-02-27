class ShoppingList {
  final int? id;
  final String name;
  final String createdAt;

  const ShoppingList({this.id, required this.name, required this.createdAt});

  ShoppingList copyWith({int? id, String? name, String? createdAt}) {
    return ShoppingList(
      id: id ?? this.id,
      name: name ?? this.name,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
