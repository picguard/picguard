// Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_form_builder/flutter_form_builder.dart';

// Project imports:
import 'package:picguard/constants/constants.dart';
import 'package:picguard/extensions/extensions.dart';
import 'package:picguard/i18n/i18n.dart';
import 'package:picguard/logger/logger.dart';
import 'package:picguard/models/models.dart';
import 'package:picguard/theme/colors.dart';
import 'package:picguard/utils/utils.dart';
import 'package:picguard/widgets/widgets.dart';

/// 颜色选择
class ColorPicker extends StatelessWidget {
  const ColorPicker({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final languageCode = LocaleSettings.currentLocale.languageCode;
    printDebugLog('languageCode: $languageCode');

    return BaseFormItem(
      title: t.homePage.colorLabel,
      required: false,
      showTip: false,
      child: FormBuilderField<int>(
        name: 'color',
        initialValue: colors.elementAt(1).value,
        builder: (FormFieldState<int> field) {
          final hasError = StringUtil.isNotBlank(field.errorText);
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 8,
            children: [
              DropdownButtonFormField<int>(
                value: field.value,
                onTap: () => onColorTap(field),
                style: TextStyle(
                  color: isDark ? Colors.white : primaryTextColor,
                  overflow: TextOverflow.ellipsis,
                  fontFamily: 'NotoSansSC',
                ),
                icon: const Icon(
                  Icons.arrow_drop_down,
                  color: borderColor,
                  size: 20,
                ),
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding: const EdgeInsets.fromLTRB(10, 10, 5, 10),
                  enabledBorder: hasError
                      ? OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                    borderSide: const BorderSide(
                      color: errorTextColor,
                    ),
                    // borderSide: BorderSide.none,
                    gapPadding: 0,
                  )
                      : OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                    borderSide: const BorderSide(
                      color: borderColor,
                    ),
                    gapPadding: 0,
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                    borderSide: const BorderSide(
                      color: borderColor,
                    ),
                    gapPadding: 0,
                  ),
                  focusedBorder: hasError
                      ? OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                    borderSide: const BorderSide(
                      color: errorTextColor,
                    ),
                    // borderSide: BorderSide.none,
                    gapPadding: 0,
                  )
                      : OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                    borderSide: const BorderSide(
                      color: primaryColor,
                    ),
                    gapPadding: 0,
                  ),
                ),
                items: colors.map(
                      (color) {
                    return DropdownMenuItem<int>(
                      value: color.value,
                      child: Text(
                        languageCode == 'zh' ? color.zhText : color.enText,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'NotoSansSC',
                        ),
                      ).nestedAlign(
                        alignment: Alignment.centerLeft,
                      ),
                    );
                  },
                ).toList(),
                onChanged: (value) {},
              ),
              if (hasError)
                Text(
                  field.errorText!,
                  style: const TextStyle(
                    fontSize: 12,
                    color: errorTextColor,
                    fontFamily: 'NotoSansSC',
                  ),
                ).nestedPadding(
                  padding: const EdgeInsets.only(left: 8),
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
      ).nestedPadding(
        padding: const EdgeInsets.only(top: 8.5),
      ),
    );
  }

  void onColorTap(FormFieldState<int> field) {
    // DO NOT REMOVE THIS LINE: 消除下拉选择默认弹窗
    NavigatorUtil.pop();
    DialogUtil.showPGColorModal(
      items: colors,
      color: field.value,
      callback: (PGColor value) {
        if (kDebugMode) {
          printDebugLog('id: ${value.value}, name: ${value.enText}');
        }

        field
          ..didChange(value.value)
          ..validate();

        NavigatorUtil.pop();
      },
    );
  }
}
