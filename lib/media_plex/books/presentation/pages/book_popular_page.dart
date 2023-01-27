import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_plex/core/utils/constants.dart';
import 'package:media_plex/media_plex/books/domain/entities/book_popular.dart';
import 'package:media_plex/media_plex/books/presentation/bloc/popular_bloc/book_popular_bloc.dart';
import 'package:media_plex/media_plex/books/presentation/pages/book_detail_page.dart';
import 'package:media_plex/shared/presentation/widget/loading_animation.dart';
import 'package:media_plex/shared/presentation/widget/total_text.dart';

class BookPopularPage extends StatefulWidget {
  static const routeName = 'bookPopularPageRoute';
  const BookPopularPage({super.key});

  @override
  State<BookPopularPage> createState() => _BookPopularPageState();
}

class _BookPopularPageState extends State<BookPopularPage> {
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
            style: Theme.of(context).textTheme.bodyText1
                ?.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
        ),

        body: buildBody(context));
  }

  Padding buildBody(BuildContext context) {
    return Padding(
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

                dropDownButton(context),
              ],
            ),

            const SizedBox(height: 8),

            buildPopularBloc(),
          ],
        ),
      );
  }

  Expanded buildPopularBloc() {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4.0),
        child: BlocBuilder<PopularBloc, PopularState>(
          builder: (context, state) {
            if (state is PopularEmpty) {
              return const Center();
            } else if (state is PopularLoading) {
              return const LoadingAnimation();
            } else if (state is PopularLoaded) {
              final books = state.popular.works;
              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: books.length,
                      itemBuilder: (context, index) {
                        return bookTile(books, index, context);
                      },
                    ),
                  ),

                  const SizedBox(height: 8),

                  TotalText(total: books.length, context: context),

                ],
              );
            } else if (state is PopularError) {
              return Text(state.message);
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  Container dropDownButton(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: 100,
      height: 30,
      padding: const EdgeInsets.symmetric(
          vertical: 2.0, horizontal: 8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: Colors.white),
      ),
      child: DropdownButton(
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
    );
  }

  InkWell bookTile(List<Work> books, int index, BuildContext context) {
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

                        const SizedBox(height: 8.0,),

                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('By '),

                            books[index].authorName.isNotEmpty
                                ? wrapText(books[index].authorName, context)
                                : const Center(),
                          ],
                        ),

                        const SizedBox(height: 2.0),

                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Lng : '),
                            books[index].language.isNotEmpty
                                ? wrapText(books[index].language, context)
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