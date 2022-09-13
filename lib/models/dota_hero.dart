import 'package:flutter/material.dart';

enum DotaHeroAttribute {
  str,
  agi,
  int,
}

class DotaHero {
  final int id;
  final String? name;
  final String? localizedName;
  final String? primaryAttr;
  final String? attackType;
  // final List<String>? roles;
  final int? legs;
  final String? img;

  const DotaHero({
    required this.id,
    required this.name,
    required this.localizedName,
    required this.primaryAttr,
    required this.attackType,
    // required this.roles,
    required this.legs,
    required this.img,
  });

  String imageUrl() {
    return 'https://api.opendota.com$img';
  }

  Color attrColor() {
    switch (primaryAttr) {
      case 'str':
        return Colors.red;
      case 'agi':
        return Colors.green;
      case 'int':
        return Colors.blue;
      default:
        return Colors.white;
    }
  }

  factory DotaHero.fromJson(Map<String, dynamic> json) {
    return DotaHero(
      id: json['id'] as int,
      name: json['name'] as String?,
      localizedName: json['localized_name'] as String?,
      primaryAttr: json['primary_attr'] as String?,
      attackType: json['attack_type'] as String?,
      // roles: json['roles'] as List<String>,
      legs: json['legs'] as int?,
      img: json['img'] as String?,
    );
  }
}
