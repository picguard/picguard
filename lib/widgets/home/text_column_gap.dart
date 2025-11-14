// Copyright 2023 Insco. All rights reserved.
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

/// 文本之间间距
class TextColumnGap extends StatefulWidget {
  const TextColumnGap({super.key});

  @override
  State<TextColumnGap> createState() => _TextColumnGapState();
}

class _TextColumnGapState extends State<TextColumnGap> {
  final textGapNotifier = ValueNotifier<double>(initialGap);

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    return BaseFormItem(
      title: t.homePage.textGapLabel,
      required: false,
      onTipTap: () async {
        await DialogUtil.showBottomSheetDialog(
          content: t.homePage.textGapDescription,
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 8.5),
        child: FormBuilderField<double>(
          name: 'textGap',
          initialValue: textGapNotifier.value,
          builder: (FormFieldState<double> field) {
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
                                textGapNotifier.value = newValue;
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
                      valueListenable: textGapNotifier,
                      builder:
                          (
                            BuildContext context,
                            double value,
                            Widget? child,
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
