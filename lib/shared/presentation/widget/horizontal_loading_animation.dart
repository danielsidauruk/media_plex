import 'package:flutter/material.dart';

class HorizontalLoadingAnimation extends StatelessWidget {
  const HorizontalLoadingAnimation({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 4,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: 80,
              height: 120,
              color: Colors.grey,
            ),
          );
        },
      ),
    );
  }
}