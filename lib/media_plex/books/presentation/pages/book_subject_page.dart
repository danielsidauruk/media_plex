import 'package:flutter/material.dart';

class BookSubjectPage extends StatelessWidget {
  const BookSubjectPage({super.key, required this.title});
  final String title;

  static const routeName = '/bookSubjectPageRoute';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: Text(
          title,
          style: Theme.of(context).textTheme.bodyText1
              ?.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
      ),

      body: Padding(
        padding: EdgeInsets.all(8.0),

      ),
    );
  }
}
