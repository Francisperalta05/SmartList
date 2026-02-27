import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/injector.dart';
import '../../../../core/theme/app_colors.dart';
import '../../controller/blocs/shopping_items/shopping_items_bloc.dart';
import '../../controller/blocs/shopping_items/shopping_items_event.dart';
import '../../controller/blocs/shopping_items/shopping_items_state.dart';
import '../widgets/add_item_sheet.dart';
import '../widgets/shopping_item_tile.dart';

class ShoppingItemsPage extends StatelessWidget {
  final int listId;
  final String listName;

  const ShoppingItemsPage({
    super.key,
    required this.listId,
    required this.listName,
  });

  void _openAddItem(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => AddItemSheet(listId: listId),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _openAddItem(context),
        icon: const Icon(Icons.add),
        label: const Text('Agregar'),
      ),
      body: Container(
        decoration: const BoxDecoration(gradient: AppColors.backgroundGradient),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(Icons.arrow_back),
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        listName,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    // const SizedBox(width: 8),
                    // BlocBuilder<ShoppingItemsBloc, ShoppingItemsState>(
                    //   builder: (context, state) {
                    //     final canClear =
                    //         state is ShoppingItemsLoaded &&
                    //         state.items.any((e) => e.isDone);

                    //     return IconButton(
                    //       tooltip: 'Limpiar comprados',
                    //       onPressed: canClear
                    //           ? () => context.read<ShoppingItemsBloc>().add(
                    //               ClearDoneItems(listId),
                    //             )
                    //           : null,
                    //       icon: const Icon(Icons.cleaning_services_outlined),
                    //     );
                    //   },
                    // ),
                  ],
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: BlocBuilder<ShoppingItemsBloc, ShoppingItemsState>(
                    builder: (context, state) {
                      if (state is ShoppingItemsLoading ||
                          state is ShoppingItemsInitial) {
                        return const Center(
                          child: CircularProgressIndicator.adaptive(),
                        );
                      }

                      if (state is ShoppingItemsError) {
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

                      final items = (state as ShoppingItemsLoaded).items;
                      final pending = items.where((e) => !e.isDone).toList();
                      final done = items.where((e) => e.isDone).toList();

                      if (items.isEmpty) {
                        return Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                              Icon(
                                Icons.playlist_add,
                                size: 40,
                                color: AppColors.textSecondary,
                              ),
                              SizedBox(height: 10),
                              Text(
                                'Lista vacía',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: 6),
                              Text(
                                'Agrega tu primer producto.',
                                style: TextStyle(
                                  color: AppColors.textSecondary,
                                ),
                              ),
                            ],
                          ),
                        );
                      }

                      return ListView(
                        children: [
                          if (pending.isNotEmpty) ...[
                            _SectionHeader(
                              title: 'Por comprar',
                              count: pending.length,
                            ),
                            const SizedBox(height: 8),
                            ...pending.map(
                              (item) => Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: ShoppingItemTile(
                                  item: item,
                                  onToggle: (value) {
                                    context.read<ShoppingItemsBloc>().add(
                                      ToggleShoppingItemDone(
                                        listId: listId,
                                        itemId: item.id!,
                                        isDone: value,
                                      ),
                                    );
                                  },
                                  onDelete: () {
                                    context.read<ShoppingItemsBloc>().add(
                                      DeleteShoppingItem(
                                        listId: listId,
                                        itemId: item.id!,
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(height: 14),
                          ],
                          if (done.isNotEmpty) ...[
                            _SectionHeader(
                              title: 'Comprados',
                              count: done.length,
                            ),
                            const SizedBox(height: 8),
                            ...done.map(
                              (item) => Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: ShoppingItemTile(
                                  item: item,
                                  dimmed: true,
                                  onToggle: (value) {
                                    context.read<ShoppingItemsBloc>().add(
                                      ToggleShoppingItemDone(
                                        listId: listId,
                                        itemId: item.id!,
                                        isDone: value,
                                      ),
                                    );
                                  },
                                  onDelete: () {
                                    context.read<ShoppingItemsBloc>().add(
                                      DeleteShoppingItem(
                                        listId: listId,
                                        itemId: item.id!,
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ],
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  final int count;

  const _SectionHeader({required this.title, required this.count});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(width: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: AppColors.card,
            borderRadius: BorderRadius.circular(999),
          ),
          child: Text(
            '$count',
            style: const TextStyle(
              fontSize: 12,
              color: AppColors.textSecondary,
            ),
          ),
        ),
      ],
    );
  }
}
