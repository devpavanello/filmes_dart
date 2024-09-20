import 'package:flutter/material.dart';
import 'package:movie_app/pages/home/home_page.dart';
import 'package:movie_app/pages/now_playing/now_playing_page.dart';
import 'package:movie_app/pages/popular/popular_page.dart';
import 'package:movie_app/pages/search/search_page.dart';
import 'package:movie_app/pages/top_rated/top_rated_page.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int paginaAtual = 0;
  PageController pc = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        body: PageView(
          controller: pc,
          onPageChanged: (page) {
            setState(() {
              paginaAtual = page;
            });
          },
          children: const [
            HomePage(),
            SearchPage(),
            TopRatedPage(),
            NowPlayingPage(),
            PopularPage(),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: paginaAtual,
          iconSize: 30,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
                backgroundColor: Colors.white),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
            BottomNavigationBarItem(
                icon: Icon(Icons.trending_up), label: 'Top Rated'),
            BottomNavigationBarItem(
                icon: Icon(Icons.movie), label: 'Now Playing'),
            BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Popular'),
          ],
          onTap: (pagina) {
            pc.animateToPage(
              pagina,
              duration: const Duration(milliseconds: 400),
              curve: Curves.ease,
            );
          },
        ),
      ),
    );
  }
}
