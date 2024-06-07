import 'package:flutter/material.dart';
import 'package:responsive_utility/src/linear_direction.dart';

/// A Flutter widget that displays a list of widgets in a linear layout (row or column).
///
/// The [LinearWidget] provides various options for customizing the appearance and behavior
/// of the linear layout, such as setting the main axis size, alignment, spacing, padding,
/// margin, and child decoration.
class LinearWidget extends StatefulWidget {
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

  /// Whether all children should be expanded to fill the available space along the main axis.
  final bool expandChildren;

  /// The padding around the linear layout.
  final EdgeInsets? padding;

  /// The margin around the linear layout.
  final EdgeInsets? margin;

  /// The spacing between each child widget.
  /// Default value is 0.0.
  final double spacing;

  /// Whether the order of the children should be reversed.
  final bool reverse;

  /// The decoration for each child widget.
  final BoxDecoration? childDecoration;

  /// The width of each child widget when [childDecoration] is not null.
  final double? childWidth;

  /// The height of each child widget when [childDecoration] is not null.
  final double? childHeight;

  const LinearWidget({
    super.key,
    required this.direction,
    required this.children,
    this.mainAxisSize = MainAxisSize.max,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.scrollPhysics,
    this.expandChildren = false,
    this.padding,
    this.margin,
    this.spacing = 0.0,
    this.reverse = false,
    this.childDecoration,
    this.childWidth,
    this.childHeight,
  });

  @override
  _LinearWidgetState createState() => _LinearWidgetState();
}

class _LinearWidgetState extends State<LinearWidget> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Adjust child sizes if necessary
        List<Widget> adjustedChildren = widget.children;

        if (widget.expandChildren) {
          // Ensure all children have equal sizes by wrapping them with Expanded
          adjustedChildren = widget.children.map((child) {
            return Expanded(child: child);
          }).toList();
        }

        // Apply padding, margin, and decoration to each child
        adjustedChildren = adjustedChildren.map((child) {
          Widget decoratedChild = child;
          if (widget.childDecoration != null) {
            decoratedChild = Container(
              width: widget.childWidth,
              height: widget.childHeight,
              decoration: widget.childDecoration,
              child: child,
            );
          }
          if (widget.padding != null || widget.margin != null) {
            decoratedChild = Container(
              padding: widget.padding,
              margin: widget.margin,
              child: decoratedChild,
            );
          }
          return decoratedChild;
        }).toList();

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

        // Reverse the order of children if specified
        if (widget.reverse) {
          adjustedChildren = adjustedChildren.reversed.toList();
        }

        // Return the appropriate layout based on the direction
        return SingleChildScrollView(
          scrollDirection: widget.direction == LinearDirection.row ? Axis.horizontal : Axis.vertical,
          physics: widget.scrollPhysics,
          child: widget.direction == LinearDirection.row
              ? Row(
                  mainAxisSize: widget.mainAxisSize,
                  mainAxisAlignment: widget.mainAxisAlignment,
                  crossAxisAlignment: widget.crossAxisAlignment,
                  children: adjustedChildren,
                )
              : Column(
                  mainAxisSize: widget.mainAxisSize,
                  mainAxisAlignment: widget.mainAxisAlignment,
                  crossAxisAlignment: widget.crossAxisAlignment,
                  children: adjustedChildren,
                ),
        );
      },
    );
  }
}
