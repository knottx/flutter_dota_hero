import 'package:flutter/material.dart';

enum DotaHeroStat {
  attack,
  defense,
  mobility,
}

enum DotaHeroStatItem {
  damage,
  attackRate,
  attackRange,
  projectileSpeed,
  armor,
  magicResistant,
  movementSpeed,
}

extension DotaHeroStatItemExtension on DotaHeroStatItem {
  Widget imageIcon(double height) {
    switch (this) {
      case DotaHeroStatItem.damage:
        return Image.asset(
          'assets/images/icons/icon_damage.png',
          height: height,
          fit: BoxFit.fill,
        );
      case DotaHeroStatItem.attackRate:
        return Image.asset(
          'assets/images/icons/icon_attack_time.png',
          height: height,
          fit: BoxFit.fill,
        );
      case DotaHeroStatItem.attackRange:
        return Image.asset(
          'assets/images/icons/icon_attack_range.png',
          height: height,
          fit: BoxFit.fill,
        );
      case DotaHeroStatItem.projectileSpeed:
        return Image.asset(
          'assets/images/icons/icon_projectile_speed.png',
          height: height,
          fit: BoxFit.fill,
        );
      case DotaHeroStatItem.armor:
        return Image.asset(
          'assets/images/icons/icon_armor.png',
          height: height,
          fit: BoxFit.fill,
        );
      case DotaHeroStatItem.magicResistant:
        return Image.asset(
          'assets/images/icons/icon_magic_resist.png',
          height: height,
          fit: BoxFit.fill,
        );
      case DotaHeroStatItem.movementSpeed:
        return Image.asset(
          'assets/images/icons/icon_movement_speed.png',
          height: height,
          fit: BoxFit.fill,
        );
    }
  }
}
