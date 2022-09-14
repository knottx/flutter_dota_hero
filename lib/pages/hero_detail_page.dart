import 'package:flutter/material.dart';
import 'package:flutter_dota_hero/models/dota_hero.dart';
import 'package:flutter_dota_hero/models/dota_hero_attribute.dart';
import 'package:flutter_dota_hero/models/dota_hero_role.dart';
import 'package:flutter_dota_hero/models/dota_hero_stat.dart';
import 'package:flutter_dota_hero/extensions/string_extension.dart';
import 'package:flutter_dota_hero/managers/session_manager.dart';

class HeroDetailPage extends StatefulWidget {
  const HeroDetailPage({
    super.key,
    required this.hero,
  });

  final DotaHero hero;

  @override
  State<HeroDetailPage> createState() => _HeroDetailPage(hero);
}

class _HeroDetailPage extends State<HeroDetailPage> {
  final DotaHero hero;

  _HeroDetailPage(this.hero);

  bool get _alreadySaved {
    return SessionManager().favoritesHeroes.contains(hero);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(hero.localizedName ?? ''),
        backgroundColor: Colors.grey.shade900,
        actions: [
          IconButton(
            icon: Icon(
              _alreadySaved ? Icons.favorite : Icons.favorite_border,
              color: _alreadySaved ? Colors.red : null,
              semanticLabel: _alreadySaved ? 'Remove from saved' : 'Save',
            ),
            onPressed: _favorite,
            tooltip: 'Favorite',
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _attributes(),
            _roles(),
            _stats(),
          ],
        ),
      ),
      backgroundColor: Colors.grey.shade800,
    );
  }

  void _favorite() {
    if (_alreadySaved) {
      SessionManager().favoritesHeroes.removeWhere((e) => e.id == hero.id);
    } else {
      SessionManager().favoritesHeroes.add(hero);
    }
    setState(() {});
  }

  Widget _attributes() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: [
          Text(
            'Attributes'.toUpperCase(),
            style: const TextStyle(
              color: Colors.white60,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 160,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.network(
                      hero.imageUrl(),
                      height: 90,
                    ),
                    Container(
                      alignment: AlignmentDirectional.center,
                      color: Colors.lightGreenAccent,
                      height: 20,
                      child: Text(
                        '${hero.health().toStringAsFixed(0)}    + ${hero.healthRegen().toStringAsFixed(1)}',
                        style: TextStyle(
                          color: Colors.grey.shade700,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Container(
                      alignment: AlignmentDirectional.center,
                      color: Colors.lightBlueAccent,
                      height: 20,
                      child: Text(
                        '${hero.mana().toStringAsFixed(0)}    + ${hero.manaRegen().toStringAsFixed(1)}',
                        style: TextStyle(
                          color: Colors.grey.shade700,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 24,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _attributeItem(
                    DotaHeroAttribute.str,
                    hero.baseStr,
                    hero.strGain,
                  ),
                  _attributeItem(
                    DotaHeroAttribute.agi,
                    hero.baseAgi,
                    hero.agiGain,
                  ),
                  _attributeItem(
                    DotaHeroAttribute.int,
                    hero.baseInt,
                    hero.intGain,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _attributeItem(DotaHeroAttribute attr, double base, double gain) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          attr.attrIcon(24),
          const SizedBox(
            width: 8,
          ),
          Text(
            base.toStringAsFixed(0),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            '  + ${gain.toStringAsFixed(1)}',
            style: const TextStyle(
              color: Colors.white60,
              fontSize: 14,
              fontWeight: FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  Widget _roles() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: [
          Text(
            'ROLES'.toUpperCase(),
            style: const TextStyle(
              color: Colors.white60,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          Container(
            height: 16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _roleItem(DotaHeroRole.carry),
                  _roleItem(DotaHeroRole.disabler),
                  _roleItem(DotaHeroRole.escape),
                ],
              ),
              const SizedBox(
                width: 24,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _roleItem(DotaHeroRole.support),
                  _roleItem(DotaHeroRole.jungler),
                  _roleItem(DotaHeroRole.pusher),
                ],
              ),
              const SizedBox(
                width: 24,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _roleItem(DotaHeroRole.nuker),
                  _roleItem(DotaHeroRole.durable),
                  _roleItem(DotaHeroRole.initiator),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _roleItem(DotaHeroRole item) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(
            Icons.circle,
            color:
                hero.roles.contains(item) ? Colors.white : Colors.grey.shade800,
          ),
          const SizedBox(
            width: 8,
          ),
          Text(
            item.name.capitalize(),
            style: TextStyle(
                color:
                    hero.roles.contains(item) ? Colors.white : Colors.white60,
                fontSize: 16,
                fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }

  Widget _stats() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          Text(
            'Stats'.toUpperCase(),
            style: const TextStyle(
              color: Colors.white60,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          Container(
            height: 16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _statSection(
                DotaHeroStat.attack,
                [
                  _statItem(
                    DotaHeroStatItem.damage,
                    '${hero.attackMin().toStringAsFixed(0)}-${hero.attackMax().toStringAsFixed(0)}',
                  ),
                  _statItem(
                    DotaHeroStatItem.attackRate,
                    hero.attackRate.toStringAsFixed(1),
                  ),
                  _statItem(
                    DotaHeroStatItem.attackRange,
                    hero.attackRange.toStringAsFixed(0),
                  ),
                  _statItem(
                    DotaHeroStatItem.projectileSpeed,
                    hero.projectileSpeed.toStringAsFixed(0),
                  ),
                ],
              ),
              const SizedBox(
                width: 24,
              ),
              _statSection(
                DotaHeroStat.defense,
                [
                  _statItem(
                    DotaHeroStatItem.armor,
                    hero.armor().toStringAsFixed(1),
                  ),
                  _statItem(
                    DotaHeroStatItem.magicResistant,
                    '${hero.baseMr.toStringAsFixed(0)}%',
                  )
                ],
              ),
              const SizedBox(
                width: 24,
              ),
              _statSection(
                DotaHeroStat.mobility,
                [
                  _statItem(
                    DotaHeroStatItem.movementSpeed,
                    hero.moveSpeed.toStringAsFixed(0),
                  )
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _statSection(DotaHeroStat section, List<Widget> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          section.name.toUpperCase(),
          style: const TextStyle(
            color: Colors.white60,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: items,
        ),
      ],
    );
  }

  Widget _statItem(DotaHeroStatItem item, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          item.imageIcon(20),
          const SizedBox(
            width: 8,
          ),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
