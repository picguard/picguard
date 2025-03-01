// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_form_builder/flutter_form_builder.dart';

// Project imports:
import 'package:picguard/extensions/extensions.dart';
import 'package:picguard/i18n/i18n.dart';
import 'package:picguard/theme/colors.dart';
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
                cursorColor: hasError ? errorTextColor : primaryColor,
                autocorrect: false,
                style: TextStyle(
                  color: isDark ? Colors.white : primaryTextColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'NotoSansSC',
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
                  hintText: t.homePage.textInput,
                  hintMaxLines: 2,
                  hintStyle: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    color: Colors.grey,
                    fontFamily: 'NotoSansSC',
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
