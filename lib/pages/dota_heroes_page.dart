import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dota_hero/managers/session_manager.dart';
import 'package:flutter_dota_hero/models/sort_by.dart';
import 'package:flutter_dota_hero/models/dota_hero.dart';
import 'package:flutter_dota_hero/models/dota_hero_attribute.dart';
import 'package:flutter_dota_hero/pages/favorite_heroes_page.dart';
import 'package:flutter_dota_hero/pages/hero_detail_page.dart';
import 'package:flutter_dota_hero/widgets/hero_grid_tile.dart';
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
        actions: [
          IconButton(
            icon: const Icon(Icons.list),
            onPressed: () {
              FocusManager.instance.primaryFocus?.unfocus();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const FavoriteHeroes(),
                ),
              );
            },
            tooltip: 'Favorites',
          ),
        ],
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
  String? _keyword;
  SortBy _sortBy = SortBy.id;

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
          child: DotaHeroesHeader(_primaryAttr, _sortBy, _filterPrimaryAttr,
              _filterKeyword, _changeSortBy),
        ),
        Flexible(
          child: DotaHeroesGridView(_dataSource, _favorite),
        ),
      ],
    );
  }

  void _favorite(DotaHero hero) {
    SessionManager().favorite(hero);
    setState(() {});
  }

  void _changeSortBy() {
    _sortBy = _sortBy == SortBy.id ? SortBy.alphabet : SortBy.id;
    _filterDataSource(_primaryAttr, _keyword ?? '', _sortBy);
  }

  void _filterKeyword(String? keyword) {
    _keyword = keyword;
    _filterDataSource(_primaryAttr, _keyword ?? '', _sortBy);
  }

  void _filterPrimaryAttr(DotaHeroAttribute? attr) {
    FocusManager.instance.primaryFocus?.unfocus();
    DotaHeroAttribute? newPrimaryAttr = (_primaryAttr == attr) ? null : attr;
    _filterDataSource(newPrimaryAttr, _keyword ?? '', _sortBy);
  }

  void _filterDataSource(
      DotaHeroAttribute? attr, String keyword, SortBy sortBy) {
    List<DotaHero> newDataSource = [];
    switch (attr) {
      case DotaHeroAttribute.str:
        newDataSource = dotaHeroes
            .where((e) => e.primaryAttr == DotaHeroAttribute.str)
            .where(
                (e) => (e.localizedName?.toLowerCase() ?? '').contains(keyword))
            .toList();
        break;
      case DotaHeroAttribute.agi:
        newDataSource = dotaHeroes
            .where((e) => e.primaryAttr == DotaHeroAttribute.agi)
            .where(
                (e) => (e.localizedName?.toLowerCase() ?? '').contains(keyword))
            .toList();
        break;
      case DotaHeroAttribute.int:
        newDataSource = dotaHeroes
            .where((e) => e.primaryAttr == DotaHeroAttribute.int)
            .where(
                (e) => (e.localizedName?.toLowerCase() ?? '').contains(keyword))
            .toList();
        break;
      default:
        newDataSource = dotaHeroes
            .where(
                (e) => (e.localizedName?.toLowerCase() ?? '').contains(keyword))
            .toList();
        break;
    }

    switch (sortBy) {
      case SortBy.id:
        newDataSource.sort(((a, b) => a.id.compareTo(b.id)));
        break;
      case SortBy.alphabet:
        newDataSource.sort(((a, b) =>
            (a.localizedName ?? '').compareTo((b.localizedName ?? ''))));
        break;
    }
    setState(() {
      _primaryAttr = attr;
      _dataSource = newDataSource;
    });
  }
}

class DotaHeroesHeader extends StatelessWidget {
  final DotaHeroAttribute? primaryAttr;
  final SortBy sortBy;

  final Function filterPrimaryAttr;
  final Function filterKeyword;
  final Function changeSortBy;

  const DotaHeroesHeader(
    this.primaryAttr,
    this.sortBy,
    this.filterPrimaryAttr,
    this.filterKeyword,
    this.changeSortBy,
  );

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
                onChanged: (value) {
                  filterKeyword(value);
                },
              ),
            ),
          ),
          IconButton(
              onPressed: () {
                changeSortBy();
              },
              icon: sortBy.icon()),
        ],
      ),
    );
  }
}

class DotaHeroesGridView extends StatelessWidget {
  final List<DotaHero> dataSource;
  final Function favorite;

  DotaHeroesGridView(this.dataSource, this.favorite);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
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
            FocusManager.instance.primaryFocus?.unfocus();
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HeroDetailPage(hero: hero),
              ),
            );
          },
          child: heroGridTile(hero, size.width, favorite),
        );
      },
    );
  }
}
