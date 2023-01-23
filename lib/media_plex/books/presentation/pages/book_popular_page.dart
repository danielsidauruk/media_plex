import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_plex/core/utils/constants.dart';
import 'package:media_plex/media_plex/books/domain/entities/book_popular.dart';
import 'package:media_plex/media_plex/books/presentation/bloc/popular_bloc/popular_bloc.dart';
import 'package:media_plex/media_plex/books/presentation/widgets/loading_animation.dart';

class BookPopularPage extends StatefulWidget {
  static const routeName = 'bookPopularPageRoute';
  const BookPopularPage({super.key});

  @override
  State<BookPopularPage> createState() => _BookPopularPageState();
}

class _BookPopularPageState extends State<BookPopularPage> {
  static const List<String> queryList = [
    'now',
    'daily',
    'weekly',
    'monthly',
    'yearly'
  ];

  String dropdownValue = queryList[1];

  @override
  void initState() {
    super.initState();
    return BlocProvider.of<PopularBloc>(context, listen: false)
        .add(GetForPopular(dropdownValue));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          title: Text(
            'Popular Books',
            style: Theme.of(context).textTheme.bodyText1?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Trending on : ',
                    style: Theme.of(context)
                        .textTheme
                        .subtitle1
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: 100,
                    height: 30,
                    padding: const EdgeInsets.symmetric(
                        vertical: 2.0, horizontal: 8.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(color: Colors.white)),
                    child: DropdownButton<String>(
                      value: dropdownValue,
                      icon: const Icon(
                        Icons.arrow_drop_down,
                        color: Colors.white,
                      ),
                      underline: const Center(),
                      onChanged: (String? value) {
                        setState(() {
                          dropdownValue = value!;
                          BlocProvider.of<PopularBloc>(context, listen: false)
                              .add(GetForPopular(dropdownValue));
                        });
                      },
                      items: queryList
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.all(4.0),
                  child: BlocBuilder<PopularBloc, PopularState>(
                    builder: (context, state) {
                      if (state is PopularEmpty) {
                        return const Center();
                      } else if (state is PopularLoading) {
                        return const LoadingAnimation();
                      } else if (state is PopularLoaded) {
                        final books = state.popular.works;
                        return bookListView(books);
                      } else if (state is PopularError) {
                        return Text(state.message);
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  ListView bookListView(List<Work> books) {
    return ListView.builder(
      itemCount: books.length,
      itemBuilder: (context, index) {
        return Container(
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
        );
      },
    );
  }
}
