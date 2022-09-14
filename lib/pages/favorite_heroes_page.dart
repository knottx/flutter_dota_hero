import 'package:flutter/material.dart';
import 'package:flutter_dota_hero/models/dota_hero.dart';
import 'package:flutter_dota_hero/managers/session_manager.dart';
import 'package:flutter_dota_hero/widgets/hero_grid_tile.dart';
import 'package:flutter_dota_hero/pages/hero_detail_page.dart';

class FavoriteHeroes extends StatefulWidget {
  const FavoriteHeroes({super.key});

  @override
  State<FavoriteHeroes> createState() => _FavoriteHeroesState();
}

class _FavoriteHeroesState extends State<FavoriteHeroes> {
  List<DotaHero> get _dataSource {
    return SessionManager().favoritesHeroes;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HEROES'),
        backgroundColor: Colors.grey.shade900,
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 16 / 9,
        ),
        itemCount: _dataSource.length,
        itemBuilder: (context, index) {
          Size size = MediaQuery.of(context).size;
          DotaHero hero = _dataSource[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HeroDetailPage(hero: hero),
                ),
              );
            },
            child: heroGridTile(hero, size.width, _favorite),
          );
        },
      ),
      backgroundColor: Colors.grey.shade800,
    );
  }

  void _favorite(DotaHero hero) {
    SessionManager().favorite(hero);
    setState(() {});
  }
}
