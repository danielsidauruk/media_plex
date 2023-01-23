import 'package:flutter/material.dart';

class LoadingAnimation extends StatelessWidget {
  const LoadingAnimation({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      child: Column(
        children: [
          verticalLoadingTile(),
          const SizedBox(height: 8.0),
          verticalLoadingTile(),
          const SizedBox(height: 8.0),
          verticalLoadingTile(),
          const SizedBox(height: 8.0),
          verticalLoadingTile(),
          const SizedBox(height: 8.0),
          verticalLoadingTile(),
        ],
      ),
    );
  }

  Container verticalLoadingTile() {
    return Container(
      width: double.infinity,
      height: 100,
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(8.0),
      ),
    );
  }
}
