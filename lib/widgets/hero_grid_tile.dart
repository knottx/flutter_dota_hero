import 'package:flutter/material.dart';
import 'package:flutter_dota_hero/managers/session_manager.dart';
import 'package:flutter_dota_hero/models/dota_hero.dart';

Widget heroGridTile(DotaHero hero, double width, Function favorite) {
  bool alreadySaved = SessionManager().favoritesHeroes.contains(hero);

  return Container(
    margin: const EdgeInsets.all(1),
    child: Stack(
      children: [
        Image.network(
          hero.imageUrl(),
          fit: BoxFit.cover,
          width: width - 2,
        ),
        Positioned(
          right: 0,
          top: 0,
          child: IconButton(
            icon: Icon(
              alreadySaved ? Icons.favorite : Icons.favorite_border,
              color: alreadySaved ? Colors.red : Colors.white,
              semanticLabel: alreadySaved ? 'Remove from saved' : 'Save',
            ),
            onPressed: () {
              favorite(hero);
            },
            tooltip: 'Favorite',
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: Container(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                hero.primaryAttrIcon(24),
                const SizedBox(
                  width: 8,
                ),
                Text(
                  hero.localizedName ?? '',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    ),
  );
}
