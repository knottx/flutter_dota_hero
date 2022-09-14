import 'package:flutter/material.dart';

enum SortBy {
  id,
  alphabet,
}

extension SortByExtension on SortBy {
  Icon icon() {
    switch (this) {
      case SortBy.id:
        return const Icon(Icons.sort);
      case SortBy.alphabet:
        return const Icon(Icons.sort_by_alpha);
    }
  }
}
