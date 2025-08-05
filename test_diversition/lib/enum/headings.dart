import 'package:flutter/material.dart';

enum Headings {
  /// h1 : font size 18 font weight bold (700)
  h1,

  /// h2 : font size 16 font weight bold (700)
  h2,

  /// h3 : font size 16 font weight normal (400)
  h3,

  /// normal : font size 14 font weight normal (400)
  normal,

  /// detail : font size 14 font weight small (100)
  detail,

  /// body : font size 14 font weight normal (400)
  body,

  /// tabs : font size 14 font weight bold (700)
  tabs,

  /// subbody : font size 14 font weight normal (400)
  subbody,

  /// subbodybold : font size 14 font weight bold (700)
  subbodybold,
}

enum FontType { normal, large, extraLarge }

extension FontTypeSizePlusExtention on FontType {
  Size get sizePlus {
    switch (this) {
      case FontType.normal:
        return const Size(0, 0);
      case FontType.large:
        return const Size(2, 2);
      case FontType.extraLarge:
        return const Size(4, 4);
    }
  }
}
