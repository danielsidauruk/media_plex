import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_plex/core/utils/constants.dart';
import 'package:media_plex/media_plex/books/presentation/bloc/popular_bloc/popular_bloc.dart';

class BookPopularPage extends StatefulWidget {
  static const routeName = 'bookPopularPageRoute';
  const BookPopularPage({super.key});

  @override
  State<BookPopularPage> createState() => _BookPopularPageState();
}

class _BookPopularPageState extends State<BookPopularPage> {

  @override
  void initState() {
    super.initState();
    return BlocProvider.of<PopularBloc>(context, listen: false)
        .add(const GetForPopular('daily'));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: Text(
          'Popular Books',
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
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'Trending on : ',
                  style: Theme.of(context)
                      .textTheme.subtitle1
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),

                Container(
                  alignment: Alignment.center,
                  width: 100,
                  padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                  child: Text('Daily'),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(color: Colors.white)
                  ),
                )
              ],
            ),

            SizedBox(height: 8),

            Expanded(
              child: Container(
                margin: const EdgeInsets.all(4.0),
                child: BlocBuilder<PopularBloc, PopularState>(
                  builder: (context, state) {
                    if (state is PopularEmpty) {
                      return const Center();
                    } else if (state is PopularLoading) {
                      return searchLoadingAnimation();
                    } else if (state is PopularLoaded) {
                      final books = state.popular.works;

                      // return GridView.builder(
                      //   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      //     crossAxisCount: 2,
                      //   ),
                      //   itemCount: books.length,
                      //   itemBuilder: (context, index) {
                      //     return Container(
                      //       height: size.height * .4,
                      //       child: Column(
                      //         children: [
                      //           CachedNetworkImage(
                      //             width: 80,
                      //             fit: BoxFit.cover,
                      //             imageUrl: mediumImageByCoverI('${books[index].coverI}'),
                      //             placeholder: (context, url) =>
                      //                 Center(
                      //                   child: Container(
                      //                     color: Colors.grey,
                      //                     width: 60,
                      //                     height: 100,
                      //                   ),
                      //                 ),
                      //             errorWidget: (context, url, error) =>
                      //                 Image.asset(
                      //                   'assets/images/404_not_found.png',
                      //                 ),
                      //           ),
                      //
                      //           Text(
                      //             textAlign: TextAlign.center,
                      //             books[index].title,
                      //             style: Theme.of(context).textTheme.subtitle2
                      //                 ?.copyWith(fontWeight: FontWeight.w400),
                      //             overflow: TextOverflow.ellipsis,
                      //             maxLines: 1,
                      //           ),
                      //         ],
                      //       ),
                      //     );
                      //   },
                      // );

                      return ListView.builder(
                        itemCount: books.length,
                        itemBuilder: (context, index) {
                          return Container(
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
                                  width: 80,
                                  fit: BoxFit.fill,
                                  imageUrl: mediumImageByCoverI('${books[index].coverI}'),
                                  placeholder: (context, url) =>
                                  Center(
                                    child: Container(
                                      color: Colors.grey,
                                      width: 60,
                                      height: 80,
                                    ),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      Image.asset(
                                        'assets/images/404_not_found.png',
                                      ),
                                ),

                                SizedBox(width: 8.0,),

                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        textAlign: TextAlign.start,
                                        books[index].title,
                                        style: Theme.of(context).textTheme.subtitle1
                                            ?.copyWith(fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        width: double.infinity,
                                        child: ListView.builder(
                                          shrinkWrap: true,
                                          physics: const ScrollPhysics(),
                                          itemCount: books[index].authorName.length,
                                          itemBuilder: (context, authorIndex) {
                                            return Text(
                                              textAlign: TextAlign.start,
                                              books[index].authorName[authorIndex],
                                              style: Theme.of(context).textTheme.subtitle2,
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                      );

                    } else if (state is PopularError) {
                      return Text(state.message);
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [

                Text('Now'),
                Container(
                  padding: EdgeInsets.all(4.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    border: Border.all(color: Colors.white)
                  ),
                  child: Text('Today', style: TextStyle(fontWeight: FontWeight.bold),),
                ),
                Text('This Week'),
                Text('This Month'),
                Text('This Year'),
                Text('All Time'),
              ],
            ),
          ],
        ),
      )
    );
  }

  Column searchLoadingAnimation() {
    return Column(
      children: [
        verticalLoadingTile(),

        const SizedBox(height: 4.0,),

        verticalLoadingTile(),

        const SizedBox(height: 4.0,),

        verticalLoadingTile(),

        const SizedBox(height: 4.0,),

        verticalLoadingTile(),
      ],
    );
  }

  Container verticalLoadingTile() {
    return Container(
      width: double.infinity,
      height: 100,
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(8.0),
      ),
    );
  }
}
