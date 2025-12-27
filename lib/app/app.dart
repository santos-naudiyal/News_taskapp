import 'package:flutter/material.dart';
import 'package:news_app/core/theme/app_theme.dart';
import 'package:news_app/features/news/data/services/app_settings.dart';
import 'package:provider/provider.dart';

import 'app_router.dart';


class NewsApp extends StatelessWidget {
  const NewsApp({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<AppSettings>();

    return MaterialApp(
      title: 'Daily News',
      debugShowCheckedModeBanner: false,

      /// ---------------- THEME ----------------
      theme: settings.darkMode
          ? ThemeData.dark(useMaterial3: true)
          : AppTheme.lightTheme,

      /// ---------------- FONT SCALE ----------------
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(
            textScaleFactor: settings.fontScale,
          ),
          child: child!,
        );
      },

      /// ---------------- ROUTING ----------------
      initialRoute: AppRouter.home,
      onGenerateRoute: AppRouter.onGenerateRoute,
    );
  }
}
