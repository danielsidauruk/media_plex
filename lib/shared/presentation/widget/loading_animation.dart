import 'package:flutter/material.dart';

class LoadingAnimation extends StatelessWidget {
  const LoadingAnimation({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 6,
        itemBuilder: (context, index) =>
            Column(
              children: [
                verticalLoadingTile(100),
                const SizedBox(height: 8.0),
              ],
            ),
      ),
    );
  }

  Container verticalLoadingTile(double tileHeight) {
    return Container(
      width: double.infinity,
      height: tileHeight,
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(8.0),
      ),
    );
  }
}
