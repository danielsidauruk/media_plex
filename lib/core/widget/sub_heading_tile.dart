import 'package:flutter/material.dart';

class SubHeadingTile extends StatelessWidget {
  const SubHeadingTile({
    super.key,
    required this.context,
    required this.title,
    required this.routeName,
  });

  final BuildContext context;
  final String title;
  final String routeName;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Theme.of(context)
              .textTheme
              .subtitle1
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        InkWell(
          onTap: () =>
              Navigator.pushNamed(context, routeName),
          child: const Icon(Icons.arrow_forward),
        ),
      ],
    );
  }
}