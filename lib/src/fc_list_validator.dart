import 'dart:convert';
import 'dart:io';

import 'package:type_face_provider/src/extensions.dart';

class FcListValidator {
  const FcListValidator();

  Future<bool> isInstalled() async {
    try {
      final process = await Process.start('fc-list', ['--version']);

      final exitCode = await process.isFinished;

      if (exitCode != 0) {
        return false;
      }

      final String content =
          await process.stderr.transform(utf8.decoder).join('');
      return content.startsWith('fontconfig version');
    } on ProcessException {
      return false;
    }
  }
}
