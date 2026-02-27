import 'package:get_it/get_it.dart';
import 'package:sqflite/sqflite.dart';

import '../../features/controller/blocs/shopping_items/shopping_items_bloc.dart';
import '../../features/controller/blocs/shopping_list/shopping_lists_bloc.dart';
import '../../features/data/shopping_local_ds.dart';
import '../../features/data/shopping_repository.dart';
import '../../features/data/shopping_repository_impl.dart';
import '../db/sqlite_database.dart';

final sl = GetIt.instance;

class Injector {
  static Future<void> init() async {
    // -----------------------
    // Database
    // -----------------------
    final database = await SQLiteDatabase().database;
    sl.registerLazySingleton<Database>(() => database);

    // -----------------------
    // DataSource
    // -----------------------
    sl.registerLazySingleton<ShoppingLocalDataSource>(
      () => ShoppingLocalDataSourceImpl(sl()),
    );

    // -----------------------
    // Repository
    // -----------------------
    sl.registerLazySingleton<ShoppingRepository>(
      () => ShoppingRepositoryImpl(sl()),
    );

    // -----------------------
    // BLoCs
    // -----------------------
    sl.registerFactory(() => ShoppingListsBloc(sl()));

    sl.registerFactory(() => ShoppingItemsBloc(sl()));
  }
}
