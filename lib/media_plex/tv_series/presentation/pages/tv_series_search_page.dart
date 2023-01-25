import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:media_plex/core/utils/routes.dart';
import 'package:media_plex/media_plex/books/presentation/widgets/loading_animation.dart';
import 'package:media_plex/media_plex/tv_series/presentation/bloc/tv_series_search_bloc/tv_series_search_bloc.dart';
import 'package:media_plex/media_plex/tv_series/presentation/widgets/tv_series_list.dart';

class TVSeriesSearchPage extends StatelessWidget {
  const TVSeriesSearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: Text(
          'Search TV Series',
          style: Theme.of(context).textTheme.bodyText1?.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
      ),

      body: buildBody(context),
    );
  }

  Padding buildBody(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Text(
            'Search TV Series by name :',
            style: Theme.of(context).textTheme.subtitle1
                ?.copyWith(fontWeight: FontWeight.bold),
          ),

          searchTile(context),

          buildBloc(),
        ],
      ),
    );
  }

  Expanded buildBloc() {
    return Expanded(
      child: BlocBuilder<SearchTVSeriesBloc, SearchState>(
        builder: (context, state) {
          if (state is SearchLoading) {
            return const LoadingAnimation(tileHeight: 80, totalTile: 5);
          } else if (state is SearchHasData) {
            final tvSeriesResult = state.result;
            return TVSeriesList(
              list: tvSeriesResult,
              route: detailTVSeriesRoute,
            );
          } else if (state is SearchError){
            return const Center();
          } else {
            return const Center();
          }
        },
      ),
    );
  }

  Container searchTile(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      padding: const EdgeInsets.all(8.0),
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: Colors.white),
      ),
      child: TextField(
        onChanged: (query) =>
            context.read<SearchTVSeriesBloc>().add(OnQueryChanged(query)),
        style: const TextStyle(),
        decoration: null,
      ),
    );
  }
}
