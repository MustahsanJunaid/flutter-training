import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:training/components/my_button.dart';
import 'package:training/components/title_text.dart';
import 'package:training/constants.dart';
import 'package:training/model/category.dart';
import 'package:training/navigation/routes.dart';
import 'package:training/providers/selected_category_notifier.dart';
import 'package:training/screens/home/categories.dart';
import 'package:training/screens/home/screen_breakpoints.dart';
import 'package:transparent_image/transparent_image.dart';

class CategoryDetailsScreen extends ConsumerStatefulWidget {
  final bool showAppBar;

  const CategoryDetailsScreen({super.key, this.showAppBar = true});

  @override
  ConsumerState<CategoryDetailsScreen> createState() => _CategoryDetailsScreen();
}

class _CategoryDetailsScreen extends ConsumerState<CategoryDetailsScreen> {
  var isChecked = false;

  Widget getPlaceholderText(BuildContext context) {
    return Text(
      "Item Not Selected",
      style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Theme.of(context).colorScheme.onBackground),
    );
  }

  @override
  Widget build(BuildContext context) {
    Category? category = ref.watch(selectedCategoryProvider);
    print("Build of detail is called");
    var body = Center(
      child: category == null ? getPlaceholderText(context) : getMainBody(context, category),
    );

    if (!widget.showAppBar) {
      return body;
    } else {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Category Details'),
        ),
        body: body,
      );
    }
  }

  getMainBody(BuildContext context, Category category) {
    return Padding(
      padding: ScreenBreakPoints.isTablet(context)
          ? const EdgeInsets.only(top: 16.0, right: 16.0, bottom: 16.0)
          : const EdgeInsets.all(16.0),
      child: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16.0),
              child: Stack(
                children: [
                  Hero(
                    tag: category.id,
                    child: FadeInImage.memoryNetwork(
                      placeholder: kTransparentImage,
                      image: backgroundUrl,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      height: 260,
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            Theme.of(context).colorScheme.background.withOpacity(0.9),
                            Theme.of(context).colorScheme.background.withOpacity(0.0),
                          ],
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          InkWell(
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Icon(
                                Icons.camera_enhance,
                                size: 24.0,
                                color: Theme.of(context).colorScheme.onBackground,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const TitleText(text: "id"),
                    Text(category.id),
                    const SizedBox(height: 16.0),
                    const TitleText(text: "name"),
                    Text(category.name),
                    const Spacer(flex: 1),
                    MyButton(onTap: () => navService.navigateTo(Routes.updateCategory, arguments: category), text: 'Update'),
                    const SizedBox(height: 16.0),
                    MyNegativeButton(onTap: _deleteCategory, text: 'Delete')
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onSwitchChanged(bool value) {
    setState(() {
      isChecked = value;
    });
  }

  _deleteCategory() {
  }
}
