// Windows implementation - use win32 package
// EnumFontFamiliesEx(dc, &lf, (FONTENUMPROCW)[](const LOGFONT *lf, const TEXTMETRIC *mt, DWORD style, LPARAM lParam) -> int {
// FontCollector * fc = reinterpret_cast<FontCollector*>(lParam);
// fc->facenames.push_back(lf->lfFaceName);
// fc->logFonts.push_back(*lf);
// return 1;
// }, (LPARAM)this, 0);
