import 'dart:io';

import 'package:collection/collection.dart';
import 'package:test/test.dart';
import 'package:type_face_provider/src/provider.dart';

void main() {
  group('Fetching system fonts', () {
    test('Platform - Linux', () async {
      if (!Platform.isLinux) {
        markTestSkipped('Skipped - test can be only ran on Linux.');
        return;
      }

      final provider = TypefacesProvider.platform;
      final typefaces = (await provider.getTypefaces());
      expect(typefaces.isNotEmpty, true,
          reason: "Any system must have at least one font installed!");
      final font = typefaces.firstWhereOrNull((e) =>
          e.file.path == '/usr/share/fonts/truetype/dejavu/DejaVuSansMono.ttf');
      expect(font != null, true,
          reason: 'DejaVu Sans was not found on the system.');
      if (font != null) {
        expect(font.names, ['DejaVu Sans Mono']);
        expect(font.file.path,
            '/usr/share/fonts/truetype/dejavu/DejaVuSansMono.ttf');
        expect(font.styles, ['Book']);
        expect(font.fullNames, ['DejaVu Sans Mono']);
      }
    });
  });
}
