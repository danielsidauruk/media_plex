import 'package:flutter/material.dart';
import 'package:media_plex/media_plex/books/presentation/pages/book_home_page.dart';
import 'package:media_plex/media_plex/movie/presentation/pages/movie_home_page.dart';

class HomePage extends StatelessWidget {
  static const routeName = '/homePageRoute';
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: const Text(
          'MEDIA PLEX',
        ),
      ),
      body: buildBody(context),
    );
  }

  SingleChildScrollView buildBody(context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.all(4.0),
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(color: Colors.white),
              ),
              child: Text(
                'MEDIA PLEX is a App to provide an information about Movie, Series, and Book around the world.',
                style: Theme.of(context)
                    .textTheme
                    .subtitle2
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
            ),

            homeTile(
              context,
                  () {},
              'Repository',
              const Icon(Icons.bookmark_border),
              'assets/images/repository.png',
              'All the books, movies, or series that you marked are here.',
            ),

            const SizedBox(height: 24.0),

            homeTile(
              context,
                  () => Navigator.pushNamed(context, BookHomePage.routeName),
              'Books',
              const Icon(Icons.arrow_forward),
              'assets/images/book_icon.png',
              'Here you can find all the information about your favorite books.',
            ),

            homeTile(
              context,
                  (){},
              'Movies',
              const Icon(Icons.arrow_forward),
              'assets/images/movie_icon.png',
              'Here you can find all the information about the latest and greatest films.',
            ),

            homeTile(
              context,
                  () {},
              'Series',
              const Icon(Icons.arrow_forward),
              'assets/images/tv_icon.png',
              'Here you can find all the information about your favorite TV shows.',
            ),
          ],
        ),
      ),
    );
  }

  InkWell homeTile(
      context, 
      Function() destination,
      String title,
      Icon icon,
      String assets, 
      String description,
      )
  {
    return InkWell(
      onTap: destination,
      child: Container(
        margin: const EdgeInsets.all(4.0),
        padding: const EdgeInsets.all(8.0),
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: Colors.white)
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),

                icon,
              ],
            ),

            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 1,
                  child: Image.asset(
                    assets,
                    width: 50,
                  ),
                ),

                const SizedBox(width: 8.0,),

                Expanded(
                  flex: 4,
                  child: Text(
                    description,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
