# LinearWidget

A Flutter widget that displays a list of widgets in a linear layout (row or column).

## Features

- Directional layout (row or column).
- Customizable main axis size, alignment, spacing, padding, margin, and child decoration.
- Scrollable if the children exceed the available space.
- Option to expand children to fill the available space along the main axis.
- Reversible order of children.

## Installation

Add the following line to your `pubspec.yaml` file under dependencies:

```yaml
dependencies:
  linear_widget: ^0.0.1
```

Then, run `flutter pub get` to install the package.

## Usage

### Basic Example

Here is a simple example of how to use the `LinearWidget`:

```dart
import 'package:flutter/material.dart';
import 'package:linear_widget/linear_widget.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('LinearWidget Example')),
        body: LinearWidget(
          direction: LinearDirection.row,
          children: [
            Container(width: 50, height: 50, color: Colors.red),
            Container(width: 50, height: 50, color: Colors.green),
            Container(width: 50, height: 50, color: Colors.blue),
          ],
          spacing: 10.0,
          padding: EdgeInsets.all(10.0),
          margin: EdgeInsets.all(10.0),
          childDecoration: BoxDecoration(
            border: Border.all(color: Colors.black),
          ),
        ),
      ),
    );
  }
}
```

### Properties

- `direction`: The direction of the linear layout, either `LinearDirection.row` or `LinearDirection.column`.
- `children`: The list of widgets to be displayed in the linear layout.
- `mainAxisSize`: The size of the main axis (horizontal for rows, vertical for columns). Default is `MainAxisSize.max`.
- `mainAxisAlignment`: The alignment of the children along the main axis. Default is `MainAxisAlignment.start`.
- `crossAxisAlignment`: The alignment of the children along the cross axis. Default is `CrossAxisAlignment.center`.
- `scrollPhysics`: The physics used for scrolling the linear layout if the children exceed the available space.
- `expandChildren`: Whether all children should be expanded to fill the available space along the main axis. Default is `false`.
- `padding`: The padding around the linear layout.
- `margin`: The margin around the linear layout.
- `spacing`: The spacing between each child widget. Default is `0.0`.
- `reverse`: Whether the order of the children should be reversed. Default is `false`.
- `childDecoration`: The decoration for each child widget.
- `childWidth`: The width of each child widget when `childDecoration` is not null.
- `childHeight`: The height of each child widget when `childDecoration` is not null.

## Contributing

Contributions are welcome! Please submit issues and pull requests for any improvements or bug fixes.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for more information.

---

Feel free to customize the properties and add more examples to suit your needs. Happy coding!
