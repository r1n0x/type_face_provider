import 'dart:io';

import 'package:type_face_provider/src/model.dart';
import 'package:type_face_provider/src/provider/linux.dart';

abstract class TypefacesProvider {
  const TypefacesProvider();

  static TypefacesProvider get platform => _instance;

  static final TypefacesProvider _instance = TypefacesProvider._setPlatform();

  factory TypefacesProvider._setPlatform() {
    if (Platform.isLinux) {
      return LinuxTypefacesProvider();
    } else if (Platform.isWindows) {
      throw UnimplementedError(
        'Current platform "${Platform.operatingSystem}" is not supported by $TypefacesProvider and it will be supported in the future.',
      );
    } else {
      throw UnimplementedError(
        'Current platform "${Platform.operatingSystem}" is not supported by $TypefacesProvider and there are no plans for it.',
      );
    }
  }

  Future<Typefaces> getTypefaces();
}
