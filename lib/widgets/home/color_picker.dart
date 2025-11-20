// Copyright 2023 Qiazo. All rights reserved.
// This source code is licensed under the GNU General Public License v3.0.
// See the LICENSE file in the project root for full license information.

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:picguard/generated/colors.gen.dart';
import 'package:picguard/i18n/i18n.g.dart';
import 'package:picguard/logger/logger.dart';
import 'package:picguard/models/models.dart';
import 'package:picguard/utils/utils.dart';
import 'package:picguard/widgets/widgets.dart';

/// 颜色选择
class ColorPicker extends StatelessWidget {
  const ColorPicker({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final isDark = Theme.of(context).brightness == .dark;
    const colors = PGColor.values;

    return BaseFormItem(
      title: t.homePage.colorLabel,
      required: false,
      showTip: false,
      child: Padding(
        padding: const .only(top: 8.5),
        child: FormBuilderField<int>(
          name: 'color',
          initialValue: colors.elementAt(1).color,
          builder: (FormFieldState<int> field) {
            final hasError = StringUtil.isNotBlank(field.errorText);
            return Column(
              crossAxisAlignment: .start,
              spacing: 8,
              children: [
                DropdownButtonFormField<int>(
                  initialValue: field.value,
                  onTap: () => onColorTap(colors, field),
                  style: DefaultTextStyle.of(context).style.copyWith(
                    color: isDark ? Colors.white : PGColors.primaryTextColor,
                    overflow: .ellipsis,
                  ),
                  icon: const Icon(
                    Icons.arrow_drop_down,
                    color: PGColors.borderColor,
                    size: 20,
                  ),
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: const .fromLTRB(10, 10, 5, 10),
                    enabledBorder: hasError
                        ? OutlineInputBorder(
                            borderRadius: .circular(4),
                            borderSide: const BorderSide(
                              color: PGColors.errorTextColor,
                            ),
                            // borderSide: BorderSide.none,
                            gapPadding: 0,
                          )
                        : OutlineInputBorder(
                            borderRadius: .circular(4),
                            borderSide: const BorderSide(
                              color: PGColors.borderColor,
                            ),
                            gapPadding: 0,
                          ),
                    disabledBorder: OutlineInputBorder(
                      borderRadius: .circular(4),
                      borderSide: const BorderSide(
                        color: PGColors.borderColor,
                      ),
                      gapPadding: 0,
                    ),
                    focusedBorder: hasError
                        ? OutlineInputBorder(
                            borderRadius: .circular(4),
                            borderSide: const BorderSide(
                              color: PGColors.errorTextColor,
                            ),
                            // borderSide: BorderSide.none,
                            gapPadding: 0,
                          )
                        : OutlineInputBorder(
                            borderRadius: .circular(4),
                            borderSide: const BorderSide(
                              color: PGColors.primaryColor,
                            ),
                            gapPadding: 0,
                          ),
                  ),
                  items: colors.map(
                    (item) {
                      return DropdownMenuItem<int>(
                        enabled: item.color != field.value,
                        value: item.color,
                        child: Align(
                          alignment: .centerLeft,
                          child: Text(item.label),
                        ),
                      );
                    },
                  ).toList(),
                  onChanged: (value) {},
                ),
                if (hasError)
                  Padding(
                    padding: const .only(left: 8),
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
              return t.homePage.colorValidator;
            }
            return null;
          },
        ),
      ),
    );
  }

  Future<void> onColorTap(List<PGColor> colors, FormFieldState<int> field) async {
    // DO NOT REMOVE THIS LINE: 消除下拉选择默认弹窗
    NavigatorUtil.pop();
    await DialogUtil.showPGColorModal(
      items: colors,
      color: field.value,
      callback: (PGColor item) {
        if (kDebugMode) {
          printDebugLog('id: ${item.color}, name: ${item.label}');
        }

        field
          ..didChange(item.color)
          ..validate();

        NavigatorUtil.pop();
      },
    );
  }
}
