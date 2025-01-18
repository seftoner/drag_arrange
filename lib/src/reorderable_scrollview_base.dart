import 'package:flutter/widgets.dart';
import 'package:reorderable_scroll_view/src/models.dart';
import 'package:reorderable_scroll_view/src/drag_callbacks.dart';
import 'package:reorderable_scroll_view/src/scroll_view_options.dart';

/// Base class for reorderable scroll views
abstract class ReorderableScrollViewBase extends StatefulWidget {
  final bool enableReordering;
  final List<ListItem> children;
  final bool isLongPressDraggable;
  final Widget Function(ListItem, Widget, Size)? buildFeedback;
  final Axis? axis;
  final DragCallbacks<ListItem> dragCallbacks;
  final HitTestBehavior hitTestBehavior;
  final ScrollController? scrollController;
  final bool isDragNotification;
  final double draggingWidgetOpacity;
  final double edgeScroll;
  final int edgeScrollSpeedMilliseconds;
  final List<ListItem>? isNotDragList;
  final BoxDecoration? dragChildBoxDecoration;
  final ScrollViewOptions scrollViewOptions;

  const ReorderableScrollViewBase({
    super.key,
    this.enableReordering = false,
    required this.children,
    required this.isLongPressDraggable,
    this.buildFeedback,
    this.axis,
    this.dragCallbacks = const DragCallbacks(),
    this.hitTestBehavior = HitTestBehavior.translucent,
    this.scrollController,
    this.isDragNotification = false,
    this.draggingWidgetOpacity = 0.5,
    this.edgeScroll = 0.1,
    this.edgeScrollSpeedMilliseconds = 100,
    this.isNotDragList,
    this.dragChildBoxDecoration,
    this.scrollViewOptions = const ScrollViewOptions(),
  });
}
