import 'package:flutter/material.dart';
import 'package:flutter_dota_hero/models/dota_hero.dart';
import 'package:flutter_dota_hero/models/dota_hero_attribute.dart';
import 'package:flutter_dota_hero/models/dota_hero_stat.dart';

class HeroDetailPage extends StatelessWidget {
  const HeroDetailPage({
    super.key,
    required this.hero,
  });

  final DotaHero hero;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(hero.localizedName ?? ''),
        backgroundColor: Colors.grey.shade900,
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

  Widget _attributes() {
    return Padding(
      padding: const EdgeInsets.all(32.0),
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
          Container(
            height: 16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
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
              Container(
                width: 20,
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
      padding: EdgeInsets.all(32),
      child: Row(),
    );
  }

  Widget _stats() {
    double iconHeight = 20;
    return Padding(
      padding: EdgeInsets.all(32),
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
