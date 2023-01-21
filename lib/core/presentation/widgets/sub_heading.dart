import 'package:flutter/material.dart';
import 'package:media_plex/core/styles/text_styles.dart';

class SubHeading extends StatelessWidget {
  final String title;
  final Function onTap;

  const SubHeading({
    Key? key,
    required this.title,
    required this.onTap
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: kHeading6,
        ),
        InkWell(
          onTap: () => onTap(),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: const [
                Text('See More'),
                Icon(Icons.arrow_forward_ios)],
            ),
          ),
        ),
      ],
    );
  }
}
