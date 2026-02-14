// Copyright 2023 Qiazo. All rights reserved.
// This source code is licensed under the GNU General Public License v3.0.
// See the LICENSE file in the project root for full license information.

import 'package:flutter/material.dart';

import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

import 'package:picguard/constants/constants.dart';
import 'package:picguard/generated/colors.gen.dart';
import 'package:picguard/i18n/i18n.g.dart';
import 'package:picguard/utils/utils.dart';
import 'package:picguard/widgets/widgets.dart';

/// 文本行间距
class TextRowGap extends StatefulWidget {
  const TextRowGap({super.key});

  @override
  State<TextRowGap> createState() => _TextRowGapState();
}

class _TextRowGapState extends State<TextRowGap> {
  final rowGapNotifier = ValueNotifier<double>(initialGap);

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    return BaseFormItem(
      title: t.homePage.rowGapLabel,
      required: false,
      onTipTap: () async {
        await DialogUtil.showBottomSheetDialog(
          content: t.homePage.rowGapDescription,
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 8.5),
        child: FormBuilderField<double>(
          name: 'rowGap',
          initialValue: rowGapNotifier.value,
          builder: (field) {
            final hasError = StringUtil.isNotBlank(field.errorText);
            return Column(
              crossAxisAlignment: .start,
              spacing: 8,
              children: [
                Row(
                  spacing: 4,
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 30,
                        child: Align(
                          child: SfSliderTheme(
                            data: const SfSliderThemeData(
                              activeTrackHeight: 4,
                              activeTrackColor: PGColors.primaryColor,
                              inactiveTrackColor:
                                  PGColors.primaryBackgroundColor,
                              thumbRadius: 6,
                              thumbColor: PGColors.primaryColor,
                              overlayRadius: 0,
                              tooltipBackgroundColor: PGColors.primaryColor,
                            ),
                            child: SfSlider(
                              min: initialGap / 2,
                              max: initialGap * 2,
                              stepSize: 10,
                              value: field.value,
                              enableTooltip: true,
                              onChanged: (dynamic value) {
                                final newValue = value as double? ?? initialGap;
                                rowGapNotifier.value = newValue;
                                field
                                  ..didChange(newValue)
                                  ..validate();
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                    ValueListenableBuilder(
                      valueListenable: rowGapNotifier,
                      builder:
                          (
                            context,
                            value,
                            child,
                          ) => SizedBox(
                            width: 28,
                            child: Text(
                              value.toStringAsFixed(0),
                              textAlign: .center,
                            ),
                          ),
                    ),
                  ],
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
        ),
      ),
    );
  }
}
