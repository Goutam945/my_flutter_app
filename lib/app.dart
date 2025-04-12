import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'repository/news_repository.dart';
import 'bloc/news_bloc.dart';
import 'view/news_screen.dart';

class NewsApp extends StatelessWidget {
  const NewsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'News Search',
      debugShowCheckedModeBanner: false,
      home: RepositoryProvider(
        create: (_) => NewsRepository(),
        child: BlocProvider(
          create: (context) => NewsBloc(
            repository: context.read<NewsRepository>(),
          ),
          child: const NewsScreen(),
        ),
      ),
    );
  }
}
