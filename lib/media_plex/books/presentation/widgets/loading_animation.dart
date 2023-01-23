import 'package:flutter/material.dart';

class LoadingAnimation extends StatelessWidget {
  const LoadingAnimation({
    super.key,
    required this.tileHeight,
    required this.totalTile,
  });

  final double tileHeight;
  final int totalTile;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      child: ListView.builder(
        itemCount: totalTile,
        itemBuilder: (context, index) =>
            Column(
              children: [
                verticalLoadingTile(tileHeight),
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
