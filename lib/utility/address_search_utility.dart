import 'package:api_cubit/cubit/search_cubit.dart';
import 'package:api_cubit/cubit/weather_search_cubit.dart';
import 'package:api_cubit/data/repository/repo_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddressSearch extends SearchDelegate {
  AddressSearch(this.sessionToken) {}
  final sessionToken;
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        tooltip: 'Clear',
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      tooltip: 'Back',
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return SizedBox();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return BlocBuilder<SearchCubit, SearchState>(builder: (context, state) {
      return FutureBuilder(
        // We will put the api call here
        future: query == ""
            ? null
            : BlocProvider.of<SearchCubit>(context).fetchAddressSuggestions(
                query,
                sessionToken,
              ),
        builder: (context, AsyncSnapshot? snapshot) => query == ''
            ? Container(
                padding: EdgeInsets.all(16.0),
                child: Text('Enter your address'),
              )
            : snapshot!.hasData
                ? ListView.builder(
                    itemBuilder: (context, index) => ListTile(
                      // we will display the data returned from our future here
                      title: Text(snapshot.data[index]),
                      onTap: () {
                        close(context, snapshot.data[index]);
                      },
                    ),
                    itemCount: snapshot.data.length,
                  )
                : Container(child: Text('Loading...')),
      );
    });
  }
}
