import 'package:api_cubit/data/data_provider/api/api_search.dart';
import 'package:api_cubit/data/model/suggestion_model.dart';

class SearchRepository {
  // get the search resutl
  Future<List<Suggestion>> getSearchResult(
      String input, dynamic sessionToken) async {
    try {
      List<Suggestion> suggestions =
          await SearchApi().getSearchResult(input, sessionToken);
      return suggestions;
    } catch (e) {
      throw Exception(e);
    }
  }
}
