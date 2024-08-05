// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:picguard/extensions/extensions.dart';
import 'package:picguard/i18n/i18n.dart';
import 'package:picguard/models/models.dart';
import 'package:picguard/theme/colors.dart';
import 'package:picguard/utils/utils.dart';

typedef VoidPGColorCallback = void Function(PGColor);
typedef VoidPGFontCallback = void Function(PGFont);

class PGColorModal extends StatelessWidget {
  const PGColorModal({
    required this.items,
    required this.callback,
    this.color,
    super.key,
  });

  final List<PGColor> items;
  final VoidPGColorCallback callback;
  final int? color;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final languageCode = LocaleSettings.currentLocale.languageCode;
    final bottom = MediaQuery.paddingOf(context).bottom;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Select a color',
              style: TextStyle(
                color: isDark ? Colors.white : primaryTextColor,
                fontSize: 16,
                fontWeight: FontWeight.w500,
                height: 1.43,
              ),
            ),
            IconButton(
              style: ButtonStyle(
                padding: WidgetStateProperty.all(
                  const EdgeInsets.all(4),
                ),
                minimumSize: WidgetStateProperty.all(Size.zero),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                elevation: WidgetStateProperty.all(0),
                backgroundColor: WidgetStateProperty.all(
                  isDark ? placeholderTextColor : primaryGrayColor,
                ),
              ),
              onPressed: NavigatorUtil.pop,
              icon: Icon(
                Icons.close,
                color: isDark ? primaryTextColor : secondaryTextColor,
                size: 16,
              ),
            ),
          ],
        )
            .nestedPadding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            )
            .nestedDecoratedBox(
              decoration: const BoxDecoration(
                border:
                    Border(bottom: BorderSide(color: borderColor, width: 0.5)),
              ),
            ),
        ListView.builder(
          padding: const EdgeInsets.only(top: 5),
          shrinkWrap: true,
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];
            final selected = item.value == color;
            final backgroundColor =
                selected ? primaryBackgroundColor : Colors.transparent;
            return TextButton(
              style: ButtonStyle(
                padding: WidgetStateProperty.all(
                  const EdgeInsets.symmetric(horizontal: 16),
                ),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                backgroundColor: WidgetStateProperty.all(backgroundColor),
                overlayColor: WidgetStateProperty.all(
                  isDark ? primaryTextColor : primaryBackgroundColor,
                ),
                shape: WidgetStateProperty.all(const RoundedRectangleBorder()),
              ),
              onPressed: () => callback(item),
              child: Text(
                languageCode == 'zh' ? item.zhText : item.enText,
                style: TextStyle(
                  color: selected
                      ? primaryColor
                      : isDark
                          ? Colors.white
                          : primaryTextColor,
                  fontSize: 14,
                  height: 1.43,
                ),
                textAlign: TextAlign.start,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              )
                  .nestedPadding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                  )
                  .nestedSizedBox(width: double.maxFinite),
            );
          },
        ).nestedFlexible(),
      ],
    )
        .nestedConstrainedBox(
          constraints: const BoxConstraints(maxHeight: 400),
        )
        .nestedPadding(
          padding: EdgeInsets.only(bottom: 10 + bottom),
        );
  }
}

class FontModal extends StatelessWidget {
  const FontModal({
    required this.items,
    required this.callback,
    this.font,
    super.key,
  });

  final List<PGFont> items;
  final VoidPGFontCallback callback;
  final String? font;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bottom = MediaQuery.paddingOf(context).bottom;
    final height = MediaQuery.sizeOf(context).height;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Select a font',
              style: TextStyle(
                color: isDark ? Colors.white : primaryTextColor,
                fontSize: 16,
                fontWeight: FontWeight.w500,
                height: 1.43,
              ),
            ),
            IconButton(
              style: ButtonStyle(
                padding: WidgetStateProperty.all(
                  const EdgeInsets.all(4),
                ),
                minimumSize: WidgetStateProperty.all(Size.zero),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                elevation: WidgetStateProperty.all(0),
                backgroundColor: WidgetStateProperty.all(
                  isDark ? placeholderTextColor : primaryGrayColor,
                ),
              ),
              onPressed: NavigatorUtil.pop,
              icon: Icon(
                Icons.close,
                color: isDark ? primaryTextColor : secondaryTextColor,
                size: 16,
              ),
            ),
          ],
        )
            .nestedPadding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            )
            .nestedDecoratedBox(
              decoration: const BoxDecoration(
                border:
                    Border(bottom: BorderSide(color: borderColor, width: 0.5)),
              ),
            ),
        ListView.builder(
          padding: const EdgeInsets.only(top: 5),
          shrinkWrap: true,
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];
            final selected = item.fontFamily == font;
            final backgroundColor =
                selected ? primaryBackgroundColor : Colors.transparent;
            return TextButton(
              style: ButtonStyle(
                padding: WidgetStateProperty.all(
                  const EdgeInsets.symmetric(horizontal: 16),
                ),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                backgroundColor: WidgetStateProperty.all(backgroundColor),
                overlayColor: WidgetStateProperty.all(
                  isDark ? primaryTextColor : primaryBackgroundColor,
                ),
                shape: WidgetStateProperty.all(const RoundedRectangleBorder()),
              ),
              onPressed: () => callback(items[index]),
              child: Text(
                item.name,
                style: TextStyle(
                  color: selected
                      ? primaryColor
                      : isDark
                          ? Colors.white
                          : primaryTextColor,
                  fontSize: 14,
                  height: 1.43,
                  fontFamily: item.fontFamily,
                ),
                textAlign: TextAlign.start,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              )
                  .nestedPadding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                  )
                  .nestedSizedBox(width: double.maxFinite),
            );
          },
        ).nestedFlexible(),
      ],
    )
        .nestedConstrainedBox(
          constraints: BoxConstraints(maxHeight: height * 0.8),
        )
        .nestedPadding(
          padding: EdgeInsets.only(bottom: 10 + bottom),
        );
  }
}
