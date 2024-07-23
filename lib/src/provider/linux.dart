import 'dart:convert';
import 'dart:io';

import 'package:type_face_provider/src/extensions.dart';
import 'package:type_face_provider/src/fc_list_validator.dart';
import 'package:type_face_provider/src/model.dart';
import 'package:type_face_provider/type_face_provider.dart';

class LinuxTypefacesProvider extends TypefacesProvider {
  LinuxTypefacesProvider();

  static final _fcListValidator = FcListValidator();
  bool? _isFcListInstalled;

  static const _sectionSeparator = '__SECTION_SEPARATOR__';
  static const _lineSeparator = '__LINE_SEPARATOR__';
  static const _filePathSectionIndex = 0;
  static const _nameSectionIndex = 1;
  static const _stylesSectionIndex = 2;
  static const _fullNameSectionIndex = 3;

  @override
  Future<Typefaces> getTypefaces() async {
    await throwIfFcListIsNotInstalled();
    final Process process = await Process.start('fc-list', [
      '--format="%{file}$_sectionSeparator%{family}$_sectionSeparator%{style}$_sectionSeparator%{fullname}$_lineSeparator"'
    ]);

    await process.isFinished;

    final result = Typefaces([]);
    for (final line in await _getFilteredLines(process)) {
      final sections = _parseSections(line);
      final names = sections[_nameSectionIndex]
          .split(',')
          .map((e) => e.trim())
          .toList(growable: false);
      final file = File(sections[_filePathSectionIndex].replaceAll('"', ''));
      final styles = sections[_stylesSectionIndex]
          .split(',')
          .map((e) => e.trim())
          .toList(growable: false);
      final fullNames = sections[_fullNameSectionIndex]
          .split(',')
          .map((e) => e.trim())
          .toList(growable: false);
      result.add(Typeface(names, file, styles, fullNames));
    }
    return result;
  }

  Future<void> throwIfFcListIsNotInstalled() async {
    _isFcListInstalled ??= await _fcListValidator.isInstalled();
    if (!_isFcListInstalled!) {
      throw Exception(
          'In order to use $LinuxTypefacesProvider platform you must have \'fc-list\' installed as your system level dependency.');
    }
  }

  List<String> _parseSections(String line) {
    return line.split(_sectionSeparator).map((e) => e.trim()).toList();
  }

  Future<Iterable<String>> _getFilteredLines(Process process) async {
    return (await process.stdout.transform(utf8.decoder).join(''))
        .split(_lineSeparator)
        .where((element) {
      final isNotLastLine = element != '"';
      return element.isNotEmpty && isNotLastLine;
    });
  }
}
