import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/di/injector.dart';
import 'core/theme/app_theme.dart';
import 'features/controller/blocs/shopping_items/shopping_items_bloc.dart';
import 'features/controller/blocs/shopping_list/shopping_lists_bloc.dart';
import 'features/view/pages/shopping_lists_page.dart'; 
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ShoppingListsBloc>(create: (_) => sl<ShoppingListsBloc>()),
        BlocProvider<ShoppingItemsBloc>(create: (_) => sl<ShoppingItemsBloc>()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Shopping List',
        theme: AppTheme.darkTheme,
        home: const ShoppingListsPage(),
      ),
    );
  }
}
