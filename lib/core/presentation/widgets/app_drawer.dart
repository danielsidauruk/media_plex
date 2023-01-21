import 'package:flutter/material.dart';
import 'package:media_plex/core/utils/routes.dart';
import 'package:media_plex/media_plex/movie/presentation/pages/movie_watchlist_page.dart';

class AppDrawer extends StatelessWidget {
  final String route;

  const AppDrawer({
    Key? key,
    required this.route
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          const UserAccountsDrawerHeader(
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage('assets/circle-g.png'),
            ),
            accountName: Text('Ditonton'),
            accountEmail: Text('ditonton@dicoding.com'),
          ),
          // ListTile(
          //   leading: const Icon(Icons.live_tv),
          //   title: const Text('TV Series'),
          //   selected: route == homeTVSeriesRoute,
          //   onTap: () {
          //     Navigator.pushReplacementNamed(
          //         context, homeTVSeriesRoute);
          //   },
          // ),
          ListTile(
            leading: const Icon(Icons.movie),
            title: const Text('Movies'),
            selected: route == homeMovieRoute,
            onTap: () => Navigator.pushReplacementNamed(context, homeMovieRoute),
          ),
          ListTile(
            leading: const Icon(Icons.save_alt),
            title: const Text('Watchlist'),
            onTap: () {
              Navigator.pushNamed(context, WatchlistMoviesPage.routeName);
            },
          ),
          ListTile(
            onTap: () {
              Navigator.pushNamed(context, aboutRoute);
            },
            leading: const Icon(Icons.info_outline),
            title: const Text('About'),
          ),
        ],
      ),
    );
  }
}
