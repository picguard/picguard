// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart' hide Translations;

// Project imports:
import 'package:picguard/controllers/controllers.dart';
import 'package:picguard/extensions/extensions.dart';
import 'package:picguard/generated/colors.gen.dart';
import 'package:picguard/i18n/i18n.dart';
import 'package:picguard/logger/logger.dart';
import 'package:picguard/models/models.dart';
import 'package:picguard/utils/utils.dart';
import 'package:picguard/widgets/widgets.dart';

typedef VoidPGColorCallback = void Function(PGColor);
typedef VoidPGFontCallback = void Function(PGFont);

class PGColorModal extends StatelessWidget {
  const PGColorModal({
    required this.items,
    required this.callback,
    this.color,
    super.key,
  });

  final List<PGColor> items;
  final VoidPGColorCallback callback;
  final int? color;

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final languageCode = LocaleSettings.currentLocale.languageCode;
    final bottom = MediaQuery.paddingOf(context).bottom;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              t.dialogs.selectColor,
              style: TextStyle(
                color: isDark ? Colors.white : PGColors.primaryTextColor,
                fontSize: 16,
                fontWeight: FontWeight.w500,
                height: 1.43,
              ),
            ),
            IconButton(
              style: ButtonStyle(
                padding: WidgetStateProperty.all(
                  const EdgeInsets.all(8),
                ),
                minimumSize: WidgetStateProperty.all(Size.zero),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                elevation: WidgetStateProperty.all(0),
              ),
              onPressed: NavigatorUtil.pop,
              icon: Icon(
                Icons.close,
                color: isDark ? PGColors.primaryTextColor : PGColors.secondaryTextColor,
                size: 16,
              )
                  .nestedPadding(padding: const EdgeInsets.all(2))
                  .nestedDecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: isDark ? PGColors.placeholderTextColor : PGColors.primaryGrayColor,
                    ),
                  ),
            ),
          ],
        )
            .nestedPadding(
              padding: const EdgeInsets.fromLTRB(16, 12, 8, 12),
            )
            .nestedDecoratedBox(
              decoration: const BoxDecoration(
                border:
                    Border(bottom: BorderSide(color: PGColors.borderColor, width: 0.5)),
              ),
            ),
        ListView.builder(
          padding: const EdgeInsets.only(top: 5),
          shrinkWrap: true,
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];
            final selected = item.value == color;
            final backgroundColor =
                selected ? PGColors.primaryBackgroundColor : Colors.transparent;
            return TextButton(
              style: ButtonStyle(
                padding: WidgetStateProperty.all(
                  const EdgeInsets.symmetric(horizontal: 16),
                ),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                backgroundColor: WidgetStateProperty.all(backgroundColor),
                overlayColor: WidgetStateProperty.all(
                  isDark ? PGColors.primaryTextColor : PGColors.primaryBackgroundColor,
                ),
                shape: WidgetStateProperty.all(const RoundedRectangleBorder()),
              ),
              onPressed: () => callback(item),
              child: Text(
                languageCode == 'zh' ? item.zhText : item.enText,
                style: TextStyle(
                  color: selected
                      ? PGColors.primaryColor
                      : isDark
                          ? Colors.white
                          : PGColors.primaryTextColor,
                  fontSize: 14,
                  height: 1.43,
                ),
                textAlign: TextAlign.start,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              )
                  .nestedPadding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                  )
                  .nestedSizedBox(width: double.maxFinite),
            );
          },
        ).nestedFlexible(),
      ],
    )
        .nestedConstrainedBox(
          constraints: const BoxConstraints(maxHeight: 400),
        )
        .nestedPadding(
          padding: EdgeInsets.only(bottom: 20 + bottom),
        );
  }
}

class FontModal extends StatelessWidget {
  const FontModal({
    required this.items,
    required this.callback,
    this.font,
    super.key,
  });

