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
        title: const Text("Detail Page"),
      ),
      body: BlocBuilder<BookDetailBloc, BookDetailState>(
        builder: (context, state) {
          if (state is BookDetailLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is BookDetailLoaded) {
            var detail = state.bookDetail;
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(detail.title),
                  Text(detail.key),
                  Text(
                      '${detail.created.value.day} ${monthNames[(detail.created.value.month) - 1]} ${detail.created.value.year}')
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
