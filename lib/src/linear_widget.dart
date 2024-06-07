import 'package:flutter/material.dart';
import 'package:responsive_utility/src/linear_direction.dart';

/// A Flutter widget that displays a list of widgets in a linear layout (row, column, wrap, or grid).
///
/// The [Linear] provides various options for customizing the appearance and behavior
/// of the linear layout, such as setting the main axis size, alignment, spacing, and child decoration.
class Linear extends StatefulWidget {
  /// The direction of the linear layout, either row or column.
  final LinearDirection direction;

  /// The list of widgets to be displayed in the linear layout.
  final List<Widget> children;

  /// The size of the main axis (horizontal for rows, vertical for columns).
  /// Default value is [MainAxisSize.max].
  final MainAxisSize mainAxisSize;

  /// The alignment of the children along the main axis.
  /// Default value is [MainAxisAlignment.start].
  final MainAxisAlignment mainAxisAlignment;

  /// The alignment of the children along the cross axis.
  /// Default value is [CrossAxisAlignment.center].
  final CrossAxisAlignment crossAxisAlignment;

  /// The physics used for scrolling the linear layout if the children exceed the available space.
  final ScrollPhysics? scrollPhysics;

  /// The padding around the linear layout.
  final EdgeInsets? padding;

  /// The spacing between each child widget.
  /// Default value is 0.0.
  final double spacing;

  /// Whether the order of the children should be reversed.
  final bool reverse;

  /// The number of columns for the grid layout. Ignored if [useGrid] is false.
  final int gridColumns;

  const Linear({
    super.key,
    required this.direction,
    required this.children,
    this.mainAxisSize = MainAxisSize.max,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.scrollPhysics,
    this.padding,
    this.spacing = 0.0,
    this.reverse = false,
    this.gridColumns = 2,
  });

  @override
  LinearState createState() => LinearState();
}

class LinearState extends State<Linear> {
  @override
  Widget build(BuildContext context) {
    List<Widget> adjustedChildren = widget.children;

    // Reverse the order of children if specified
    if (widget.reverse) {
      adjustedChildren = adjustedChildren.reversed.toList();
    }

    // Add spacing between children
    if (widget.spacing > 0) {
      List<Widget> spacedChildren = [];
      for (int i = 0; i < adjustedChildren.length; i++) {
        spacedChildren.add(adjustedChildren[i]);
        if (i != adjustedChildren.length - 1) {
          spacedChildren.add(SizedBox(
            width: widget.direction == LinearDirection.row ? widget.spacing : 0,
            height: widget.direction == LinearDirection.column ? widget.spacing : 0,
          ));
        }
      }
      adjustedChildren = spacedChildren;
    }

    // Apply padding if specified
    Widget content = Padding(
      padding: widget.padding ?? EdgeInsets.zero,
      child: _buildLayout(adjustedChildren),
    );

    return SingleChildScrollView(
      scrollDirection: widget.direction == LinearDirection.row ? Axis.horizontal : Axis.vertical,
      physics: widget.scrollPhysics,
      child: content,
    );
  }

  Widget _buildLayout(List<Widget> children) {
    return widget.direction == LinearDirection.row
        ? Row(
            mainAxisSize: widget.mainAxisSize,
            mainAxisAlignment: widget.mainAxisAlignment,
            crossAxisAlignment: widget.crossAxisAlignment,
            children: children,
          )
        : Column(
            mainAxisSize: widget.mainAxisSize,
            mainAxisAlignment: widget.mainAxisAlignment,
            crossAxisAlignment: widget.crossAxisAlignment,
            children: children,
          );
  }
}
