// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:picguard/extensions/extensions.dart';
import 'package:picguard/theme/colors.dart';
import 'package:picguard/utils/utils.dart';

class MineSectionItem extends StatelessWidget {
  const MineSectionItem({
    required this.name,
    this.labelColor = primaryTextColor,
    this.overlayColor = primaryBackgroundColor,
    this.showBorder = true,
    this.showIcon = true,
    this.direction = Axis.horizontal,
    this.leading,
    this.trailing,
    this.callback,
    this.tips,
    super.key,
  });

  final String name;
  final Color labelColor;
  final Color overlayColor;
  final bool showBorder;
  final bool showIcon;
  final Axis direction;
  final String? tips;
  final Widget? leading;
  final Widget? trailing;
  final VoidCallback? callback;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    Widget child;
    if (direction == Axis.horizontal) {
      child = Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (leading != null) leading!,
          Text(
            name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: isDark ? Colors.white : labelColor,
              fontSize: 16,
              fontWeight: FontWeight.normal,
              height: 1.43,
            ),
          ).nestedExpanded(),
          if (StringUtil.isNotBlank(tips))
            Text(
              tips!,
              style: const TextStyle(
                color: secondaryTextColor,
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ).nestedPadding(padding: EdgeInsets.only(right: showIcon ? 4 : 0)),
          if (showIcon)
            const Icon(
              Icons.arrow_forward_ios,
              color: borderColor,
              size: 14,
            ),
          if (trailing != null) trailing!,
        ],
      );
    } else {
      child = Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (leading != null) leading!,
              Text(
                name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: labelColor,
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  height: 1.43,
                ),
              ),
              if (StringUtil.isNotBlank(tips))
                Text(
                  tips!,
                  style: const TextStyle(
                    color: secondaryTextColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ).nestedPadding(padding: const EdgeInsets.only(top: 4)),
            ],
          )
              .nestedPadding(padding: EdgeInsets.only(right: showIcon ? 4 : 0))
              .nestedExpanded(),
          if (showIcon)
            const Icon(
              Icons.arrow_forward_ios,
              color: borderColor,
              size: 14,
            ),
          if (trailing != null) trailing!,
        ],
      );
    }

    if (callback != null) {
      child = TextButton(
        style: ButtonStyle(
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          minimumSize: WidgetStateProperty.all(Size.zero),
          padding: WidgetStateProperty.all(
            const EdgeInsets.symmetric(vertical: 16, horizontal: 10),
          ),
          backgroundColor: WidgetStateProperty.all(Colors.transparent),
          overlayColor: WidgetStateProperty.all(overlayColor),
          elevation: WidgetStateProperty.all(0),
        ),
        onPressed: callback,
        child: child,
      );
    } else {
      child = child.nestedPadding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 10),
      );
    }

    if (showBorder) {
      child = child.nestedDecoratedBox(
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(color: borderColor, width: 0.5),
          ),
        ),
      );
    }

    return child;
  }
}

class MineSectionGroup extends StatelessWidget {
  const MineSectionGroup({
    required this.items,
    this.title,
    this.description,
    super.key,
  });

  final String? title;
  final String? description;
  final List<MineSectionModel> items;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final itemWidgets = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(
        items.length,
        (index) {
          final item = items.elementAt(index);
          return MineSectionItem(
            name: item.title,
            showBorder: !(index == items.length - 1),
            labelColor: item.color,
            overlayColor: item.overlayColor,
            callback: item.callback,
            showIcon: item.showIcon,
            direction: item.direction,
            tips: item.tips,
            leading: item.leading,
            trailing: item.trailing,
          );
        },
      ),
    ).nestedDecoratedBox(
      decoration: BoxDecoration(
        color: isDark ? Colors.black12 : secondaryGrayColor,
        borderRadius: BorderRadius.circular(6),
      ),
    );

    if (StringUtil.isNotBlank(title) || StringUtil.isNotBlank(description)) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (StringUtil.isNotBlank(title))
            Text(
              title!,
              style: TextStyle(
                color: isDark ? secondaryBorderColor : secondaryTextColor,
                fontSize: 12,
                fontWeight: FontWeight.w400,
                height: 1.67,
              ),
            ).nestedPadding(
              padding: const EdgeInsets.only(left: 10, bottom: 10),
            ),
          itemWidgets,
          if (StringUtil.isNotBlank(description))
            Text(
              description!,
              style: TextStyle(
                color: isDark ? secondaryBorderColor : secondaryTextColor,
                fontSize: 12,
                fontWeight: FontWeight.w400,
                height: 1.67,
              ),
            ).nestedPadding(
              padding: const EdgeInsets.only(left: 10, top: 10),
            ),
        ],
      ).nestedPadding(
        padding: const EdgeInsets.only(top: 20),
      );
    }

    return itemWidgets.nestedPadding(
      padding: const EdgeInsets.only(top: 20),
    );
  }
}

class MineSectionModel {
  const MineSectionModel({
    required this.title,
    this.color = primaryTextColor,
    this.overlayColor = primaryBackgroundColor,
    this.showIcon = true,
    this.direction = Axis.horizontal,
    this.leading,
    this.trailing,
    this.callback,
    this.tips,
  });

  final Widget? leading;
  final Widget? trailing;
  final String title;
  final VoidCallback? callback;
  final Color color;
  final Color overlayColor;
  final bool showIcon;
  final Axis direction;
  final String? tips;
}
