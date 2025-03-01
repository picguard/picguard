// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

// Project imports:
import 'package:picguard/constants/get.dart';
import 'package:picguard/extensions/extensions.dart';
import 'package:picguard/i18n/i18n.dart';
import 'package:picguard/theme/colors.dart';
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
                  SfSliderTheme(
                    data: const SfSliderThemeData(
                      activeTrackHeight: 4,
                      activeTrackColor: primaryColor,
                      inactiveTrackColor: primaryBackgroundColor,
                      thumbRadius: 6,
                      thumbColor: primaryColor,
                      overlayRadius: 0,
                    ),
                    child: SfSlider(
                      min: minFontSize,
                      max: minFontSize * 4,
                      stepSize: 2,
                      value: field.value,
                      enableTooltip: true,
                      onChanged: (dynamic value) {
                        final newValue = value as double? ?? initialFontSize;
                        fontSizeNotifier.value = newValue;
                        field
                          ..didChange(newValue)
                          ..validate();
                      },
                    ),
                  ).nestedAlign().nestedSizedBox(height: 30).nestedExpanded(),
                  ValueListenableBuilder(
                    valueListenable: fontSizeNotifier,
                    builder: (
                        BuildContext context,
                        double value,
                        Widget? child,
                        ) =>
                        Text(
                          value.toStringAsFixed(0),
                          textAlign: TextAlign.center,
                        ).nestedSizedBox(width: 28),
                  ),
                ],
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
      ).nestedPadding(
        padding: const EdgeInsets.only(top: 8.5),
      ),
    );
  }
}
