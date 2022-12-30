import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_plex/books/presentation/bloc/search_bloc/search_bloc.dart';
import 'package:media_plex/books/presentation/pages/detail_page.dart';

class BookHomePage extends StatefulWidget {
  static const routeName = '/bookHomePageRoute';
  const BookHomePage({Key? key}) : super(key: key);

  @override
  State<BookHomePage> createState() => _BookHomePageState();
}

class _BookHomePageState extends State<BookHomePage> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Books'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: BlocBuilder<SearchBloc, SearchState>(
              builder: (context, state) {
                if (state is SearchEmpty) {
                  return const Text('Empty');
                } else if (state is SearchLoading) {
                  return const Text('Loading ...');
                } else if (state is SearchLoaded) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'query : ${state.result.q}',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),

                      Text(
                        'result : ${state.result.numFound.toString()}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      SizedBox(
                        height: 500,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListView.builder(
                            itemCount: state.result.docs.length,
                            itemBuilder: (context, index) {
                              try {
                                return InkWell(
                                  onTap: () => Navigator.pushNamed(
                                    context,
                                    DetailPage.routeName,
                                    arguments:state.result.docs[index].key,
                                  ),
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                                    padding: const EdgeInsets.all(8.0),
                                    decoration: BoxDecoration(
                                      border: Border.all(),
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        CachedNetworkImage(
                                          width: 80,
                                          imageUrl: 'https://covers.openlibrary.org/b/isbn/${state.result.docs[index].isbn[0]}-M.jpg',
                                          placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                                          errorWidget: (context, url, error) => const Text('Image No Available'),
                                        ),

                                        const SizedBox(width: 8.0,),

                                        Expanded(
                                          child: Text(
                                            state.result.docs[index].title,
                                            style: Theme.of(context).textTheme.subtitle1,
                                            textAlign: TextAlign.start,
                                            softWrap: true,
                                          ),
                                        ),

                                        const SizedBox(width: 8.0,),

                                        Expanded(
                                          child: Text(
                                            state.result.docs[index].key,
                                            style: Theme.of(context).textTheme.subtitle1,
                                            textAlign: TextAlign.start,
                                            softWrap: true,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              } catch(e) {
                                return const Center();
                              }
                            },
                          ),
                        ),
                      )
                    ],
                  );
                } else if (state is SearchError) {
                  return Text(state.message);
                }
                return const SizedBox.shrink();
              },
            ),
          ),

          const SizedBox(height: 24,),

          InkWell(
            onTap: addBookDetail,
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.indigoAccent,
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(5),
              ),
              child: const Text('Generate more'),
            ),
          ),
        ],
      ),
    );
  }

  void addBookDetail() {
    BlocProvider.of<SearchBloc>(context)
        .add(const SearchForBook('Attack on Titan'));
  }
}
