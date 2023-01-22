import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_plex/core/utils/constants.dart';
import 'package:media_plex/media_plex/books/presentation/bloc/popular_bloc/popular_bloc.dart';
import 'package:media_plex/media_plex/books/presentation/pages/book_search_page.dart';

class BookHomePage extends StatefulWidget {
  static const routeName = '/bookHomePageRoute';
  const BookHomePage({Key? key}) : super(key: key);

  @override
  State<BookHomePage> createState() => _BookHomePageState();
}

class _BookHomePageState extends State<BookHomePage> {

  @override
  void initState() {
    super.initState();
    return BlocProvider.of<PopularBloc>(context, listen: false)
      .add(const GetForPopular());
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: Text(
          'Books',
          style: Theme.of(context)
              .textTheme.bodyText1
              ?.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            searchTile(size, context),
            Container(
              margin: const EdgeInsets.all(4.0),
              padding: const EdgeInsets.all(8.0),
              width: size.width,

              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(color: Colors.white),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Popular Books',
                        style: Theme.of(context)
                            .textTheme.subtitle1
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),

                      InkWell(
                        onTap: () => Navigator.pushNamed(context, BookSearchPage.routeName),
                        child: const Icon(Icons.arrow_forward, color: Colors.white,),
                      ),
                    ],
                  ),

                  BlocBuilder<PopularBloc, PopularState>(
                    builder: (context, state) {
                      if (state is PopularEmpty) {
                        return const Center();
                      } else if (state is PopularLoading) {
                        return const Text('Loading ...');
                      } else if (state is PopularLoaded) {
                        final books = state.popular.works;
                        return SizedBox(
                          height: 150,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            // itemCount: books.length,
                            itemCount: 6,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CachedNetworkImage(
                                  width: 80,
                                  fit: BoxFit.fill,
                                  imageUrl: 'https://covers.openlibrary.org/b/id/${books[index].coverI}-M.jpg',
                                  placeholder: (context, url) =>
                                  const Center(child: CircularProgressIndicator()),
                                  errorWidget: (context, url, error) =>
                                      Image.asset(
                                          'assets/images/404_not_found.png',
                                      ),
                                ),
                              );
                            },
                          ),
                        );
                      } else if (state is PopularError) {
                        return Text(state.message);
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Container searchTile(Size size, BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(4.0),
      padding: const EdgeInsets.all(8.0),
      width: size.width,

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: Colors.white),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Search your Book',
                style: Theme.of(context)
                    .textTheme.subtitle1
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),

              InkWell(
                onTap: () => Navigator.pushNamed(context, BookSearchPage.routeName),
                child: const Icon(Icons.search, color: Colors.white,),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
