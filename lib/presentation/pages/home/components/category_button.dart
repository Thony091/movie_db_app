import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_db_app/presentation/providers/home/home_provider.dart';

class CategoryButton extends ConsumerWidget {
  final String label;
  final int index;

  const CategoryButton({
    super.key, 
    required this.label, 
    required this.index,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref ) {

    final pageIndexNotifier = ref.watch(pageIndexHomeProvider.notifier);
    final selectedIndex = ref.watch(pageIndexHomeProvider);
    final isSelected = selectedIndex == index;

    return GestureDetector(
      onTap: () {
        pageIndexNotifier.changePage(index);
      },
      child: Container(
        margin: const EdgeInsets.only(right: 10),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected 
            ? const Color(0xFF61C19C) 
            : const Color.fromARGB(255, 86, 89, 96).withValues(alpha: 0.8),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label, 
          style: TextStyle(
            color: !isSelected
              ?  Colors.white 
              :  Color(0xFF33373E)
          )
        ),
      ),
    );
  }
}
