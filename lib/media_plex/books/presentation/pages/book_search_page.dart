import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_plex/core/utils/constants.dart';
import 'package:media_plex/media_plex/books/presentation/bloc/search_bloc/search_bloc.dart';
import 'package:media_plex/media_plex/books/presentation/pages/book_detail_page.dart';
import 'package:media_plex/media_plex/books/presentation/widgets/loading_animation.dart';

class BookSearchPage extends StatelessWidget {
  const BookSearchPage({Key? key}) : super(key: key);

  static const routeName = '/bookSearchPageRoute';

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Search books by title and author :',
                style: Theme.of(context)
                    .textTheme
                    .subtitle1
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              Container(
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
                  BlocProvider.of<SearchBloc>(context, listen: false)
                      .add(SearchForBook(query)) :
                  BlocProvider.of<SearchBloc>(context, listen: false)
                      .add(const SearchForBook("")),
                  style: const TextStyle(),
                  decoration: null,
                ),
              ),


              BlocBuilder<SearchBloc, SearchState>(
                builder: (context, state) {
                  if (state is SearchEmpty) {
                    return const Center();
                  } else if (state is SearchLoading) {
                    return const LoadingAnimation();
                  } else if (state is SearchLoaded) {
                    final books = state.result.docs;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              'Result : ${state.result.numFound.toString()}',
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),

                        SizedBox(
                          height: size.height * .75,
                          child: ListView.builder(
                            itemCount: books.length,
                            itemBuilder: (context, index) {
                              try {
                                return InkWell(
                                  onTap: () => Navigator.pushNamed(
                                    context,
                                    DetailPage.routeName,
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
                                                    books[index].title,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .subtitle1
                                                        ?.copyWith(fontWeight: FontWeight.bold),
                                                  ),
                                                  Row(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      const SizedBox(
                                                        width: 25,
                                                        child: Text('By : '),
                                                      ),
                                                      books[index].authorName.isNotEmpty
                                                          ? Expanded(
                                                        child: Wrap(
                                                          direction: Axis.horizontal,
                                                          children: [
                                                            ...books[index]
                                                                .authorName
                                                                .map(
                                                                  (item) => Text(
                                                                '$item, ',
                                                                style: Theme.of(context)
                                                                    .textTheme
                                                                    .subtitle2
                                                                    ?.copyWith(
                                                                    fontWeight:
                                                                    FontWeight.bold),
                                                              ),
                                                            )
                                                                .toList()
                                                                .sublist(
                                                                0,
                                                                books[index].authorName.length -
                                                                    1),
                                                            Text(
                                                              books[index].authorName.last,
                                                              style: Theme.of(context)
                                                                  .textTheme
                                                                  .subtitle2
                                                                  ?.copyWith(
                                                                  fontWeight: FontWeight.bold),
                                                            ),
                                                          ],
                                                        ),
                                                      )
                                                          : const Center(),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              Text(
                                                textAlign: TextAlign.start,
                                                'First published in ${books[index].firstPublishYear}',
                                                style: Theme.of(context).textTheme.labelMedium,
                                              ),
                                            ],
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {},
                                          child: const Icon(Icons.bookmark_border),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              } catch (e) {
                                return const Center();
                              }
                            },
                          ),
                        ),
                      ],
                    );
                  } else if (state is SearchError) {
                    return Text(state.message);
                  }
                  return const SizedBox.shrink();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
