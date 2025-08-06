import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart' as getx;
import '../../enum/locale_type.enum.dart';
import '../../generated/locales.g.dart';
import '../../providers/base_provider.dart';

class ChangeLanguageScreen extends ConsumerStatefulWidget {
  const ChangeLanguageScreen({super.key});

  @override
  ConsumerState<ChangeLanguageScreen> createState() =>
      _ChangeLanguageScreenState();
}

class _ChangeLanguageScreenState extends ConsumerState<ChangeLanguageScreen> {
  Map<LocaleType, bool> activeLocales = {
    LocaleType.th: false,
    LocaleType.en: false,
    // LocaleType.lo: false,
  };

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _setActiveLanguage(ref.watch(BaseProvider.languageProvider).language);
  }

  _getActiveLanguage() {
    if (activeLocales[LocaleType.th] == true) {
      return LocaleType.th;
    } else if (activeLocales[LocaleType.en] == true) {
      return LocaleType.en;
    } else if (activeLocales[LocaleType.lo] == true) {
      return LocaleType.lo;
    } else {
      return LocaleType.th;
    }
  }

  _setActiveLanguage(LocaleType type) async {
    // var lang = ref.read(BaseProvider.languageProvider).language;

    activeLocales.forEach((key, value) {
      activeLocales[key] = false;
    });
    activeLocales[type] = true;
  }

  _resetActiveLanguage() {
    activeLocales.forEach((key, value) {
      activeLocales[key] = false;
    });
  }

  Widget _text(String text, {bool active = false}) {
    return Text(
      text,
      style: TextStyle(
        fontWeight: active ? FontWeight.w700 : FontWeight.normal,
      ),
    );
  }

  Widget _mark({bool active = false}) {
    if (active) {
      return const Icon(Icons.check, color: Colors.orange);
    } else {
      return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    var langProvider = ref.watch(BaseProvider.languageProvider);

    print(langProvider.language);

    var listLocaleType = langProvider.listLocaleType;
    return Scaffold(
      appBar: AppBar(title: Text(LocaleKeys.change_language.tr)),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (var i = 0; i < listLocaleType.length; i++)
                InkWell(
                  onTap: () {
                    setState(() {
                      _resetActiveLanguage();
                      _setActiveLanguage(listLocaleType[i]);
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    alignment: Alignment.centerLeft,
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _text(
                          langProvider.mapLocaleName[listLocaleType[i]]
                              .toString(),
                          active: activeLocales[listLocaleType[i]] == true,
                        ),
                        _mark(active: activeLocales[listLocaleType[i]] == true),
                      ],
                    ),
                  ),
                ),
              const Gap(16),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    var activeLang = _getActiveLanguage() as LocaleType;
                    ref.read(BaseProvider.languageProvider).language =
                        activeLang;
                    getx.Get.updateLocale(langProvider.locale);
                    getx.Get.back();
                  },
                  child: Text(LocaleKeys.confirm.tr),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
