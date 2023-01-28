import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:media_plex/core/utils/constants.dart';
import 'package:media_plex/media_plex/books/domain/entities/book_detail.dart';
import 'package:media_plex/media_plex/books/presentation/bloc/book_detail_bloc/book_detail_bloc.dart';
import 'package:media_plex/media_plex/books/presentation/bloc/bookmark_bloc/bookmark_bloc.dart';
import 'package:media_plex/media_plex/movie/presentation/pages/movie_detail_page.dart';

class BookDetailPage extends StatefulWidget {
  const BookDetailPage({super.key, required this.bookKey});
  final String bookKey;

  @override
  State<BookDetailPage> createState() => _BookDetailPageState();
}

class _BookDetailPageState extends State<BookDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      BlocProvider.of<BookDetailBloc>(context, listen: false)
          .add(GetForBookDetail(widget.bookKey));
      BlocProvider.of<BookmarkBloc>(context, listen: false)
          .add(LoadBookmarkStatus(widget.bookKey));
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
            return buildDetailBook(bookDetail, context);
          } else if (state is BookDetailError) {
            return Text(state.message);
          } else {
            return const Center();
          }
        },
      ),
    );
  }

  SafeArea buildDetailBook(BookDetail book, context) {
    return SafeArea(
      child: Stack(
        children: [
          book.covers.isNotEmpty ?
          CachedNetworkImage(
            width: double.infinity,
            imageUrl: largeImage(book.covers[0].toString()),
            placeholder: (context, url) => Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.grey,
            ),
            errorWidget: (context, url, error) => Image.asset(
              'assets/images/not_applicable_icon.png',
            ),
          ) :
          Center(
            child: Image.asset('assets/images/not_applicable_icon.png'),
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
                                          book.title,
                                          style: Theme.of(context).textTheme.bodyLarge
                                              ?.copyWith(fontWeight: FontWeight.bold),
                                        ),

                                        Text(
                                          'First published in ${DateFormat.yMMMd().format(book.created.value)}',
                                          style: Theme.of(context).textTheme.bodyMedium
                                              ?.copyWith(color: Colors.grey, fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),

                                  BlocConsumer<BookmarkBloc, BookmarkState>(
                                    listener: (context, state) {
                                      if (state is BookmarkSuccess) {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(content: Text(state.message)),
                                        );
                                      } else if (state is BookmarkFailure) {
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              content: Text(state.message),
                                            );
                                          },
                                        );
                                      }
                                    },
                                    builder: (context, state) {
                                      return InkWell(
                                        onTap: () async {
                                          if (state is BookmarkStatusHasData) {
                                            if (state.isAdded == false) {
                                              context.read<BookmarkBloc>()
                                                  .add(AddBookmark(book));
                                            } else if (state.isAdded == true) {
                                              context.read<BookmarkBloc>()
                                                  .add(DeleteBookmark(book));
                                            }
                                          }
                                        },
                                        // child: state is BookmarkStatusHasData ?
                                        // const Icon(Icons.bookmark) :
                                        // const Icon(Icons.bookmark_border),
                                        child: Column(
                                          children: [
                                            if (state is BookmarkStatusHasData)
                                              if (state.isAdded == true)
                                                const Icon(Icons.bookmark)
                                              else
                                                const Icon(Icons.bookmark_border),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),

                              const SizedBox(height: 8.0),

                              Text(
                                'Subjects',
                                style: Theme.of(context).textTheme.subtitle1?.
                                copyWith(fontWeight: FontWeight.bold),
                              ),

                              book.subjects.isNotEmpty ?
                              Wrap(
                                direction: Axis.horizontal,
                                children: [
                                  ...book.subjects.map((item) => Text('$item, '))
                                      .toList().sublist(0, book.subjects.length - 1),

                                  Text(book.subjects.last),
                                ],
                              ) :
                              const Center(),

                              const SizedBox(height: 8),

                              Text(
                                'Description',
                                style: Theme.of(context).textTheme.subtitle1?.
                                copyWith(fontWeight: FontWeight.bold),
                              ),

                              Text(book.description.value),

                              const SizedBox(height: 8),

                              book.covers.isNotEmpty ?
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
                                      itemCount: book.covers.length - 1,
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: CachedNetworkImage(
                                            width: 80,
                                            fit: BoxFit.fill,
                                            imageUrl: largeImage(book.covers[index].toString()),
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
  }
}