part of 'search_cubit.dart';

enum SearchStatus {
  initial,
  success,
  loading,
  failure,
}

class SearchState extends Equatable {
  const SearchState(
      {this.status = SearchStatus.initial,
      this.msgText = '',
      this.isConnected = true,
      this.latAndLon = const <String, dynamic>{}});
  final SearchStatus status;
  final String msgText;
  final bool isConnected;
  final Map<String, dynamic>? latAndLon;
  SearchState copyWith(
      {SearchStatus? status,
      String? msgText,
      bool? isConnected,
      Map<String, dynamic>? latAndLon}) {
    return SearchState(
        status: status ?? this.status,
        msgText: msgText ?? this.msgText,
        isConnected: isConnected ?? this.isConnected,
        latAndLon: latAndLon ?? this.latAndLon);
  }

  @override
  List<Object?> get props => [status, msgText, latAndLon, isConnected];
}
