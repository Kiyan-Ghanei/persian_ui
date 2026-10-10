import 'package:flutter/material.dart';

/// A reusable tab component for PersianUI.
///
/// [PTabs] provides a simple wrapper around Flutter's [TabBar]
/// with a matching [TabBarView].
class PTabs extends StatelessWidget {
  const PTabs({
    super.key,
    required this.tabs,
    required this.views,
    this.initialIndex = 0,
    this.isScrollable = false,
    this.indicatorColor,
    this.labelColor,
    this.unselectedLabelColor,
    this.onChanged,
  }) : assert(tabs.length == views.length);

  final List<String> tabs;
  final List<Widget> views;
  final int initialIndex;
  final bool isScrollable;
  final Color? indicatorColor;
  final Color? labelColor;
  final Color? unselectedLabelColor;
  final ValueChanged<int>? onChanged;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      initialIndex: initialIndex,
      child: Builder(
        builder: (BuildContext context) {
          final TabController controller =
              DefaultTabController.of(context);

          controller.addListener(() {
            if (!controller.indexIsChanging) {
              onChanged?.call(controller.index);
            }
          });

          return Column(
            children: <Widget>[
              TabBar(
                controller: controller,
                isScrollable: isScrollable,
                indicatorColor: indicatorColor,
                labelColor: labelColor,
                unselectedLabelColor: unselectedLabelColor,
                tabs: tabs
                    .map(
                      (String tab) => Tab(text: tab),
                    )
                    .toList(),
              ),
              Expanded(
                child: TabBarView(
                  controller: controller,
                  children: views,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}