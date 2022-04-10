import 'package:api_cubit/data/model/suggestion_model.dart';
import 'package:api_cubit/data/repository/repo_search.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchRepository? searchRepo;
  SearchCubit({@required this.searchRepo}) : super(const SearchState());

// Fetch suggestion
  Future<List<Suggestion>> fetchAddressSuggestions(
    String input,
    dynamic sessionToken,
  ) async {
    return await searchRepo!.getSearchResult(input, sessionToken);
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    // debugPrint('$error, $stackTrace');
    super.onError(error, stackTrace);
  }

// Fetch suggestion
// Future<List<Suggestion>> fetchSuggestions(String input,
//     [String lang = "en"]) async {}
}
