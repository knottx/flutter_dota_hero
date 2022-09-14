import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dota_hero/models/dota_hero_attribute.dart';
import 'package:flutter_dota_hero/models/dota_hero_role.dart';

class DotaHero {
  final int id;
  final String? name;
  final String? localizedName;
  final DotaHeroAttribute? primaryAttr;
  final String? attackType;
  final List<DotaHeroRole> roles;
  final String? img;
  final double baseHealth;
  final double baseHealthRegen;
  final double baseMana;
  final double baseManaRegen;
  final double baseArmor;
  final double baseMr;
  final double baseAttackMin;
  final double baseAttackMax;
  final double baseStr;
  final double baseAgi;
  final double baseInt;
  final double strGain;
  final double agiGain;
  final double intGain;
  final double attackRange;
  final double projectileSpeed;
  final double attackRate;
  final double moveSpeed;

  const DotaHero({
    required this.id,
    required this.name,
    required this.localizedName,
    required this.primaryAttr,
    required this.attackType,
    required this.roles,
    required this.img,
    required this.baseHealth,
    required this.baseHealthRegen,
    required this.baseMana,
    required this.baseManaRegen,
    required this.baseArmor,
    required this.baseMr,
    required this.baseAttackMin,
    required this.baseAttackMax,
    required this.baseStr,
    required this.baseAgi,
    required this.baseInt,
    required this.strGain,
    required this.agiGain,
    required this.intGain,
    required this.attackRange,
    required this.projectileSpeed,
    required this.attackRate,
    required this.moveSpeed,
  });

  String imageUrl() {
    return 'https://api.opendota.com$img';
  }

  double health() {
    return baseHealth + (baseStr * 20.0);
  }

  double healthRegen() {
    return baseHealthRegen + (baseStr * 0.1);
  }

  double mana() {
    return baseMana + (baseInt * 12.0);
  }

  double manaRegen() {
    return baseManaRegen + (baseInt * 0.05);
  }

  double armor() {
    return baseArmor + (baseAgi * 0.167);
  }

  double attackMin() {
    switch (primaryAttr) {
      case DotaHeroAttribute.str:
        return baseAttackMin + baseStr;
      case DotaHeroAttribute.agi:
        return baseAttackMin + baseAgi;
      case DotaHeroAttribute.int:
        return baseAttackMin + baseInt;
      default:
        return baseAttackMin;
    }
  }

  double attackMax() {
    switch (primaryAttr) {
      case DotaHeroAttribute.str:
        return baseAttackMax + baseStr;
      case DotaHeroAttribute.agi:
        return baseAttackMax + baseAgi;
      case DotaHeroAttribute.int:
        return baseAttackMax + baseInt;
      default:
        return baseAttackMax;
    }
  }

  Widget primaryAttrIcon(double height) {
    return primaryAttr?.attrIcon(height) ??
        Icon(
          Icons.circle,
          color: Colors.grey.shade500,
        );
  }

  factory DotaHero.fromJson(Map<String, dynamic> json) {
    List<String> r = List.from(json['roles']);
    List<DotaHeroRole> roles = [];
    r.forEach((element) {
      DotaHeroRole role = DotaHeroRole.values
          .firstWhere((e) => e.name == element.toLowerCase());
      if (role != null) {
        roles.add(role);
      }
    });
    return DotaHero(
      id: json['id'] as int,
      name: json['name'].toString(),
      localizedName: json['localized_name'].toString(),
      primaryAttr: DotaHeroAttribute.values.firstWhere(
          (element) => element.name == json['primary_attr'].toString()),
      attackType: json['attack_type'].toString(),
      roles: roles,
      img: json['img'].toString(),
      baseHealth: double.parse(json['base_health'].toString()),
      baseHealthRegen: double.parse(json['base_health_regen'].toString()),
      baseMana: double.parse(json['base_mana'].toString()),
      baseManaRegen: double.parse(json['base_mana_regen'].toString()),
      baseArmor: double.parse(json['base_armor'].toString()),
      baseMr: double.parse(json['base_mr'].toString()),
      baseAttackMin: double.parse(json['base_attack_min'].toString()),
      baseAttackMax: double.parse(json['base_attack_max'].toString()),
      baseStr: double.parse(json['base_str'].toString()),
      baseAgi: double.parse(json['base_agi'].toString()),
      baseInt: double.parse(json['base_int'].toString()),
      strGain: double.parse(json['str_gain'].toString()),
      agiGain: double.parse(json['agi_gain'].toString()),
      intGain: double.parse(json['int_gain'].toString()),
      attackRange: double.parse(json['attack_range'].toString()),
      projectileSpeed: double.parse(json['projectile_speed'].toString()),
      attackRate: double.parse(json['attack_rate'].toString()),
      moveSpeed: double.parse(json['move_speed'].toString()),
    );
  }
}
