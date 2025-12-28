import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/app/app.dart';
import 'package:news_app/features/news/bloc/news_bloc.dart';
import 'package:news_app/features/news/data/repo/news_repository.dart';
import 'package:news_app/features/news/data/services/app_settings.dart';
import 'package:provider/provider.dart';
import 'package:dio/dio.dart';

import 'core/api/api_client.dart';
import 'core/api/api_endpoints.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final dio = Dio(
    BaseOptions(
      baseUrl: ApiEndpoints.baseUrl,
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 15),
      headers: {
        'Content-Type': 'application/json',
      },
    ),
  );

  /// ---------------- CORE DEPENDENCIES ----------------
  final apiClient = ApiClient(dio);
  final newsRepository = NewsRepository(apiClient);

  /// ---------------- SETTINGS ----------------
  final appSettings = AppSettings();
  await appSettings.load();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: appSettings,
        ),
        BlocProvider(
          create: (_) => NewsBloc(newsRepository),
        ),
      ],
      child: const NewsApp(),
    ),
  );
}
