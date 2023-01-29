import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_plex/core/utils/constants.dart';
import 'package:media_plex/core/utils/routes.dart';
import 'package:media_plex/media_plex/books/domain/entities/popular_books.dart';
import 'package:media_plex/media_plex/books/presentation/bloc/popular_books_bloc/book_popular_bloc.dart';
import 'package:media_plex/media_plex/books/presentation/pages/book_subjects_list_page.dart';
import 'package:media_plex/shared/presentation/widget/horizontal_loading_animation.dart';
import 'package:media_plex/shared/presentation/widget/search_tile.dart';
import 'package:media_plex/shared/presentation/widget/sub_heading_tile.dart';

class BookHomePage extends StatefulWidget {
  const BookHomePage({super.key});

  @override
  State<BookHomePage> createState() => _BookHomePageState();
}

class _BookHomePageState extends State<BookHomePage> {
  @override
  void initState() {
    super.initState();
    return BlocProvider.of<PopularBooksBloc>(context, listen: false)
        .add(const FetchPopularBooks('daily'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: Text(
          'Books',
          style: Theme.of(context).textTheme.bodyText1?.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),

        actions: [
          IconButton(
            onPressed: () => Navigator.pushNamed(context, repositoryRoute),
            icon: const Icon(Icons.bookmark_border),
          ),
        ],
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [

              SearchTile(
                context: context,
                title: 'Search your Book',
                routeName: bookSearchRoute,
              ),

              popularTile(context),

              subjectTile(context),
            ],
          ),
        ),
      ),
    );
  }

  Container searchTile(context) {
    return Container(
      margin: const EdgeInsets.all(4.0),
      padding: const EdgeInsets.all(8.0),
      width: double.infinity,
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
                    .textTheme
                    .subtitle1
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              InkWell(
                onTap: () =>
                    Navigator.pushNamed(context, bookSearchRoute),
                child: const Icon(
                  Icons.search,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Container popularTile(context) {
    return Container(
      margin: const EdgeInsets.all(4.0),
      padding: const EdgeInsets.all(8.0),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: Colors.white),
      ),
      child: Column(
        children: [

          SubHeadingTile(context: context, title: 'Popular Books - Daily', routeName: bookPopularRoute),

          BlocBuilder<PopularBooksBloc, PopularBooksState>(
            builder: (context, state) {
              if (state is PopularBooksEmpty) {
                return const Center();
              } else if (state is PopularBooksLoading) {
                return const HorizontalLoadingAnimation();
              } else if (state is PopularBooksLoaded) {
                final books = state.popular.works;
                return popularBookResult(books);
              } else if (state is PopularBooksError) {
                return Text(state.message);
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }

  SizedBox popularBookResult(List<Work> books) {
    return SizedBox(
      height: 150,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () => Navigator.pushNamed(
              context,
              bookDetailRoute,
              arguments: books[index].key,
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CachedNetworkImage(
                width: 80,
                fit: BoxFit.fill,
                imageUrl: mediumImageByCoverI('${books[index].coverI}'),
                placeholder: (context, url) => Container(
                  width: 80,
                  height: 126,
                  color: Colors.grey,
                ),
                errorWidget: (context, url, error) => Image.asset(
                  'assets/images/not_applicable_icon.png',
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Container subjectTile(context) {
    return Container(
      margin: const EdgeInsets.all(4.0),
      padding: const EdgeInsets.all(8.0),
      width: double.infinity,
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
                .textTheme
                .subtitle1
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 14),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              subjectIcon(context, 'Arts', 'art_icon.png', artsSubjects, artsSubjectKey),
              subjectIcon(context, 'Animals', 'animals_icon.png', animalSubjects, animalSubjectsKey),
              subjectIcon(context, 'Fiction', 'fiction_icon.png', fictionSubjects, fictionSubjectsKey),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              subjectIcon(context, "Social", 'social_n_science_icon.png', social, socialKey),
              subjectIcon(context, "Children's", 'children_icon.png', children, childrenKey),
              subjectIcon(context, 'History', 'history_icon.png', history, historyKey),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              subjectIcon(context, 'Biography', 'biography_icon.png', biography, biographyKey),
              subjectIcon(context, 'Places', 'Places_icon.png', places, placesKey),
              subjectIcon(context, 'Business & Finance',
                  'business_n_finance_icon.png', businessAndFinance, businessAndFinanceKey),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              subjectIcon(context, 'Health & Wellness',
                  'health_n_wellness_icon.png', healthAndWellness, healthAndWellnessKey),
              subjectIcon(
                  context, 'Science &\nMathematics', 'math_icon.png', scienceAndMathematics,
                  scienceAndMathematicsKey),
            ],
          ),
        ],
      ),
    );
  }

  InkWell subjectIcon(context, String subjectName, String iconAssets, List<String> menu, List<String> listKey) {
    return InkWell(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              SubjectsListPage(
                subject: subjectName,
                icon: iconAssets,
                list: menu,
                listKey: listKey,
              ),
        ),
      ),
      child: SizedBox(
        width: 85,
        child: Column(
          children: [
            Text(
              subjectName,
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .subtitle2
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            Image.asset(
              'assets/icons/$iconAssets',
              width: 46,
            ),
          ],
        ),
      ),
    );
  }
}
