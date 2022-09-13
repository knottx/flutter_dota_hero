import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dota_hero/models/dota_hero.dart';
import 'package:flutter_dota_hero/models/dota_hero_attribute.dart';
import 'package:flutter_dota_hero/pages/hero_detail_page.dart';
import 'package:http/http.dart' as http;

List<DotaHero> parseHeroes(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<DotaHero>((json) => DotaHero.fromJson(json)).toList();
}

Future<List<DotaHero>> fetchHeroes(http.Client client) async {
  final response =
      await client.get(Uri.parse('https://api.opendota.com/api/heroStats'));
  return parseHeroes(response.body);
}

class DotaHeroesPage extends StatelessWidget {
  const DotaHeroesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HEROES'),
        backgroundColor: Colors.grey.shade900,
      ),
      body: FutureBuilder<List<DotaHero>>(
        future: fetchHeroes(http.Client()),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text('An error has occurred!'),
            );
          } else if (snapshot.hasData) {
            return DotaHeroesList(dotaHeroes: snapshot.data!);
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      backgroundColor: Colors.grey.shade800,
    );
  }
}

class DotaHeroesList extends StatefulWidget {
  const DotaHeroesList({
    super.key,
    required this.dotaHeroes,
  });

  final List<DotaHero> dotaHeroes;

  @override
  State<DotaHeroesList> createState() => _DotaHeroesList(dotaHeroes);
}

class _DotaHeroesList extends State<DotaHeroesList> {
  final List<DotaHero> dotaHeroes;

  List<DotaHero> _dataSource = [];
  DotaHeroAttribute? _primaryAttr;

  _DotaHeroesList(this.dotaHeroes);

  @override
  void initState() {
    super.initState();
    _dataSource = dotaHeroes;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 64,
          child: DotaHeroesHeader(_primaryAttr, _filterPrimaryAttr),
        ),
        Flexible(
          child: DotaHeroesGridView(_dataSource),
        ),
      ],
    );
  }

  void _filterPrimaryAttr(DotaHeroAttribute? attr) {
    List<DotaHero> newDataSource = [];
    DotaHeroAttribute? newPrimaryAttr = (_primaryAttr == attr) ? null : attr;

    switch (newPrimaryAttr) {
      case DotaHeroAttribute.str:
        newDataSource = dotaHeroes
            .where((e) => e.primaryAttr == DotaHeroAttribute.str)
            .toList();
        break;
      case DotaHeroAttribute.agi:
        newDataSource = dotaHeroes
            .where((e) => e.primaryAttr == DotaHeroAttribute.agi)
            .toList();
        break;
      case DotaHeroAttribute.int:
        newDataSource = dotaHeroes
            .where((e) => e.primaryAttr == DotaHeroAttribute.int)
            .toList();
        break;
      default:
        newDataSource = dotaHeroes;
        break;
    }

    setState(() {
      _primaryAttr = newPrimaryAttr;
      _dataSource = newDataSource;
    });
  }
}

class DotaHeroesHeader extends StatelessWidget {
  final DotaHeroAttribute? primaryAttr;
  final Function filterPrimaryAttr;
  final keywordController = TextEditingController();

  DotaHeroesHeader(this.primaryAttr, this.filterPrimaryAttr);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: [
          SizedBox.fromSize(
            size: const Size(40, 40),
            child: TextButton(
              onPressed: () {
                filterPrimaryAttr(DotaHeroAttribute.str);
              },
              style: TextButton.styleFrom(
                backgroundColor: primaryAttr == DotaHeroAttribute.str
                    ? Colors.red.shade100
                    : null,
              ),
              child: DotaHeroAttribute.str.attrIcon(24),
            ),
          ),
          SizedBox.fromSize(
            size: const Size(40, 40),
            child: TextButton(
              onPressed: () {
                filterPrimaryAttr(DotaHeroAttribute.agi);
              },
              style: TextButton.styleFrom(
                backgroundColor: primaryAttr == DotaHeroAttribute.agi
                    ? Colors.green.shade100
                    : null,
              ),
              child: DotaHeroAttribute.agi.attrIcon(24),
            ),
          ),
          SizedBox.fromSize(
            size: const Size(40, 40),
            child: TextButton(
              onPressed: () {
                filterPrimaryAttr(DotaHeroAttribute.int);
              },
              style: TextButton.styleFrom(
                backgroundColor: primaryAttr == DotaHeroAttribute.int
                    ? Colors.blue.shade100
                    : null,
              ),
              child: DotaHeroAttribute.int.attrIcon(24),
            ),
          ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: TextField(
                decoration: const InputDecoration(labelText: 'Search'),
                controller: keywordController,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class DotaHeroesGridView extends StatelessWidget {
  final List<DotaHero> dataSource;

  DotaHeroesGridView(this.dataSource);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 16 / 9,
      ),
      itemCount: dataSource.length,
      itemBuilder: (context, index) {
        Size size = MediaQuery.of(context).size;
        DotaHero hero = dataSource[index];
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HeroDetailPage(hero: hero),
              ),
            );
          },
          child: _heroGridTile(hero, size.width),
        );
      },
    );
  }

  Widget _heroGridTile(DotaHero hero, double width) {
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
}
