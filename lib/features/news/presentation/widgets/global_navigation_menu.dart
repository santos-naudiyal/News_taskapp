import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/features/news/bloc/news_bloc.dart';
import 'package:news_app/features/news/bloc/news_event.dart';

class GlobalNavigationMenu extends StatelessWidget {
  final bool isHome;
  final Widget? customIcon;

  const GlobalNavigationMenu({
    super.key,
    this.isHome = false,
    this.customIcon,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      icon: customIcon ??
          Icon(
            Icons.more_vert,
            color: Theme.of(context).textTheme.bodyLarge?.color,
          ),
      onSelected: (value) {
        if (value == 'refresh') {
          context.read<NewsBloc>().add(const RefreshCurrentCategory());
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Refreshing news feed...'),
              duration: Duration(seconds: 1),
            ),
          );
        } else if (value == 'home') {
          Navigator.of(context).popUntil((route) => route.isFirst);
        }
      },
      itemBuilder: (BuildContext context) {
        return [
          const PopupMenuItem<String>(
            value: 'refresh',
            child: Row(
              children: [
                Icon(Icons.refresh, size: 20),
                SizedBox(width: 8),
                Text('Refresh Feed'),
              ],
            ),
          ),
          if (!isHome)
            const PopupMenuItem<String>(
              value: 'home',
              child: Row(
                children: [
                  Icon(Icons.home_outlined, size: 20),
                  SizedBox(width: 8),
                  Text('Go Home'),
                ],
              ),
            ),
        ];
      },
    );
  }
}
