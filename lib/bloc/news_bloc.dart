import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../model/news_article.dart';
import '../repository/news_repository.dart';
import 'news_bloc.dart';
import '../view/news_screen.dart';

part 'news_event.dart';
part 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final NewsRepository repository;

  NewsBloc({required this.repository}) : super(NewsInitial()) {
    on<NewsSearchRequested>(_onSearch);
    on<NewsLoadMoreRequested>(_onLoadMore);
  }

  String currentQuery = '';
  int currentPage = 1;
  bool isFetching = false;

  void _onSearch(NewsSearchRequested event, Emitter<NewsState> emit) async {
    emit(NewsLoading());
    try {
      currentQuery = event.query;
      currentPage = 1;
      final articles = await repository.fetchNews(currentQuery, currentPage);
      emit(NewsLoaded(articles: articles));
    } catch (e) {
      emit(NewsError(message: e.toString()));
    }
  }

  void _onLoadMore(NewsLoadMoreRequested event, Emitter<NewsState> emit) async {
    if (isFetching || state is! NewsLoaded) return;
    isFetching = true;
    try {
      currentPage++;
      final moreArticles = await repository.fetchNews(currentQuery, currentPage);
      final currentState = state as NewsLoaded;
      emit(NewsLoaded(articles: currentState.articles + moreArticles));
    } catch (e) {
      emit(NewsError(message: e.toString()));
    } finally {
      isFetching = false;
    }
  }
}