  final List<PGFont> items;
  final VoidPGFontCallback callback;
  final String? font;

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bottom = MediaQuery.paddingOf(context).bottom;
    final height = MediaQuery.sizeOf(context).height;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              t.dialogs.selectFont,
              style: TextStyle(
                color: isDark ? Colors.white : PGColors.primaryTextColor,
                fontSize: 16,
                fontWeight: FontWeight.w500,
                height: 1.43,
              ),
            ),
            IconButton(
              style: ButtonStyle(
                padding: WidgetStateProperty.all(
                  const EdgeInsets.all(8),
                ),
                minimumSize: WidgetStateProperty.all(Size.zero),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                elevation: WidgetStateProperty.all(0),
              ),
              onPressed: NavigatorUtil.pop,
              icon: Icon(
                Icons.close,
                color: isDark ? PGColors.primaryTextColor : PGColors.secondaryTextColor,
                size: 16,
              )
                  .nestedPadding(padding: const EdgeInsets.all(2))
                  .nestedDecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: isDark ? PGColors.placeholderTextColor : PGColors.primaryGrayColor,
                    ),
                  ),
            ),
          ],
        )
            .nestedPadding(
              padding: const EdgeInsets.fromLTRB(16, 12, 8, 12),
            )
            .nestedDecoratedBox(
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: PGColors.borderColor, width: 0.5),
                ),
              ),
            ),
        ListView.builder(
          padding: const EdgeInsets.only(top: 5),
          shrinkWrap: true,
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];
            final selected = item.fontFamily == font;
            final backgroundColor =
                selected ? PGColors.primaryBackgroundColor : Colors.transparent;
            return TextButton(
              style: ButtonStyle(
                padding: WidgetStateProperty.all(
                  const EdgeInsets.symmetric(horizontal: 16),
                ),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                backgroundColor: WidgetStateProperty.all(backgroundColor),
                overlayColor: WidgetStateProperty.all(
                  isDark ? PGColors.primaryTextColor : PGColors.primaryBackgroundColor,
                ),
                shape: WidgetStateProperty.all(const RoundedRectangleBorder()),
              ),
              onPressed: () => callback(items[index]),
              child: Text(
                item.name,
                style: TextStyle(
                  color: selected
                      ? PGColors.primaryColor
                      : isDark
                          ? Colors.white
                          : PGColors.primaryTextColor,
                  fontSize: 14,
                  height: 1.43,
                  fontFamily: item.fontFamily,
                ),
                textAlign: TextAlign.start,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              )
                  .nestedPadding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                  )
                  .nestedSizedBox(width: double.maxFinite),
            );
          },
        ).nestedFlexible(),
      ],
    )
        .nestedConstrainedBox(
          constraints: BoxConstraints(maxHeight: height * 0.8),
        )
        .nestedPadding(
          padding: EdgeInsets.only(bottom: 20 + bottom),
        );
  }
}

