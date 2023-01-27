import 'package:flutter/material.dart';
import 'package:media_plex/media_plex/books/presentation/pages/book_subject_page.dart';
import 'package:media_plex/shared/presentation/widget/total_text.dart';

class BookSubjectsListPage extends StatelessWidget {
  const BookSubjectsListPage({
    super.key,
    required this.subject,
    required this.icon,
    required this.list,
  });

  final String subject;
  final String icon;
  final List<String> list;

  static const routeName = '/bookBySubjectsPageRoute';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(
              'assets/icons/$icon',
              width: 35,
            ),

            const SizedBox(width: 8),

            Expanded(
              child: Text(
                subject,
                style: Theme.of(context).textTheme.bodyText1
                    ?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
            ),
          ],
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: list.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () => Navigator.pushNamed(
                      context,
                      BookSubjectPage.routeName,
                      arguments: list[index],
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      margin: const EdgeInsets.symmetric(vertical: 4.0),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(color: Colors.white),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              textAlign: TextAlign.start,
                              list[index],
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ),
                          ),

                          const Icon(Icons.arrow_forward_ios_outlined),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            TotalText(total: list.length, context: context),
          ],
        ),
      ),
    );
  }
}