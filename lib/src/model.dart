import 'dart:io';

import 'package:collection/collection.dart';

class Typeface {
  const Typeface(this.names, this.file, this.styles, this.fonts);

  final List<String> names;
  final File file;
  final List<String> styles;
  final List<String> fonts;
}

class Typefaces extends DelegatingList<Typeface> {
  Typefaces(super.base);
}
