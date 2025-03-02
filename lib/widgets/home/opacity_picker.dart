// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

// Project imports:
import 'package:picguard/constants/constants.dart';
import 'package:picguard/extensions/extensions.dart';
import 'package:picguard/generated/colors.gen.dart';
import 'package:picguard/i18n/i18n.g.dart';
import 'package:picguard/utils/utils.dart';
import 'package:picguard/widgets/widgets.dart';

/// 不透明度选择
class OpacityPicker extends StatefulWidget {
  const OpacityPicker({super.key});

  @override
  State<OpacityPicker> createState() => _OpacityPickerState();
}

class _OpacityPickerState extends State<OpacityPicker> {
  final opacityNotifier = ValueNotifier<double>(maxOpacity);

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    return BaseFormItem(
      title: t.homePage.opacityLabel,
      required: false,
      showTip: false,
      child: FormBuilderField<double>(
        name: 'opacity',
        initialValue: opacityNotifier.value,
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
                      activeTrackColor: PGColors.primaryColor,
                      inactiveTrackColor: PGColors.primaryBackgroundColor,
                      thumbRadius: 6,
                      thumbColor: PGColors.primaryColor,
                      overlayRadius: 0,
                    ),
                    child: SfSlider(
                      min: minOpacity,
                      stepSize: 0.1,
                      value: field.value,
                      enableTooltip: true,
                      onChanged: (dynamic value) {
                        final newValue = value as double? ?? maxOpacity;
                        opacityNotifier.value = newValue;
                        field
                          ..didChange(newValue)
                          ..validate();
                      },
                    ),
                  ).nestedAlign().nestedSizedBox(height: 30).nestedExpanded(),
                  ValueListenableBuilder(
                    valueListenable: opacityNotifier,
                    builder: (
                        BuildContext context,
                        double value,
                        Widget? child,
                        ) =>
                        Text(
                          value.toStringAsFixed(1),
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
                    color: PGColors.errorTextColor,
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
