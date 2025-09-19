// Copyright 2023 Insco. All rights reserved.
// This source code is licensed under the GNU General Public License v3.0.
// See the LICENSE file in the project root for full license information.

import 'package:flutter/material.dart';

import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:picguard/extensions/extensions.dart';
import 'package:picguard/generated/colors.gen.dart';
import 'package:picguard/i18n/i18n.g.dart';
import 'package:picguard/utils/utils.dart';
import 'package:picguard/widgets/widgets.dart';

/// 输入框
class TextInput extends StatelessWidget {
  const TextInput({this.focusNode, super.key});

  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return BaseFormItem(
      title: t.homePage.textLabel,
      onTipTap: () {
        DialogUtil.showBottomSheetDialog(
          content: t.homePage.textLabelDescription,
        );
      },
      child: FormBuilderField<String>(
        name: 'text',
        focusNode: focusNode,
        builder: (FormFieldState<String> field) {
          final hasError = StringUtil.isNotBlank(field.errorText);
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 8,
            children: [
              TextFormField(
                initialValue: field.value,
                focusNode: focusNode,
                cursorColor: hasError ? PGColors.errorTextColor : PGColors.primaryColor,
                autocorrect: false,
                style: TextStyle(
                  color: isDark ? Colors.white : PGColors.primaryTextColor,
                  fontSize: 14,
                ),
                onChanged: (value) {
                  field
                    ..didChange(value)
                    ..validate();
                },
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding: const EdgeInsets.fromLTRB(10, 11.5, 5, 11.5),
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
                  hintText: t.homePage.textInput,
                  hintMaxLines: 2,
                  hintStyle: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
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
                    // borderSide: BorderSide.none,
                    gapPadding: 0,
                  ),
                ),
              ),
              if (hasError)
                Text(
                  field.errorText!,
                  style: const TextStyle(
                    fontSize: 12,
                    color: PGColors.errorTextColor,
                  ),
                ).nestedPadding(
                  padding: const EdgeInsets.only(left: 8),
                ),
            ],
          );
        },
        validator: (value) {
          if (StringUtil.isBlank(value)) {
            return t.homePage.textValidator;
          }
          return null;
        },
      ).nestedPadding(
        padding: const EdgeInsets.only(top: 8.5),
      ),
    );
  }
}
