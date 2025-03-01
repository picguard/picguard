// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:picguard/extensions/extensions.dart';
import 'package:picguard/i18n/i18n.dart';
import 'package:picguard/theme/colors.dart';

/// 预览按钮
class PreviewBtn extends StatelessWidget {
  const PreviewBtn({this.onPressed, super.key});

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final t = Translations.of(context);
        return ElevatedButton(
          onPressed: onPressed,
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(
              Colors.white,
            ),
            foregroundColor: WidgetStateProperty.resolveWith((
              Set<WidgetState> states,
            ) {
              if (states.contains(WidgetState.disabled)) {
                return secondaryBorderColor;
              }
              return primaryColor;
            }),
            shape: WidgetStateProperty.resolveWith((
              Set<WidgetState> states,
            ) {
              if (states.contains(WidgetState.disabled)) {
                return RoundedRectangleBorder(
                  side: const BorderSide(color: secondaryBorderColor),
                  borderRadius: BorderRadius.circular(10),
                );
              }
              return RoundedRectangleBorder(
                side: const BorderSide(color: primaryColor),
                borderRadius: BorderRadius.circular(10),
              );
            }),
            elevation: WidgetStateProperty.all(0),
          ),
          child: Text(
            t.homePage.preview,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              fontFamily: 'NotoSansSC',
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
