part of 'news_bloc.dart';

abstract class NewsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class NewsSearchRequested extends NewsEvent {
  final String query;
  NewsSearchRequested(this.query);
  @override
  List<Object?> get props => [query];
}

class NewsLoadMoreRequested extends NewsEvent {}
