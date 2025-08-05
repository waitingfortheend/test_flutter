enum LocaleType {
  en,
  ar,
  bn,
  de,
  es,
  fr,
  hi,
  id,
  it,
  ja,
  ko,
  lo,
  ms,
  nl,
  pl,
  pt,
  ru,
  th,
  tr,
  vi,
  zh,
}

extension LocaleTypeNameExtention on LocaleType {
  String get name {
    return toString().split('.').last;
  }
}
