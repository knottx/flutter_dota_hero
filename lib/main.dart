import 'package:flutter/material.dart';
import 'package:flutter_dota_hero/pages/dota_heroes_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Dota Hero',
      home: DotaHeroesPage(),
    );
  }
}
