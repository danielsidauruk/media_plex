import 'package:flutter/material.dart';

class SearchTile extends StatelessWidget {
  const SearchTile({
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
    return Container(
      margin: const EdgeInsets.all(4.0),
      padding: const EdgeInsets.all(8.0),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: Colors.white),
      ),
      child: Column(
        children: [
          Row(
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
                onTap: () => Navigator.pushNamed(context, routeName),
                child: const Icon(
                  Icons.search,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}