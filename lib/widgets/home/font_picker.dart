// Copyright 2023 Insco. All rights reserved.
// This source code is licensed under the GNU General Public License v3.0.
// See the LICENSE file in the project root for full license information.

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:picguard/constants/constants.dart';
import 'package:picguard/generated/colors.gen.dart';
import 'package:picguard/i18n/i18n.g.dart';
import 'package:picguard/logger/logger.dart';
import 'package:picguard/models/models.dart';
import 'package:picguard/utils/utils.dart';
import 'package:picguard/widgets/widgets.dart';

/// 字体选择
class FontPicker extends StatelessWidget {
  const FontPicker({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final languageCode = LocaleSettings.currentLocale.languageCode;
    printDebugLog('languageCode: $languageCode');

    return BaseFormItem(
      title: t.homePage.fontLabel,
      required: false,
      onTipTap: () async {
        await DialogUtil.showBottomSheetDialog(
          content: t.homePage.fontLabelDescription,
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 8.5),
        child: FormBuilderField<String>(
          name: 'font',
          initialValue: fontFamilies.elementAt(0).fontFamily,
          builder: (FormFieldState<String> field) {
            final hasError = StringUtil.isNotBlank(field.errorText);
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 8,
              children: [
                DropdownButtonFormField<String>(
                  initialValue: field.value,
                  onTap: () => onFontTap(field),
                  style: TextStyle(
                    color: isDark ? Colors.white : PGColors.primaryTextColor,
                    overflow: TextOverflow.ellipsis,
                  ),
                  icon: const Icon(
                    Icons.arrow_drop_down,
                    color: PGColors.borderColor,
                    size: 20,
                  ),
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: const EdgeInsets.fromLTRB(10, 10, 5, 10),
                    enabledBorder: hasError
                        ? OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                            borderSide: const BorderSide(
                              color: PGColors.errorTextColor,
                            ),
                            // borderSide: BorderSide.none,
                            gapPadding: 0,
                          )
                        : OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                            borderSide: const BorderSide(
                              color: PGColors.borderColor,
                            ),
                            gapPadding: 0,
                          ),
                    disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4),
                      borderSide: const BorderSide(
                        color: PGColors.borderColor,
                      ),
                      gapPadding: 0,
                    ),
                    focusedBorder: hasError
                        ? OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                            borderSide: const BorderSide(
                              color: PGColors.errorTextColor,
                            ),
                            // borderSide: BorderSide.none,
                            gapPadding: 0,
                          )
                        : OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                            borderSide: const BorderSide(
                              color: PGColors.primaryColor,
                            ),
                            gapPadding: 0,
                          ),
                  ),
                  items: fontFamilies.map(
                    (fontFamily) {
                      return DropdownMenuItem<String>(
                        value: fontFamily.fontFamily,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            fontFamily.name,
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: fontFamily.fontFamily,
                            ),
                          ),
                        ),
                      );
                    },
                  ).toList(),
                  onChanged: (value) {},
                ),
                if (hasError)
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Text(
                      field.errorText!,
                      style: const TextStyle(
                        fontSize: 12,
                        color: PGColors.errorTextColor,
                      ),
                    ),
                  ),
              ],
            );
          },
          validator: (value) {
            if (value == null) {
              return t.homePage.fontValidator;
            }
            return null;
          },
        ),
      ),
    );
  }

  Future<void> onFontTap(FormFieldState<String> field) async {
    // DO NOT REMOVE THIS LINE: 消除下拉选择默认弹窗
    NavigatorUtil.pop();
    await DialogUtil.showFontModal(
      items: fontFamilies,
      font: field.value,
      callback: (PGFont font) {
        if (kDebugMode) {
          printDebugLog('fontFamily: ${font.fontFamily}, name: ${font.name}');
        }

        field
          ..didChange(font.fontFamily)
          ..validate();

        NavigatorUtil.pop();
      },
    );
  }
}
