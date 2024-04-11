import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:picguard/app/navigator.dart';
import 'package:picguard/extensions/extensions.dart';
import 'package:picguard/i18n/i18n.dart';
import 'package:picguard/models/models.dart';
import 'package:picguard/theme/colors.dart';
import 'package:picguard/utils/utils.dart';

typedef VoidPGColorCallback = void Function(PGColor);

class PGColorModal extends StatelessWidget {
  const PGColorModal({
    required this.items,
    required this.callback,
    super.key,
  });

  final List<PGColor> items;
  final VoidPGColorCallback callback;

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final isDark = brightness == Brightness.dark;
    final languageCode = LocaleSettings.currentLocale.languageCode;
    final bottom = MediaQuery.of(context).padding.bottom;
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
                padding: MaterialStateProperty.all(
                  const EdgeInsets.all(4),
                ),
                minimumSize: MaterialStateProperty.all(Size.zero),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                elevation: MaterialStateProperty.all(0),
                backgroundColor: MaterialStateProperty.all(
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
        ).nestedPadding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        ),
        ListView.builder(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          itemCount: items.length,
          itemBuilder: (context, index) => TextButton(
            style: ButtonStyle(
              padding: MaterialStateProperty.all(
                const EdgeInsets.symmetric(horizontal: 16),
              ),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              backgroundColor: MaterialStateProperty.all(Colors.transparent),
              overlayColor: MaterialStateProperty.all(
                isDark ? primaryTextColor : primaryBackgroundColor,
              ),
            ),
            onPressed: () => callback(items[index]),
            child: Text(
              languageCode == 'zh' ? items[index].zhText : items[index].enText,
              style: TextStyle(
                color: isDark ? Colors.white : primaryTextColor,
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
          ),
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

void showPGColorModal({
  required List<PGColor> items,
  required VoidPGColorCallback callback,
}) {
  final context = AppNavigator.key.currentContext!;
  final brightness = Theme.of(context).brightness;
  final isDark = brightness == Brightness.dark;
  showMaterialModalBottomSheet<void>(
    context: context,
    backgroundColor: isDark ? Colors.black : Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    builder: (BuildContext context) => PGColorModal(
      items: items,
      callback: callback,
    ),
  );
}
