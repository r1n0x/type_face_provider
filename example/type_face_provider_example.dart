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
    print('\tfonts:');
    for (final font in typeface.fonts) {
      print('\t\t- $font');
    }

    /// File: '/usr/share/fonts/truetype/noto/NotoSansMono-Bold.ttf'
    ///	typefaces:
    ///		- Noto Sans Mono
    ///	styles:
    ///		- Bold
    ///	fonts:
    ///		- Noto Sans Mono Bold
  }
}
