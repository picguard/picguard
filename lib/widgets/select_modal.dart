// Copyright 2023 Qiazo. All rights reserved.
// This source code is licensed under the GNU General Public License v3.0.
// See the LICENSE file in the project root for full license information.

import 'package:flutter/material.dart';

import 'package:flutter_switch/flutter_switch.dart';

import 'package:picguard/generated/colors.gen.dart';
import 'package:picguard/i18n/i18n.g.dart';
import 'package:picguard/logger/logger.dart';
import 'package:picguard/models/models.dart';
import 'package:picguard/utils/utils.dart';
import 'package:picguard/viewmodels/viewmodels.dart';
import 'package:picguard/widgets/widgets.dart';
import 'package:provider/provider.dart';

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
    final isDark = Theme.of(context).brightness == .dark;
    final bottom = MediaQuery.paddingOf(context).bottom;
    return Padding(
      padding: .only(bottom: 20 + bottom),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxHeight: 400),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DecoratedBox(
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: PGColors.borderColor,
                    width: 0.5,
                  ),
                ),
              ),
              child: Padding(
                padding: const .fromLTRB(16, 12, 8, 12),
                child: Row(
                  mainAxisAlignment: .spaceBetween,
                  children: [
                    Text(
                      t.dialogs.selectColor,
                      style: TextStyle(
                        color: isDark
                            ? Colors.white
                            : PGColors.primaryTextColor,
                        fontSize: 16,
                        fontWeight: .w500,
                        height: 1.43,
                      ),
                    ),
                    IconButton(
                      style: ButtonStyle(
                        padding: .all(const EdgeInsets.all(8)),
                        minimumSize: .all(Size.zero),
                        tapTargetSize: .shrinkWrap,
                        elevation: .all(0),
                      ),
                      onPressed: NavigatorUtil.pop,
                      icon: DecoratedBox(
                        decoration: BoxDecoration(
                          borderRadius: .circular(10),
                          color: isDark
                              ? PGColors.placeholderTextColor
                              : PGColors.primaryGrayColor,
                        ),
                        child: Padding(
                          padding: const .all(2),
                          child: Icon(
                            Icons.close,
                            color: isDark
                                ? PGColors.primaryTextColor
                                : PGColors.secondaryTextColor,
                            size: 16,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Flexible(
              child: ListView.builder(
                padding: const .only(top: 5),
                shrinkWrap: true,
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final item = items[index];
                  final selected = item.color == color;
                  final backgroundColor = selected
                      ? PGColors.primaryBackgroundColor
                      : Colors.transparent;
                  return TextButton(
                    style: ButtonStyle(
                      padding: .all(
                        const .symmetric(horizontal: 16),
                      ),
                      tapTargetSize: .shrinkWrap,
                      backgroundColor: .all(backgroundColor),
                      overlayColor: .all(
                        isDark
                            ? PGColors.primaryTextColor
                            : PGColors.primaryBackgroundColor,
                      ),
                      shape: .all(
                        const RoundedRectangleBorder(),
                      ),
                    ),
                    onPressed: () => callback(item),
                    child: SizedBox(
                      width: double.maxFinite,
                      child: Padding(
                        padding: const .symmetric(vertical: 10),
                        child: Text(
                          item.label,
                          style: TextStyle(
                            color: selected
                                ? PGColors.primaryColor
                                : isDark
                                ? Colors.white
                                : PGColors.primaryTextColor,
                            fontSize: 14,
                            height: 1.43,
                          ),
                          textAlign: .start,
                          maxLines: 1,
                          overflow: .ellipsis,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
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
    final isDark = Theme.of(context).brightness == .dark;
    final bottom = MediaQuery.paddingOf(context).bottom;
    final height = MediaQuery.sizeOf(context).height;
    return Padding(
      padding: EdgeInsets.only(bottom: 20 + bottom),
      child: ConstrainedBox(
        constraints: BoxConstraints(maxHeight: height * 0.8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DecoratedBox(
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: PGColors.borderColor,
                    width: 0.5,
                  ),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 8, 12),
                child: Row(
                  mainAxisAlignment: .spaceBetween,
                  children: [
                    Text(
                      t.dialogs.selectFont,
                      style: TextStyle(
                        color: isDark
                            ? Colors.white
                            : PGColors.primaryTextColor,
                        fontSize: 16,
                        fontWeight: .w500,
                        height: 1.43,
                      ),
                    ),
                    IconButton(
                      style: ButtonStyle(
                        padding: .all(const .all(8)),
                        minimumSize: .all(Size.zero),
                        tapTargetSize: .shrinkWrap,
                        elevation: .all(0),
                      ),
                      onPressed: NavigatorUtil.pop,
                      icon: DecoratedBox(
                        decoration: BoxDecoration(
                          borderRadius: .circular(10),
                          color: isDark
                              ? PGColors.placeholderTextColor
                              : PGColors.primaryGrayColor,
                        ),
                        child: Padding(
                          padding: const .all(2),
                          child: Icon(
                            Icons.close,
                            color: isDark
                                ? PGColors.primaryTextColor
                                : PGColors.secondaryTextColor,
                            size: 16,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Flexible(
              child: ListView.builder(
                padding: const .only(top: 5),
                shrinkWrap: true,
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final item = items[index];
                  final selected = item.fontFamily == font;
                  final backgroundColor = selected
                      ? PGColors.primaryBackgroundColor
                      : Colors.transparent;
                  return TextButton(
                    style: ButtonStyle(
                      padding: .all(const .symmetric(horizontal: 16)),
                      tapTargetSize: .shrinkWrap,
                      backgroundColor: .all(backgroundColor),
                      overlayColor: .all(
                        isDark
                            ? PGColors.primaryTextColor
                            : PGColors.primaryBackgroundColor,
                      ),
                      shape: .all(const RoundedRectangleBorder()),
                    ),
                    onPressed: () => callback(items[index]),
                    child: SizedBox(
                      width: double.maxFinite,
                      child: Padding(
                        padding: const .symmetric(vertical: 10),
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
                          textAlign: .start,
                          maxLines: 1,
                          overflow: .ellipsis,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
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

    final currentLocale = LocaleSettings.currentLocale;
    final languageCode = currentLocale.languageCode;

    return Container(
      color: isDark ? PGColors.dialogBackgroundColor : Colors.white,
      padding: EdgeInsets.only(bottom: 20 + bottom),
      constraints: BoxConstraints(maxHeight: height * 0.8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: PGColors.borderColor,
                  width: 0.5,
                ),
              ),
            ),
            padding: const EdgeInsets.fromLTRB(16, 12, 8, 12),
            child: Row(
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
                  icon: DecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: isDark
                          ? PGColors.placeholderTextColor
                          : PGColors.primaryGrayColor,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(2),
                      child: Icon(
                        Icons.close,
                        color: isDark
                            ? PGColors.primaryTextColor
                            : PGColors.secondaryTextColor,
                        size: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Consumer<GlobalProvider>(
            builder: (context, model, child) {
              final themeMode = model.themeMode;
              printDebugLog('themeMode: $themeMode');
              final auto = themeMode == ThemeMode.system;
              return Flexible(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    spacing: 10,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          MineSectionGroup<void>(
                            title: t.dialogs.settingsDialog.themes.dark,
                            description:
                                t.dialogs.settingsDialog.themesDescription,
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
                                  onToggle: (value) async {
                                    final isDark =
                                        Theme.of(
                                          context,
                                        ).colorScheme.brightness ==
                                        Brightness.dark;
                                    final currentMode = isDark
                                        ? ThemeMode.dark
                                        : ThemeMode.light;
                                    await model.switchThemeMode(
                                      value ? ThemeMode.system : currentMode,
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                          if (!auto)
                            MineSectionGroup<ThemeMode>(
                              title: t.dialogs.settingsDialog.themes.manual,
                              groupValue: themeMode,
                              onChanged: (ThemeMode? value) async {
                                if (value != null) {
                                  await model.switchThemeMode(value);
                                }
                              },
                              items: [
                                MineSectionModel(
                                  title: t.dialogs.settingsDialog.themes.light,
                                  showIcon: false,
                                  trailing: const Radio<ThemeMode>(
                                    value: ThemeMode.light,
                                    materialTapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
                                    visualDensity: VisualDensity(
                                      horizontal: VisualDensity.minimumDensity,
                                      vertical: VisualDensity.minimumDensity,
                                    ),
                                  ),
                                ),
                                MineSectionModel(
                                  title: t.dialogs.settingsDialog.themes.dark,
                                  showIcon: false,
                                  trailing: const Radio<ThemeMode>(
                                    value: ThemeMode.dark,
                                    materialTapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
                                    visualDensity: VisualDensity(
                                      horizontal: VisualDensity.minimumDensity,
                                      vertical: VisualDensity.minimumDensity,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                        ],
                      ),
                      MineSectionGroup<String>(
                        title: t.dialogs.settingsDialog.languages,
                        groupValue: languageCode,
                        onChanged: (String? value) async {
                          if (value != null && value.isNotEmpty) {
                            await LocaleSettings.setLocaleRaw(value);
                          }
                        },
                        items: t.locales.entries.map(
                          (MapEntry<String, String> entry) {
                            final appLocale = AppLocaleUtils.parse(entry.key);
                            return MineSectionModel(
                              title: entry.value,
                              showIcon: false,
                              trailing: Radio<String>(
                                value: appLocale.languageCode,
                                materialTapTargetSize:
                                    MaterialTapTargetSize.shrinkWrap,
                                visualDensity: const VisualDensity(
                                  horizontal: VisualDensity.minimumDensity,
                                  vertical: VisualDensity.minimumDensity,
                                ),
                              ),
                            );
                          },
                        ).toList(),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
