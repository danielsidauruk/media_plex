import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
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
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          title: Text(
            'Detail Book',
            style: Theme.of(context).textTheme.bodyText1
                ?.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
        ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(color: Colors.white),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 1000,
                    child: BlocBuilder<BookDetailBloc, BookDetailState>(
                      builder: (context, state) {
                        if (state is BookDetailLoading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (state is BookDetailLoaded) {
                          var bookDetail = state.bookDetail;
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Text(
                                  '${bookDetail.title} (${bookDetail.created.value.year.toString()})',
                                  style: Theme.of(context).textTheme.bodyLarge
                                      ?.copyWith(fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.left,
                                ),
                              ),

                              const SizedBox(height: 2.0),

                              Align(
                                alignment: bookDetail.covers.isNotEmpty
                                    ? Alignment.topRight
                                    : Alignment.topLeft,
                                child: Text(
                                  'First published in ${DateFormat.yMMMd().format(bookDetail.created.value)}',
                                  style: Theme.of(context).textTheme.bodyMedium
                                      ?.copyWith(color: Colors.grey, fontWeight: FontWeight.bold),
                                ),
                              ),

                              const SizedBox(height: 4.0),

                              Align(
                                alignment: Alignment.topCenter,
                                child: bookDetail.covers.isNotEmpty ?
                                CachedNetworkImage(
                                  height: size.height * .46,
                                  fit: BoxFit.fill,
                                  imageUrl: largeImage(bookDetail.covers[0].toString()),
                                  placeholder: (context, url) => Container(
                                    width: 250,
                                    height: size.height * .46,
                                    color: Colors.grey,
                                  ),
                                  errorWidget: (context, url, error) => Image.asset(
                                    'assets/images/not_applicable_icon.png',
                                  ),
                                ) :
                                Column(
                                  children: [
                                    Image.asset(
                                      'assets/images/image_not_available.png',
                                    ),

                                    const Align(
                                      alignment: Alignment.topCenter,
                                      child: Text('No Images Available'),
                                    ),
                                  ],
                                ),
                              ),

                              const SizedBox(height: 4.0),

                              Text(
                                'Last Modified in ${DateFormat.yMMMd().format(bookDetail.lastModified.value)}',
                                style: Theme.of(context).textTheme.bodyMedium
                                    ?.copyWith(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              const SizedBox(height: 4.0),

                              Text(
                                'Subjects',
                                style: Theme.of(context).textTheme.subtitle1?.
                                copyWith(fontWeight: FontWeight.bold),
                              ),

                              bookDetail.subjects.isNotEmpty ?
                              wrapText(bookDetail.subjects, context) :
                              const Text('No subjects available'),

                              Text(
                                'Description',
                                style: Theme.of(context).textTheme.subtitle1?.
                                copyWith(fontWeight: FontWeight.bold),
                              ),

                              Text(bookDetail.description.value),

                              const SizedBox(height: 4.0),

                              bookDetail.covers.isNotEmpty ?
                              Container(
                                padding: const EdgeInsets.all(8.0),
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.0),
                                  border: Border.all(color: Colors.white),
                                ),
                                child: Column(
                                  children: [
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        'Covers',
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle1
                                            ?.copyWith(fontWeight: FontWeight.bold),
                                      ),
                                    ),

                                    SizedBox(
                                      height: 150,
                                      child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: bookDetail.covers.length - 1,
                                        itemBuilder: (context, index) {
                                          return Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: CachedNetworkImage(
                                              width: 80,
                                              fit: BoxFit.fill,
                                              imageUrl: largeImage(bookDetail.covers[index].toString()),
                                              placeholder: (context, url) => Container(
                                                width: 80,
                                                height: 126,
                                                color: Colors.grey,
                                              ),
                                              errorWidget: (context, url, error) => Image.asset(
                                                'assets/images/not_applicable_icon.png',
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ) : const Center(),

                            ],
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
          ...bookDetail.map((item) => Text('$item, '))
              .toList().sublist(0, bookDetail.length - 1),

          Text(bookDetail.last),
        ],
      ) :
      const Center(),
    );
  }
}
















