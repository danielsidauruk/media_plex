import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:media_plex/core/utils/constants.dart';
import 'package:media_plex/media_plex/books/presentation/bloc/book_detail_bloc/book_detail_bloc.dart';
import 'package:media_plex/media_plex/movie/presentation/pages/movie_detail_page.dart';

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
      body: BlocBuilder<BookDetailBloc, BookDetailState>(
        builder: (context, state) {
          if (state is BookDetailLoading) {
            return const DetailLoadingAnimation();
          } else if (state is BookDetailLoaded) {
            var bookDetail = state.bookDetail;
            return SafeArea(
              child: Stack(
                children: [
                  CachedNetworkImage(
                    width: double.infinity,
                    imageUrl: largeImage(bookDetail.covers[0].toString()),
                    placeholder: (context, url) => Container(
                      width: double.infinity,
                      height: double.infinity,
                      color: Colors.grey,
                    ),
                    errorWidget: (context, url, error) => Image.asset(
                      'assets/images/not_applicable_icon.png',
                    ),
                  ),

                  Container(
                    margin: const EdgeInsets.only(top: 48 + 8),
                    child: DraggableScrollableSheet(
                      builder: (context, scrollController) {
                        return Container(
                          decoration: const BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(16),
                            ),
                          ),
                          padding: const EdgeInsets.only(
                            left: 16,
                            top: 16,
                            right: 16,
                          ),
                          child: Stack(
                            children: [
                              Container(
                                margin: const EdgeInsets.only(top: 16),
                                child: SingleChildScrollView(
                                  controller: scrollController,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [

                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            flex: 5,
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  bookDetail.title,
                                                  style: Theme.of(context).textTheme.bodyLarge
                                                      ?.copyWith(fontWeight: FontWeight.bold),
                                                ),

                                                Text(
                                                  'First published in ${DateFormat.yMMMd().format(bookDetail.created.value)}',
                                                  style: Theme.of(context).textTheme.bodyMedium
                                                      ?.copyWith(color: Colors.grey, fontWeight: FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                          ),

                                          InkWell(
                                            onTap: (){},
                                            child: Icon(Icons.bookmark_border),
                                          )
                                        ],
                                      ),

                                      const SizedBox(height: 8.0),

                                      // // Bloc Consumer for Bookmark
                                      // Container(
                                      //   width: 110,
                                      //   alignment: Alignment.center,
                                      //   padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 8.0),
                                      //   decoration: BoxDecoration(
                                      //     borderRadius: BorderRadius.circular(8.0),
                                      //     border: Border.all(color: Colors.white),
                                      //   ),
                                      //   child: Row(
                                      //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      //     children: const [
                                      //       Icon(Icons.add),
                                      //       Text(
                                      //         'Watchlist',
                                      //         style: TextStyle(fontWeight: FontWeight.bold),
                                      //       ),
                                      //     ],
                                      //   ),
                                      // ),

                                      const SizedBox(height: 8.0),

                                      Text(
                                        'Subjects',
                                        style: Theme.of(context).textTheme.subtitle1?.
                                        copyWith(fontWeight: FontWeight.bold),
                                      ),

                                      bookDetail.subjects.isNotEmpty ?
                                      Wrap(
                                        direction: Axis.horizontal,
                                        children: [
                                          ...bookDetail.subjects.map((item) => Text('$item, '))
                                              .toList().sublist(0, bookDetail.subjects.length - 1),

                                          Text(bookDetail.subjects.last),
                                        ],
                                      ) :
                                      const Center(),


                                      const SizedBox(height: 8),

                                      Text(
                                        'Description',
                                        style: Theme.of(context).textTheme.subtitle1?.
                                        copyWith(fontWeight: FontWeight.bold),
                                      ),

                                      Text(bookDetail.description.value),

                                      const SizedBox(height: 8),

                                      bookDetail.covers.isNotEmpty ?
                                      Column(
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
                                      ) : const Center(),
                                    ],
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.topCenter,
                                child: Container(
                                  color: Colors.white,
                                  height: 4,
                                  width: 48,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      // initialChildSize: 0.5,
                      minChildSize: 0.25,
                      // maxChildSize: 1.0,
                    ),
                  ),

                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () => Navigator.pop(context),
                  ),
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
    );
  }
}
















