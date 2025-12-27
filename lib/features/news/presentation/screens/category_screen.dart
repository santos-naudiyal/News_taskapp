import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/features/news/bloc/news_bloc.dart';
import 'package:news_app/features/news/bloc/news_event.dart';
import 'package:news_app/features/news/bloc/news_state.dart';

import '../widgets/article_card.dart';
import 'article_screen.dart';

class CategoryScreen extends StatefulWidget {
  final String? category;
  final String title;
  final bool isSearch;

  const CategoryScreen({
    super.key,
    this.category,
    required this.title,
    this.isSearch = false,
  });

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounce;

  bool _hasSearched = false;

  @override
  void initState() {
    super.initState();

    /// Load category ONLY for category mode
    if (!widget.isSearch && widget.category != null) {
      context.read<NewsBloc>().add(FetchNews(category: widget.category!));
    }

    /// Pagination ONLY for category mode
    if (!widget.isSearch) {
      _scrollController.addListener(_onScroll);
    }
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 300) {
      context.read<NewsBloc>().add(FetchNews(category: widget.category!));
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  Future<void> _onRefresh() async {
    if (widget.isSearch) return;

    context.read<NewsBloc>().add(RefreshNews(category: widget.category!));
  }

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      if (!mounted) return;
      if (query.trim().isEmpty) {
        setState(() => _hasSearched = false);
        return;
      }

      setState(() => _hasSearched = true);
      context.read<NewsBloc>().add(SearchNews(query: query.trim()));
    });
  }

  void _clearSearch() {
    _searchController.clear();
    setState(() => _hasSearched = false);
    // Optional: Reset bloc state if needed, or just let UI show empty state
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
            expandedHeight: 120,
            pinned: true,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            elevation: 0,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Theme.of(context).textTheme.bodyLarge?.color,
              ),
              onPressed: () => Navigator.pop(context),
            ),
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: const EdgeInsets.only(left: 16, bottom: 16),
              title: Text(
                widget.title,
                style: GoogleFonts.playfairDisplay(
                  color: Theme.of(context).textTheme.bodyLarge?.color,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
          ),
        ],
        body: Column(
          children: [
            /// ---------------- SEARCH BAR ----------------
            if (widget.isSearch)
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                child: TextField(
                  controller: _searchController,
                  textInputAction: TextInputAction.search,
                  autofocus: true,
                  decoration: InputDecoration(
                    hintText: 'Search news...',
                    hintStyle: GoogleFonts.poppins(fontSize: 14),
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: _searchController.text.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: _clearSearch,
                          )
                        : null,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Theme.of(context).cardColor,
                  ),
                  onChanged: (val) {
                    setState(() {}); // specific for suffix icon visibility
                    _onSearchChanged(val);
                  },
                  onSubmitted: (query) {
                    _onSearchChanged(query);
                  },
                ),
              ),

            /// ---------------- CONTENT ----------------
            Expanded(
              child: BlocBuilder<NewsBloc, NewsState>(
                builder: (context, state) {
                  /// 🔹 SEARCH EMPTY STATE
                  if (widget.isSearch && !_hasSearched) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.search,
                            size: 64,
                            color: Colors.grey.shade300,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Type something to search news',
                            style: GoogleFonts.poppins(color: Colors.grey),
                          ),
                        ],
                      ),
                    );
                  }

                  if (state is NewsLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (state is NewsError) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.error_outline,
                            size: 48,
                            color: Colors.red.shade300,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            state.message,
                            style: GoogleFonts.poppins(color: Colors.grey),
                          ),
                        ],
                      ),
                    );
                  }

                  if (state is NewsSuccess) {
                    if (state.articles.isEmpty) {
                      if (widget.isSearch && !_hasSearched)
                        return const SizedBox.shrink();

                      return Center(
                        child: Text(
                          'No results found',
                          style: GoogleFonts.poppins(color: Colors.grey),
                        ),
                      );
                    }

                    return RefreshIndicator(
                      onRefresh: _onRefresh,
                      child: ListView.builder(
                        padding: EdgeInsets.zero,
                        controller: widget.isSearch ? null : _scrollController,
                        itemCount: widget.isSearch
                            ? state.articles.length
                            : state.hasReachedMax
                            ? state.articles.length
                            : state.articles.length + 1,
                        itemBuilder: (context, index) {
                          if (!widget.isSearch &&
                              index >= state.articles.length) {
                            return const Padding(
                              padding: EdgeInsets.all(16),
                              child: Center(child: CircularProgressIndicator()),
                            );
                          }

                          final article = state.articles[index];
                          return ArticleCard(
                            article: article,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                      ArticleScreen(article: article),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    );
                  }

                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
