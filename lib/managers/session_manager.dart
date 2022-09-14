import 'package:flutter_dota_hero/models/dota_hero.dart';

class SessionManager {
  static final SessionManager _instance = SessionManager._internal();

  factory SessionManager() {
    return _instance;
  }

  List<DotaHero> favoritesHeroes = [];

  SessionManager._internal() {
    // initialization logic
  }

  void favorite(DotaHero hero) {
    if (SessionManager().favoritesHeroes.contains(hero)) {
      SessionManager().favoritesHeroes.removeWhere((e) => e.id == hero.id);
    } else {
      SessionManager().favoritesHeroes.add(hero);
    }
  }
}
