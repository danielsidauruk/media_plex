import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_plex/core/utils/constants.dart';
import 'package:media_plex/media_plex/books/domain/entities/book_popular.dart';
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
            popularTile(size, context),
            Container(
              margin: const EdgeInsets.all(4.0),
              padding: const EdgeInsets.all(8.0),
              width: size.width,

              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(color: Colors.white),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Browse by Subject',
                    style: Theme.of(context)
                        .textTheme.subtitle1
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 12),
                  
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      subjectIcon(context, 'Arts', 'art_icon.png'),
                      subjectIcon(context, 'Animals', 'animals_icon.png'),
                      subjectIcon(context, 'Fiction', 'fiction_icon.png'),
                    ],
                  ),

                  const SizedBox(height: 12),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      subjectIcon(context, "Social", 'social_n_science_icon.png'),
                      subjectIcon(context, "Children's", 'children_icon.png'),
                      subjectIcon(context, 'History', 'history_icon.png'),
                    ],
                  ),

                  const SizedBox(height: 12),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      subjectIcon(context, 'Biography', 'biography_icon.png'),
                      subjectIcon(context, 'Places', 'Places_icon.png'),
                      subjectIcon(context, 'Textbooks', 'text_book_icon.png')
                    ],
                  ),

                  const SizedBox(height: 12),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      subjectIcon(context, 'Business & Finance', 'business_n_finance_icon.png'),
                      subjectIcon(context, 'Health & Wellness', 'health_n_wellness_icon.png'),
                      subjectIcon(context, 'Science &\nMathematics', 'math_icon.png'),
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

  InkWell subjectIcon(context, String subjectName, String iconAssets) {
    return InkWell(
      onTap: (){},
      child: SizedBox(
        width: 85,
        child: Column(
          children: [
            Text(
              subjectName,
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme.subtitle2
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),

            Image.asset('assets/icons/$iconAssets', width: 46,),
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

  Container popularTile(Size size, BuildContext context) {
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
                'Popular Books - Daily',
                style: Theme.of(context)
                    .textTheme.subtitle1
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),

              InkWell(
                onTap: () => Navigator.pushNamed(context, BookSearchPage.routeName),
                child: const Icon(Icons.arrow_forward),
              ),
            ],
          ),

          BlocBuilder<PopularBloc, PopularState>(
            builder: (context, state) {
              if (state is PopularEmpty) {
                return const Center();
              } else if (state is PopularLoading) {
                return loadingAnimation(
                  boxHeight: 150,
                  imageWidth: 80,
                );
              } else if (state is PopularLoaded) {
                final books = state.popular.works;
                return popularBookResult(books: books);
              } else if (state is PopularError) {
                return Text(state.message);
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }

  SizedBox popularBookResult({required List<Work> books}) {
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
              imageUrl: mediumImageByCoverI('${books[index].coverI}'),
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
  }

  SizedBox loadingAnimation({required double boxHeight, required double imageWidth}) {
    return SizedBox(
      height: boxHeight,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 4,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: imageWidth,
              height: 126,
              color: Colors.grey,
            ),
          );
        },
      ),
    );
  }
}
