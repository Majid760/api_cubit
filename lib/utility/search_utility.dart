import 'package:api_cubit/cubit/weather_cubit.dart';
import 'package:api_cubit/cubit/weather_search_cubit.dart';
import 'package:api_cubit/view/screen/page_vew.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomSearchDelegate extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query.length < 3) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Center(
            child: Text(
              "Search term must be longer than two letters.",
            ),
          )
        ],
      );
    } else {
      BlocProvider.of<WeatherSearchCubit>(context).getLatAndLon(query);
      return BlocBuilder<WeatherSearchCubit, WeatherApiSearchState>(
        builder: (context, state) {
          switch (state.status) {
            case ApiSearchStatus.failure:
              return Center(child: Text(state.msgText));
            case ApiSearchStatus.success:
              {
                BlocProvider.of<WeatherCubit>(context)
                    .fetchCurrentWeatherByName(query);
                return BlocListener<WeatherCubit, WeatherApiState>(
                  listener: (context, state) {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (
                            context,
                        ) =>
                                WeatherPageView(
                                    index: state.forecastWeather!.length - 1)));
                  },
                  child: const Center(child: CircularProgressIndicator()),
                );
              }
            default:
              return const Center(child: CircularProgressIndicator());
          }
        },
      );
    }

    //Add the search term to the searchBloc.
    //The Bloc will then handle the searching and add the results to the searchResults stream.
    //This is the equivalent of submitting the search term to whatever search service you are using
    // InheritedBlocs.of(context)
    //     .searchBloc
    //     .searchTerm
    //     .add(query);

    return Text('kdkd');
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // This method is called everytime the search term changes.
    // If you want to add search suggestions as the user enters their search term, this is the place to do that.
    return Column();
  }
}
