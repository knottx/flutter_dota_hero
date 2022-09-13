import 'package:flutter/material.dart';
import 'package:flutter_dota_hero/models/dota_hero.dart';
import 'package:flutter_dota_hero/models/dota_hero_attribute.dart';

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
                      ),
                    ),
                    Container(
                      alignment: AlignmentDirectional.center,
                      color: Colors.lightBlueAccent,
                      height: 20,
                      child: Text(
                        '${hero.mana().toStringAsFixed(0)}    + ${hero.manaRegen().toStringAsFixed(1)}',
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
                  Row(
                    children: [
                      DotaHeroAttribute.str.attrIcon(24),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        hero.baseStr.toStringAsFixed(0),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        '  + ${hero.strGain}',
                        style: const TextStyle(
                          color: Colors.white60,
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      DotaHeroAttribute.agi.attrIcon(24),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        hero.baseAgi.toStringAsFixed(0),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        '  + ${hero.agiGain}',
                        style: const TextStyle(
                          color: Colors.white60,
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      DotaHeroAttribute.int.attrIcon(24),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        hero.baseInt.toStringAsFixed(0),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        '  + ${hero.intGain}',
                        style: const TextStyle(
                          color: Colors.white60,
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Attack'.toUpperCase(),
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
                    children: [
                      _statItem(
                        Image.asset(
                          'assets/images/icons/icon_damage.png',
                          height: iconHeight,
                        ),
                        '${hero.attackMin().toStringAsFixed(0)}-${hero.attackMax().toStringAsFixed(0)}',
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      _statItem(
                        Image.asset(
                          'assets/images/icons/icon_attack_time.png',
                          height: iconHeight,
                        ),
                        hero.attackRate.toStringAsFixed(1),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      _statItem(
                        Image.asset(
                          'assets/images/icons/icon_attack_range.png',
                          height: iconHeight,
                        ),
                        hero.attackRange.toStringAsFixed(0),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      _statItem(
                        Image.asset(
                          'assets/images/icons/icon_projectile_speed.png',
                          height: iconHeight,
                        ),
                        hero.projectileSpeed.toStringAsFixed(0),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                width: 24,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Defense'.toUpperCase(),
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
                    children: [
                      _statItem(
                        Image.asset(
                          'assets/images/icons/icon_armor.png',
                          height: iconHeight,
                        ),
                        hero.armor().toStringAsFixed(1),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      _statItem(
                        Image.asset(
                          'assets/images/icons/icon_magic_resist.png',
                          height: iconHeight,
                        ),
                        '${hero.baseMr.toStringAsFixed(0)}%',
                      )
                    ],
                  ),
                ],
              ),
              const SizedBox(
                width: 24,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Mobility'.toUpperCase(),
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
                    children: [
                      _statItem(
                        Image.asset(
                          'assets/images/icons/icon_movement_speed.png',
                          height: iconHeight,
                        ),
                        hero.moveSpeed.toStringAsFixed(0),
                      )
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _statItem(Image image, String value) {
    return Row(
      children: [
        image,
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
    );
  }
}
