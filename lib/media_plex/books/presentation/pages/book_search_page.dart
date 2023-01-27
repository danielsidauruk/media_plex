import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_plex/core/utils/constants.dart';
import 'package:media_plex/media_plex/books/domain/entities/book_search.dart';
import 'package:media_plex/media_plex/books/presentation/bloc/search_bloc/book_search_bloc.dart';
import 'package:media_plex/media_plex/books/presentation/pages/book_detail_page.dart';
import 'package:media_plex/shared/presentation/widget/loading_animation.dart';
import 'package:media_plex/shared/presentation/widget/total_text.dart';

class BookSearchPage extends StatelessWidget {
  static const routeName = '/bookSearchPageRoute';
  const BookSearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: Text(
          'Search Books',
          style: Theme.of(context).textTheme.bodyText1?.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
      ),
      body: buildBody(context),
    );
  }

  Padding buildBody(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Search books by title and author :',
            style: Theme.of(context).textTheme.subtitle1
                ?.copyWith(fontWeight: FontWeight.bold),
          ),

          searchTile(context),

          buildBloc(),
        ],
      ),
    );
  }

  Container searchTile(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      padding: const EdgeInsets.all(8.0),
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: Colors.white),
      ),
      child: TextField(
        onChanged: (query) =>
        query != "" ?
        BlocProvider.of<BookSearchBloc>(context, listen: false)
            .add(SearchForBook(query)) :
        BlocProvider.of<BookSearchBloc>(context, listen: false)
            .add(const SearchForBook("")),
        style: const TextStyle(),
        decoration: null,
      ),
    );
  }

  Expanded buildBloc() {
    return Expanded(
      child: BlocBuilder<BookSearchBloc, BookSearchState>(
        builder: (context, state) {
          if (state is BookSearchEmpty) {
            return const Center();
          } else if (state is BookSearchLoading) {
            return const LoadingAnimation();
          } else if (state is BookSearchLoaded) {
            final books = state.result.docs;
            return searchResult(books, state, context);
          } else if (state is BookSearchError) {
            if (kDebugMode) {
              print(state.message);
            }
            return const Center();
          } else {
            // return const SizedBox.shrink();
            return const Center();
          }
        },
      ),
    );
  }

  Column searchResult(List<Doc> books, BookSearchLoaded state, context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: books.length,
            itemBuilder: (context, index) {
              try {
                return bookTile(context, books, index);
              } catch (e) {
                return const Center();
              }
            },
          ),
        ),

        const SizedBox(height: 8),

        TotalText(total: state.result.numFound, context: context),

      ],
    );
  }

  InkWell bookTile(BuildContext context, List<Doc> books, int index) {
    return InkWell(
      onTap: () => Navigator.pushNamed(
        context,
        BookDetailPage.routeName,
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
              imageUrl: mediumImageByCoverI('${books[index].coverI}'),
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

                      const SizedBox(height: 8.0),

                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('By '),

                          books[index].authorName.isNotEmpty
                              ? wrapText(books[index].authorName, context)
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
  }


  Expanded wrapText(List<String> bookDetail, context) {
    return Expanded(
      child: Wrap(
        direction: Axis.horizontal,
        children: [
          ...bookDetail.map((item) => Text(
              '$item, ',
              style: Theme.of(context).textTheme.subtitle2?.
              copyWith(fontWeight: FontWeight.bold)
          )).toList().sublist(0, bookDetail.length - 1),

          Text(
            bookDetail.last,
            style: Theme.of(context)
                .textTheme
                .subtitle2
                ?.copyWith(
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
