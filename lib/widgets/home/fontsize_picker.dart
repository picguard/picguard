// Copyright 2023 Insco. All rights reserved.
// This source code is licensed under the GNU General Public License v3.0.
// See the LICENSE file in the project root for full license information.

import 'package:flutter/material.dart';

import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

import 'package:picguard/generated/colors.gen.dart';
import 'package:picguard/i18n/i18n.g.dart';
import 'package:picguard/utils/utils.dart';
import 'package:picguard/widgets/widgets.dart';

final minFontSize = isMobile ? 36.0 : 18.0;
double initialFontSize = isMobile ? 72 : 36;

/// 字体大小选择
class FontSizePicker extends StatefulWidget {
  const FontSizePicker({super.key});

  @override
  State<FontSizePicker> createState() => _FontSizePickerState();
}

class _FontSizePickerState extends State<FontSizePicker> {
  final fontSizeNotifier = ValueNotifier<double>(initialFontSize);

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    return BaseFormItem(
      title: t.homePage.fontSizeLabel,
      required: false,
      showTip: false,
      child: Padding(
        padding: const EdgeInsets.only(top: 8.5),
        child: FormBuilderField<double>(
          name: 'fontSize',
          initialValue: fontSizeNotifier.value,
          builder: (FormFieldState<double> field) {
            final hasError = StringUtil.isNotBlank(field.errorText);
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                              min: minFontSize,
                              max: minFontSize * 4,
                              stepSize: 2,
                              value: field.value,
                              enableTooltip: true,
                              onChanged: (dynamic value) {
                                final newValue =
                                    value as double? ?? initialFontSize;
                                fontSizeNotifier.value = newValue;
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
                      valueListenable: fontSizeNotifier,
                      builder:
                          (
                            BuildContext context,
                            double value,
                            Widget? child,
                          ) => SizedBox(
                            width: 28,
                            child: Text(
                              value.toStringAsFixed(0),
                              textAlign: TextAlign.center,
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
