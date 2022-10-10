import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double value;
  final double percentage;

  ChartBar({
    required this.label,
    required this.value,
    required this.percentage,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('r\$${value.toStringAsFixed(2)}'),
        SizedBox(
          height: 5,
        ),
        Container(
          height: 60,
          width: 10,
          child: null,
        ),
        SizedBox(
          height: 5,
        ),
        Text(label),
      ],
    );
  }
}
