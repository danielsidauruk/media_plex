import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_plex/core/utils/constants.dart';
import 'package:media_plex/media_plex/books/presentation/bloc/book_detail_bloc/book_detail_bloc.dart';

class DetailPage extends StatefulWidget {
  final String bookKey;
  const DetailPage({super.key, required this.bookKey});

  static const routeName = '/detailPageRoute';

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      BlocProvider.of<BookDetailBloc>(context, listen: false)
          .add(GetForBookDetail(widget.bookKey));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: BlocBuilder<BookDetailBloc, BookDetailState>(
                builder: (context, state) {
                  if (state is BookDetailLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is BookDetailLoaded) {
                    var bookDetail = state.bookDetail;
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text(
                            bookDetail.title,
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),

                          Text(bookDetail.authors[0].author.key),

                          Text(bookDetail.authors[0].type.key),

                          Text(bookDetail.type.key),

                          Text(bookDetail.covers[0].toString()),

                          Text(bookDetail.description.type),

                          Text(bookDetail.subjects[0]),

                          Text(state.bookDetail.revision.toString()),
                          Text('Description Value : ${state.bookDetail.description.value}'),


                          Text('${bookDetail.description.value.day} ${monthNames[(bookDetail.description.value.month) - 1]} ${bookDetail.description.value.year}'),

                          Wrap(
                            direction: Axis.horizontal,
                            children: [
                              ...bookDetail.authors.map((item) => Text(
                                  '$item, ',
                                  style: Theme.of(context).textTheme.subtitle2?.
                                  copyWith(fontWeight: FontWeight.bold)
                              )).toList().sublist(0, bookDetail.authors.length - 1),

                              // Text(
                              //   bookDetail.authors.last,
                              //   style: Theme.of(context)
                              //       .textTheme
                              //       .subtitle2
                              //       ?.copyWith(
                              //       fontWeight: FontWeight.bold),
                              // ),
                            ],
                          ),

                          wrapText(bookDetail.subjects, context),

                          CachedNetworkImage(
                            width: 60,
                            fit: BoxFit.fill,
                            imageUrl: largeImage(bookDetail.covers[0].toString()),
                            placeholder: (context, url) => const Center(),
                            errorWidget: (context, url, error) => Image.asset(
                              'assets/images/not_applicable_icon.png',
                            ),
                          ),

                          Text(bookDetail.key),
                          Text('${bookDetail.created.value.day} ${monthNames[(bookDetail.created.value.month) - 1]} ${bookDetail.created.value.year}')
                        ],
                      ),
                    );
                  } else if (state is BookDetailError) {
                    return Text(state.message);
                  } else {
                    return const Center();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Expanded wrapText(List<String> bookDetail, context) {
    return Expanded(
      child: bookDetail.isNotEmpty ?
      Wrap(
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
      ) :
      const Center(),
    );
  }
}
