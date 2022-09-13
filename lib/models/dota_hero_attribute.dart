import 'package:flutter/material.dart';

enum DotaHeroAttribute {
  str,
  agi,
  int,
}

extension DotaHeroAttributeExtension on DotaHeroAttribute {
  static DotaHeroAttribute? fromString(String? value) {
    return DotaHeroAttribute.values
        .firstWhere((element) => element.name == value);
  }

  Widget attrIcon(double height) {
    return Container(
      height: height,
      decoration: const BoxDecoration(
        color: Colors.black,
        shape: BoxShape.circle,
      ),
      child: attrImage(height),
    );
  }

  Widget attrImage(double height) {
    switch (this) {
      case DotaHeroAttribute.str:
        return Image.asset(
          'assets/images/icons/hero_strength.png',
          height: height,
        );
      case DotaHeroAttribute.agi:
        return Image.asset(
          'assets/images/icons/hero_agility.png',
          height: height,
        );
      case DotaHeroAttribute.int:
        return Image.asset(
          'assets/images/icons/hero_intelligence.png',
          height: height,
        );
      default:
        return Icon(
          Icons.circle,
          color: Colors.grey.shade500,
        );
    }
  }
}
