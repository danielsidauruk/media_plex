import 'package:flutter/material.dart';

class TotalText extends StatelessWidget {
  const TotalText({
    Key? key,
    required this.total,
    required this.context,
  }) : super(key: key);

  final int total;
  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Text(
        'Total result : $total',
        style: Theme.of(context).textTheme.subtitle1?.
        copyWith(fontWeight: FontWeight.bold),
      ),
    );
  }
}