import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lista_super/features/controller/blocs/shopping_list/shopping_lists_bloc.dart';
import 'package:lista_super/features/controller/blocs/shopping_list/shopping_lists_event.dart';
import 'package:lista_super/features/controller/blocs/shopping_list/shopping_lists_state.dart';

import '../../../../core/di/injector.dart';
import '../../../../core/theme/app_colors.dart';
import '../widgets/create_edit_list_modal.dart';
import '../widgets/shopping_list_card.dart';
import 'shopping_items_page.dart';

class ShoppingListsPage extends StatelessWidget {
  const ShoppingListsPage({super.key});

  void _openCreateList(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => const CreateEditListModal(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<ShoppingListsBloc>()..add(const LoadShoppingLists()),
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () => _openCreateList(context),
          child: const Icon(Icons.add),
        ),
        body: Container(
          decoration: const BoxDecoration(
            gradient: AppColors.backgroundGradient,
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 6),
                  const Text(
                    'Listas',
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Tu supermercado, pero ordenado.',
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: BlocBuilder<ShoppingListsBloc, ShoppingListsState>(
                      builder: (context, state) {
                        if (state is ShoppingListsLoading ||
                            state is ShoppingListsInitial) {
                          return const Center(
                            child: CircularProgressIndicator.adaptive(),
                          );
                        }

                        if (state is ShoppingListsError) {
                          return Center(
                            child: Text(
                              state.message,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: AppColors.textSecondary,
                              ),
                            ),
                          );
                        }

                        final lists = (state as ShoppingListsLoaded).lists;

                        if (lists.isEmpty) {
                          return Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.shopping_cart_outlined,
                                  size: 42,
                                  color: AppColors.textSecondary,
                                ),
                                const SizedBox(height: 10),
                                const Text(
                                  'No tienes listas todavía',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                const Text(
                                  'Crea una para comenzar.',
                                  style: TextStyle(
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                FilledButton(
                                  onPressed: () => _openCreateList(context),
                                  child: const Text('Crear lista'),
                                ),
                              ],
                            ),
                          );
                        }

                        return ListView.separated(
                          itemCount: lists.length,
                          separatorBuilder: (_, __) =>
                              const SizedBox(height: 12),
                          itemBuilder: (context, index) {
                            final list = lists[index];

                            return ShoppingListCard(
                              list: list,
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (_) => ShoppingItemsPage(
                                      listId: list.id!,
                                      listName: list.name,
                                    ),
                                  ),
                                );
                              },
                              onRename: () {
                                showModalBottomSheet(
                                  context: context,
                                  backgroundColor: Colors.transparent,
                                  isScrollControlled: true,
                                  builder: (_) => CreateEditListModal(
                                    listId: list.id!,
                                    initialName: list.name,
                                  ),
                                );
                              },
                              onDelete: () {
                                context.read<ShoppingListsBloc>().add(
                                  DeleteShoppingList(list.id!),
                                );
                              },
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
