import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/features/news/presentation/screens/setting_screen.dart';
import 'package:news_app/features/news/presentation/widgets/category_card.dart';
import 'package:news_app/features/news/presentation/widgets/global_navigation_menu.dart';
import 'package:news_app/features/news/presentation/widgets/searchbar.dart';
import 'category_screen.dart';
import 'bookmark_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const _categories = [
    {'title': 'General', 'key': 'general', 'icon': Icons.public},
    {'title': 'Tech', 'key': 'technology', 'icon': Icons.memory},
    {'title': 'Business', 'key': 'business', 'icon': Icons.domain},
    {'title': 'Sports', 'key': 'sports', 'icon': Icons.directions_run},
    {'title': 'Movies', 'key': 'entertainment', 'icon': Icons.movie_filter},
    {'title': 'Health', 'key': 'health', 'icon': Icons.monitor_heart},
    {'title': 'Science', 'key': 'science', 'icon': Icons.science},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            SliverAppBar(
              floating: true,
              pinned: false,
              snap: true,
              backgroundColor: Colors.transparent,
              elevation: 0,
              centerTitle: false,
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                Text(
                    'Explore News',
                    style: GoogleFonts.playfairDisplay(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: Theme.of(context).textTheme.bodyLarge?.color,
                    ),
                  ),
                ],
              ),
              actions: [
                ///  BOOKMARKS
                IconButton(
                  tooltip: 'Bookmarks',
                  icon: const Icon(Icons.bookmark_outline_rounded),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const BookmarkScreen()),
                    );
                  },
                ),

                ///  SETTINGS
                IconButton(
                  tooltip: 'Settings',
                  icon: const Icon(Icons.settings_outlined),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const SettingsScreen()),
                    );
                  },
                ),
                
                ///  GLOBAL MENU
                const GlobalNavigationMenu(isHome: true),
                const SizedBox(width: 8),
              ],
            ),
          ],
          body: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 16),
                      const SearchBarWidget(),
                      const SizedBox(height: 32),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Categories',
                            style: GoogleFonts.poppins(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          TextButton(
                            onPressed: () {}, // Optional: View all
                            child: Text(
                              'View All',
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ),

              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                sliver: SliverGrid(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    childAspectRatio: 1.6,
                  ),
                  delegate: SliverChildBuilderDelegate((context, index) {
                    final cat = _categories[index];
                    return CategoryCard(
                      title: cat['title'] as String,
                      icon: cat['icon'] as IconData,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => CategoryScreen(
                              category: cat['key'] as String,
                              title: cat['title'] as String,
                            ),
                          ),
                        );
                      },
                    );
                  }, childCount: _categories.length),
                ),
              ),

              const SliverToBoxAdapter(child: SizedBox(height: 32)),
            ],
          ),
        ),
      ),
    );
  }
}



