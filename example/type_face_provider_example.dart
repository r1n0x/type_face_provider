import 'package:type_face_provider/type_face_provider.dart';

void main() async {
  final provider = TypefacesProvider.platform;
  final typefaces = await provider.getTypefaces();

  for (final typeface in typefaces) {
    print('File: \'${typeface.file.path}\'');
    print('\ttypefaces:');
    for (final name in typeface.names) {
      print('\t\t- $name');
    }
    print('\tstyles:');
    for (final style in typeface.styles) {
      print('\t\t- $style');
    }
    print('\tfull names:');
    for (final fullName in typeface.fullNames) {
      print('\t\t- $fullName');
    }

    /// ...
    /// File: '/usr/share/fonts/truetype/dejavu/DejaVuSansMono.ttf'
    /// typefaces:
    ///   - DejaVu Sans Mono
    /// styles:
    ///   - Book
    /// full names:
    ///   - DejaVu Sans Mono
    /// ...
  }
}
