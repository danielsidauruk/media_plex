import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_plex/books/presentation/bloc/search_bloc/search_bloc.dart';
import 'package:media_plex/books/presentation/pages/detail_page.dart';
import 'package:media_plex/core/constant.dart';
import 'package:media_plex/home_page.dart';

class BookHomePage extends StatelessWidget {
  static const routeName = '/bookHomePageRoute';
  const BookHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,

        title: const Text(
          'MEDIA PLEX',
          style: TextStyle(
            fontFamily: 'Fugaz',
            color: Colors.black,
            fontSize: 18,
          ),
        ),

        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [

              Text(
                'BOOKS',
                style: Theme.of(context).textTheme.headline1?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Fugaz',
                ),
              ),

              Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.all(8.0),
                padding: const EdgeInsets.all(8.0),
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.blueGrey,
                      blurRadius: 5.0,
                      spreadRadius: 1.0,
                    ),
                  ],
                ),
                child: TextField(
                  onChanged: (query) {
                    query != "" ?
                    BlocProvider.of<SearchBloc>(context, listen: false)
                        .add(SearchForBook(query)) :
                    BlocProvider.of<SearchBloc>(context, listen: false)
                        .add(const SearchForBook(""));
                  },
                  style: const TextStyle(),
                  decoration: null,
                ),
              ),

              BlocBuilder<SearchBloc, SearchState>(
                builder: (context, state) {
                  if (state is SearchEmpty) {
                    return const Center();
                  } else if (state is SearchLoading) {
                    return const Text('Loading ...');
                  } else if (state is SearchLoaded) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              'Result : ${state.result.numFound.toString()}',
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),

                        SizedBox(
                          height : size.height * .75,
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
                                    margin: const EdgeInsets.all(8.0),
                                    padding: const EdgeInsets.all(8.0),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(8.0),
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Colors.blueGrey,
                                          blurRadius: 5.0,
                                          spreadRadius: 1.0,
                                        ),
                                      ],
                                    ),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        CachedNetworkImage(
                                          width: 80,
                                          imageUrl: mediumImage(state.result.docs[index].isbn[0]),
                                          placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                                          errorWidget: (context, url, error) => Image.asset('assets/images/404_not_found.png'),
                                        ),

                                        const SizedBox(width: 8.0,),

                                        Expanded(
                                          child: Text(
                                            state.result.docs[index].title,
                                            style: Theme.of(context).textTheme.subtitle1?.copyWith(fontWeight: FontWeight.bold),
                                            textAlign: TextAlign.start,
                                            softWrap: true,
                                          ),
                                        ),

                                        const SizedBox(width: 8.0,),
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
                      ],
                    );
                  } else if (state is SearchError) {
                    return Text(state.message);
                  }
                  return const SizedBox.shrink();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
