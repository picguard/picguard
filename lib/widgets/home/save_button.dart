// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:picguard/extensions/extensions.dart';
import 'package:picguard/i18n/i18n.dart';
import 'package:picguard/theme/colors.dart';

/// 保存按钮
class SaveBtn extends StatelessWidget {
  const SaveBtn({this.onPressed, super.key});

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final t = Translations.of(context);
        return ElevatedButton(
          onPressed: onPressed,
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.resolveWith((
              Set<WidgetState> states,
            ) {
              if (states.contains(WidgetState.disabled)) {
                return secondaryGrayColor;
              }
              return primaryColor;
            }),
            foregroundColor: WidgetStateProperty.resolveWith((
              Set<WidgetState> states,
            ) {
              if (states.contains(WidgetState.disabled)) {
                return placeholderTextColor;
              }
              return Colors.white;
            }),
            elevation: WidgetStateProperty.all(0),
          ),
          child: Text(
            t.homePage.save,
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
        ).nestedSizedBox(
          width: constraints.maxWidth,
          height: 42,
        );
      },
    );
  }
}
