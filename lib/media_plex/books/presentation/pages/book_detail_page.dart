import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:media_plex/core/utils/constants.dart';
import 'package:media_plex/media_plex/books/domain/entities/book_detail.dart';
import 'package:media_plex/media_plex/books/presentation/bloc/book_detail_bloc/book_detail_bloc.dart';
import 'package:media_plex/media_plex/books/presentation/bloc/bookmark_bloc/bookmark_bloc.dart';

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
          .add(FetchBookDetail(widget.bookKey));
      BlocProvider.of<BookmarkBloc>(context, listen: false)
          .add(LoadBookmarkStatus(widget.bookKey));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),

      body: BlocBuilder<BookDetailBloc, BookDetailState>(
        builder: (context, state) {
          if (state is BookDetailLoading) {
            return bookDetailLoadingAnimation();
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

  Padding bookDetailLoadingAnimation() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [

          Container(
            width: 200,
            height: 305,
            color: Colors.grey,
          ),

          const SizedBox(height: 8.0),

          Container(
            width: 300,
            height: 40,
            color: Colors.grey,
          ),

          const SizedBox(height: 4.0),

          Container(
            width: 260,
            height: 30,
            color: Colors.grey,
          ),

          const SizedBox(height: 8.0),

          Container(
            width: 110,
            height: 40,
            color: Colors.grey,
          ),

          const SizedBox(height: 8.0),

          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              width: 120,
              height: 30,
              color: Colors.grey,
            ),
          ),

          const SizedBox(height: 4.0),

          Container(
            width: double.infinity,
            height: 120,
            color: Colors.grey,
          ),
        ],
      ),
    );
  }

  SingleChildScrollView buildDetailBook(BookDetail book, context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [

            book.covers.isNotEmpty ?
            CachedNetworkImage(
              width: 200,
              imageUrl: largeImage(book.covers[0].toString()),
              placeholder: (context, url) => Container(
                width: 200,
                height: 305,
                color: Colors.grey,
              ),
              errorWidget: (context, url, error) => Image.asset(
                'assets/images/not_applicable_icon.png',
              ),
            ) :
            Center(
              child: Image.asset('assets/images/not_applicable_icon.png'),
            ),

            const SizedBox(height: 2.0),

            Text(
              book.title,
              style: Theme.of(context).textTheme.bodyLarge
                  ?.copyWith(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 2.0),

            Text(
              'First published in ${DateFormat.yMMMd().format(book.created.value)}',
              style: Theme.of(context).textTheme.bodyMedium
                  ?.copyWith(color: Colors.grey, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 8.0),

            bookmarkBloc(book),

            const SizedBox(height: 8.0),

            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Subject',
                style: Theme.of(context).textTheme.subtitle1?.
                copyWith(fontWeight: FontWeight.bold),
              ),
            ),

            Row(
              children: [
                book.subjects.isNotEmpty ?
                wrapText(book.subjects) :
                const Center(),
              ],
            ),

            const SizedBox(height: 8.0),

            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Book Description',
                style: Theme.of(context).textTheme.subtitle1?.
                copyWith(fontWeight: FontWeight.bold),
              ),
            ),

            Text(book.description.value),

            const SizedBox(height: 8.0),

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
    );
  }

  BlocConsumer<BookmarkBloc, BookmarkState> bookmarkBloc(BookDetail book) {
    return BlocConsumer<BookmarkBloc, BookmarkState>(
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
          child: Container(
            width: 110,
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(color: Colors.white),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                if (state is BookmarkStatusHasData)
                  if (state.isAdded == false)
                    const Icon(Icons.bookmark_border)
                  else if (state.isAdded == true)
                    const Icon(Icons.bookmark),
                const Text(
                  'Bookmark',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Expanded wrapText(List<String> bookDetail) {
    String text = bookDetail.join(', ');

    return Expanded(
      child: RichText(
        text: TextSpan(
          text: text,
        ),
      ),
    );
  }
}