/// Settings
class SettingsModal extends StatelessWidget {
  const SettingsModal({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bottom = MediaQuery.paddingOf(context).bottom;
    final height = MediaQuery.sizeOf(context).height;

    final controller = Get.find<SettingsController>();

    final currentLocale = LocaleSettings.currentLocale;
    final languageCode = currentLocale.languageCode;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              t.dialogs.settingsDialog.settings,
              style: TextStyle(
                color: isDark ? Colors.white : PGColors.primaryTextColor,
                fontSize: 16,
                fontWeight: FontWeight.w500,
                height: 1.43,
              ),
            ),
            IconButton(
              style: ButtonStyle(
                padding: WidgetStateProperty.all(
                  const EdgeInsets.all(8),
                ),
                minimumSize: WidgetStateProperty.all(Size.zero),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                elevation: WidgetStateProperty.all(0),
              ),
              onPressed: NavigatorUtil.pop,
              icon: Icon(
                Icons.close,
                color: isDark ? PGColors.primaryTextColor : PGColors.secondaryTextColor,
                size: 16,
              )
                  .nestedPadding(padding: const EdgeInsets.all(2))
                  .nestedDecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: isDark ? PGColors.placeholderTextColor : PGColors.primaryGrayColor,
                    ),
                  ),
            ),
          ],
        )
            .nestedPadding(
              padding: const EdgeInsets.fromLTRB(16, 12, 8, 12),
            )
            .nestedDecoratedBox(
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: PGColors.borderColor, width: 0.5),
                ),
              ),
            ),
        Column(
          mainAxisSize: MainAxisSize.min,
          spacing: 10,
          children: [
            Obx(() {
              final themeMode = controller.themeMode.value;
              printDebugLog('themeMode: $themeMode');
              final auto = themeMode == ThemeMode.system;

              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  MineSectionGroup(
                    title: t.dialogs.settingsDialog.themes.dark,
                    description: t.dialogs.settingsDialog.themesDescription,
                    items: [
                      MineSectionModel(
                        title: t.dialogs.settingsDialog.themes.system,
                        showIcon: false,
                        trailing: FlutterSwitch(
                          width: 50,
                          height: 30,
                          toggleSize: 20,
                          value: auto,
                          borderRadius: 15,
                          activeColor: PGColors.primaryColor,
                          onToggle: (value) {
                            final isDark =
                                Theme.of(context).colorScheme.brightness ==
                                    Brightness.dark;
                            final currentMode =
                                isDark ? ThemeMode.dark : ThemeMode.light;
                            value
                                ? controller.switchThemeMode(ThemeMode.system)
                                : controller.switchThemeMode(currentMode);
                          },
                        ),
                      ),
                    ],
                  ),
                  if (!auto)
                    MineSectionGroup(
                      title: t.dialogs.settingsDialog.themes.manual,
                      items: [
                        MineSectionModel(
                          title: t.dialogs.settingsDialog.themes.light,
                          showIcon: false,
                          trailing: Radio<ThemeMode>(
                            value: ThemeMode.light,
                            groupValue: themeMode,
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                            visualDensity: const VisualDensity(
                              horizontal: VisualDensity.minimumDensity,
                              vertical: VisualDensity.minimumDensity,
                            ),
                            onChanged: (ThemeMode? value) {
                              if (value != null) {
                                controller.switchThemeMode(value);
                              }
                            },
                          ),
                        ),
                        MineSectionModel(
                          title: t.dialogs.settingsDialog.themes.dark,
                          showIcon: false,
                          trailing: Radio<ThemeMode>(
                            value: ThemeMode.dark,
                            groupValue: themeMode,
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                            visualDensity: const VisualDensity(
                              horizontal: VisualDensity.minimumDensity,
                              vertical: VisualDensity.minimumDensity,
                            ),
                            onChanged: (ThemeMode? value) {
                              if (value != null) {
                                controller.switchThemeMode(value);
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                ],
              );
            }),
            MineSectionGroup(
              title: t.dialogs.settingsDialog.languages,
              items: t.locales.entries.map(
                (MapEntry<String, String> entry) {
                  final appLocale = AppLocaleUtils.parse(entry.key);
                  return MineSectionModel(
                    title: entry.value,
                    showIcon: false,
                    trailing: Radio<String>(
                      value: appLocale.languageCode,
                      groupValue: languageCode,
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      visualDensity: const VisualDensity(
                        horizontal: VisualDensity.minimumDensity,
                        vertical: VisualDensity.minimumDensity,
                      ),
                      onChanged: (String? value) {
                        if (value != null && value.isNotEmpty) {
                          LocaleSettings.setLocaleRaw(value);
                        }
                      },
                    ),
                  );
                },
              ).toList(),
            ),
          ],
        )
            .nestedSingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 10),
            )
            .nestedFlexible(),
      ],
    )
        .nestedConstrainedBox(
          constraints: BoxConstraints(maxHeight: height * 0.8),
        )
        .nestedPadding(
          padding: EdgeInsets.only(bottom: 20 + bottom),
        )
        .nestedColoredBox(color: isDark ? PGColors.dialogBackgroundColor : Colors.white);
  }
}
