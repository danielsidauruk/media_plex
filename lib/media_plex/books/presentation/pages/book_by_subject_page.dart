import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_plex/core/utils/constants.dart';
import 'package:media_plex/core/utils/routes.dart';
import 'package:media_plex/media_plex/books/domain/entities/books_by_subject.dart';
import 'package:media_plex/media_plex/books/presentation/bloc/book_by_subject_bloc/book_subject_bloc.dart';
import 'package:media_plex/shared/presentation/widget/loading_animation.dart';
import 'package:media_plex/shared/presentation/widget/total_text.dart';

class BookBySubjectPage extends StatelessWidget {
  const BookBySubjectPage({super.key, required this.title});
  final String title;

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

      body: buildSubjectBloc(),
    );
  }

  Padding buildSubjectBloc() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 4.0),
              child: BlocBuilder<BookBySubjectBloc, BookBySubjectState>(
                builder: (context, state) {
                  if (state is BookBySubjectEmpty) {
                    return const Center();
                  } else if (state is BookBySubjectLoading) {
                    return const LoadingAnimation();
                  } else if (state is BookBySubjectLoaded) {
                    final books = state.subject.works;
                    return bookList(books, context);
                  } else if (state is BookBySubjectError) {
                    return Text(state.message);
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Column bookList(List<Work> books, BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: books.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () => Navigator.pushNamed(
                  context,
                  bookDetailRoute,
                  arguments: books[index].key,
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CachedNetworkImage(
                        width: 60,
                        fit: BoxFit.fill,
                        imageUrl: mediumImageByCoverI('${books[index].coverId}'),
                        placeholder: (context, url) => const Center(),
                        errorWidget: (context, url, error) => Image.asset(
                          'assets/images/not_applicable_icon.png',
                        ),
                      ),
                      const SizedBox(
                        width: 8.0,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  textAlign: TextAlign.start,
                                  '${books[index].title} (${books[index].firstPublishYear})',
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle1
                                      ?.copyWith(fontWeight: FontWeight.bold),
                                ),

                                const SizedBox(height: 4.0,),

                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [

                                    books[index].subject.isNotEmpty
                                        ? wrapText(books[index].subject, context)
                                        : const Center(),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),

        const SizedBox(height: 8),

        TotalText(total: books.length, context: context),

      ],
    );
  }
}

Expanded wrapText(List<String> books, context) {
  String text = "Subject : ${books.join(', ')}";

  return Expanded(
    child: RichText(
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      text: TextSpan(
        text: text,
        style: Theme.of(context).textTheme.subtitle2
            ?.copyWith(fontWeight: FontWeight.bold),
      ),
    ),
  );
}

















