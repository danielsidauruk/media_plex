import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_plex/books/presentation/pages/detail_page.dart';
import 'package:media_plex/core/utils.dart';
import 'package:media_plex/dependency_injection.dart' as di;
import 'package:media_plex/books/presentation/bloc/book_detail_bloc/book_detail_bloc.dart';
import 'package:media_plex/books/presentation/bloc/search_bloc/search_bloc.dart';
import 'package:media_plex/books/presentation/pages/book_home_page.dart';

import 'home_page.dart';

void main() async {
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => di.locator<BookDetailBloc>()),
        BlocProvider(create: (_) => di.locator<SearchBloc>()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Media Flex',
        theme: ThemeData(
          fontFamily: 'Roboto',
          scaffoldBackgroundColor: Colors.white,
          textTheme: const TextTheme(
            headline1: TextStyle(fontSize: 56, color: Colors.black),
            headline2: TextStyle(fontSize: 45, color: Colors.grey),
            bodyText1: TextStyle(fontSize: 28, color: Colors.black),
            subtitle1: TextStyle(fontSize: 16, color: Colors.black),
            subtitle2: TextStyle(fontSize: 14, color: Colors.black),
            button: TextStyle(fontWeight: FontWeight.normal, fontSize: 14, color: Colors.black),
          ),
          appBarTheme: const AppBarTheme(
            iconTheme: IconThemeData(color: Colors.blueGrey)
          ),
          colorScheme: const ColorScheme.light(
            primary: Colors.blueGrey,
            secondary: Colors.deepOrangeAccent,
          ),
        ),
        // home: const BookHomePage(),
        home: const HomePage(),
        // home: const DetailPage(bookKey: 'OL17930368W',),

        navigatorObservers: [routeObserver],
        onGenerateRoute: (RouteSettings settings) {
          switch(settings.name) {
            case HomePage.routeName:
              return MaterialPageRoute(builder: (_) => const HomePage());
            case BookHomePage.routeName:
              return MaterialPageRoute(builder: (_) => const BookHomePage());
            case DetailPage.routeName:
              final key = settings.arguments as String;
              return MaterialPageRoute(
                builder: (_) => DetailPage(bookKey: key),
                settings: settings,
              );
            default:
              return MaterialPageRoute(
                builder: (_) {
                  return const Scaffold(
                    body: Center(child: Text('Page not found :(')),
                  );
                },
              );
          }
        },
      ),
    );
  }
}
