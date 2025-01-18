import 'package:flutter/widgets.dart';
import 'package:reorderable_scroll_view/src/drag_container.dart';
import 'package:reorderable_scroll_view/src/drag_notification.dart';
import 'package:reorderable_scroll_view/src/reorderable_scrollview_base.dart';
import 'models.dart';

/// List view implementation
class ReorderableListView extends ReorderableScrollViewBase {
  const ReorderableListView({
    super.key,
    super.enableReordering = true,
    required super.children,
    super.isLongPressDraggable = true,
    super.buildFeedback,
    super.axis,
    super.dragCallbacks,
    super.hitTestBehavior = HitTestBehavior.translucent,
    super.scrollController,
    super.isDragNotification = false,
    super.draggingWidgetOpacity = 0.5,
    super.edgeScroll = 0.1,
    super.edgeScrollSpeedMilliseconds = 100,
    super.isNotDragList,
    super.scrollViewOptions,
  });

  @override
  State<ReorderableListView> createState() => _ReorderableListViewState();
}

class _ReorderableListViewState extends State<ReorderableListView> {
  List<ListItem> _children = const [];

  @override
  void initState() {
    super.initState();
    _children = widget.children;
  }

  @override
  void didUpdateWidget(ReorderableListView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.children != oldWidget.children) {
      setState(() {
        _children = widget.children;
      });
    }
  }

  Widget buildContainer({
    required Widget Function(List<Widget>) buildItems,
  }) {
    return DragContainer(
      isDrag: widget.enableReordering,
      scrollDirection: widget.scrollViewOptions.scrollDirection,
      isLongPressDraggable: widget.isLongPressDraggable,
      buildItems: buildItems,
      buildFeedback: widget.buildFeedback,
      axis: widget.axis,
      dragCallbacks: widget.dragCallbacks,
      hitTestBehavior: widget.hitTestBehavior,
      scrollController: widget.scrollController,
      isDragNotification: widget.isDragNotification,
      draggingWidgetOpacity: widget.draggingWidgetOpacity,
      edgeScroll: widget.edgeScroll,
      edgeScrollSpeedMilliseconds: widget.edgeScrollSpeedMilliseconds,
      isNotDragList: widget.isNotDragList,
      items: (ListItem element, DraggableWidget draggableWidget) {
        return Container(
          key: ValueKey(element.key.toString()),
          child: draggableWidget(element.widget),
        );
      },
      dataList: _children,
    );
  }

  @override
  Widget build(BuildContext context) {
    return DragNotification(
      child: SingleChildScrollView(
        scrollDirection: widget.scrollViewOptions.scrollDirection,
        physics: widget.scrollViewOptions.physics,
        child: buildContainer(
          buildItems: (List<Widget> children) {
            return ListView(
              scrollDirection: widget.scrollViewOptions.scrollDirection,
              reverse: widget.scrollViewOptions.reverse,
              controller: widget.scrollViewOptions.controller,
              primary: widget.scrollViewOptions.primary,
              physics: widget.scrollViewOptions.physics,
              shrinkWrap: widget.scrollViewOptions.shrinkWrap,
              padding: widget.scrollViewOptions.padding,
              dragStartBehavior: widget.scrollViewOptions.dragStartBehavior,
              keyboardDismissBehavior:
                  widget.scrollViewOptions.keyboardDismissBehavior,
              restorationId: widget.scrollViewOptions.restorationId,
              clipBehavior: widget.scrollViewOptions.clipBehavior,
              children: children,
            );
          },
        ),
      ),
    );
  }
}
