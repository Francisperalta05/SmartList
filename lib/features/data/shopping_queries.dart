import '../../../../core/utils/constants.dart';

class ShoppingQueries {
  static String countPendingItems() =>
      '''
    SELECT COUNT(*) as cnt
    FROM ${AppConstants.tableShoppingItems}
    WHERE ${AppConstants.colListId} = ?
      AND ${AppConstants.colIsDone} = 0
  ''';
}
