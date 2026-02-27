import 'package:lista_super/features/model/shopping_item.dart';

import '../../../../core/utils/constants.dart';

class ShoppingItemMapper {
  static ShoppingItem fromMap(Map<String, dynamic> map) {
    return ShoppingItem(
      id: map[AppConstants.colId] as int?,
      listId: map[AppConstants.colListId] as int,
      name: map[AppConstants.colItemName] as String,
      quantity: map[AppConstants.colQuantity] as int?,
      isDone: (map[AppConstants.colIsDone] as int) == 1,
      createdAt: map[AppConstants.colCreatedAt] as String,
    );
  }

  static Map<String, dynamic> toMap(ShoppingItem item) {
    return {
      if (item.id != null) AppConstants.colId: item.id,
      AppConstants.colListId: item.listId,
      AppConstants.colItemName: item.name,
      AppConstants.colQuantity: item.quantity,
      AppConstants.colIsDone: item.isDone ? 1 : 0,
      AppConstants.colCreatedAt: item.createdAt,
    };
  }
}
