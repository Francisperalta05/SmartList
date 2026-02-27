import 'package:lista_super/features/model/shopping_list.dart';

import '../../../../core/utils/constants.dart';

class ShoppingListMapper {
  static ShoppingList fromMap(Map<String, dynamic> map) {
    return ShoppingList(
      id: map[AppConstants.colId] as int?,
      name: map[AppConstants.colListName] as String,
      createdAt: map[AppConstants.colCreatedAt] as String,
    );
  }

  static Map<String, dynamic> toMap(ShoppingList list) {
    return {
      if (list.id != null) AppConstants.colId: list.id,
      AppConstants.colListName: list.name,
      AppConstants.colCreatedAt: list.createdAt,
    };
  }
}
