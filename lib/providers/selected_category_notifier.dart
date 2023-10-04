import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:training/model/category.dart';
import 'package:training/providers/category_provider.dart';

class SelectedCategoryNotifier extends StateNotifier<Category?> {
  late StateNotifierProviderRef<SelectedCategoryNotifier, Category?> ref;

  SelectedCategoryNotifier(this.ref) : super(null);

  void selectCategory(String id) {
    state = ref.read(categoryListProvider).firstWhere((element) => element.id == id);
  }
  void updateCategory(Category category) {
    ref.read(categoryListProvider.notifier).updateCategory(category);
    state = category;
  }
}

var selectedCategoryProvider = StateNotifierProvider<SelectedCategoryNotifier, Category?>((ref) {
  return SelectedCategoryNotifier(ref);
});
