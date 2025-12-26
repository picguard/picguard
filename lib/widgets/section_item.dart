// Copyright 2023 Qiazo. All rights reserved.
// This source code is licensed under the GNU General Public License v3.0.
// See the LICENSE file in the project root for full license information.

import 'package:flutter/material.dart';

import 'package:picguard/generated/colors.gen.dart';
import 'package:picguard/utils/utils.dart';

class MineSectionItem extends StatelessWidget {
  const MineSectionItem({
    required this.name,
    this.labelColor = PGColors.primaryTextColor,
    this.overlayColor = PGColors.primaryBackgroundColor,
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
          ?leading,
          Expanded(
            child: Text(
              name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: isDark ? Colors.white : labelColor,
                fontSize: 16,
                fontWeight: FontWeight.normal,
                height: 1.43,
              ),
            ),
          ),
          if (StringUtil.isNotBlank(tips))
            Padding(
              padding: EdgeInsets.only(right: showIcon ? 4 : 0),
              child: Text(
                tips!,
                style: const TextStyle(
                  color: PGColors.secondaryTextColor,
                  fontSize: 12,
                ),
              ),
            ),
          if (showIcon)
            const Icon(
              Icons.arrow_forward_ios,
              color: PGColors.borderColor,
              size: 14,
            ),
          ?trailing,
        ],
      );
    } else {
      child = Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: showIcon ? 4 : 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ?leading,
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
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Text(
                        tips!,
                        style: const TextStyle(
                          color: PGColors.secondaryTextColor,
                          fontSize: 12,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
          if (showIcon)
            const Icon(
              Icons.arrow_forward_ios,
              color: PGColors.borderColor,
              size: 14,
            ),
          ?trailing,
        ],
      );
    }

    if (callback != null) {
      child = TextButton(
        style: ButtonStyle(
          tapTargetSize: .shrinkWrap,
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
      child = Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 10),
        child: child,
      );
    }

    if (showBorder) {
      child = DecoratedBox(
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(color: PGColors.borderColor, width: 0.5),
          ),
        ),
        child: child,
      );
    }

    return child;
  }
}

class MineSectionGroup<T> extends StatelessWidget {
  const MineSectionGroup({
    required this.items,
    this.groupValue,
    this.onChanged,
    this.title,
    this.description,
    super.key,
  });

  final String? title;
  final String? description;
  final T? groupValue;
  final ValueChanged<T?>? onChanged;
  final List<MineSectionModel> items;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final itemWidgets = DecoratedBox(
      decoration: BoxDecoration(
        color: isDark ? Colors.black12 : PGColors.secondaryGrayColor,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
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
      ),
    );

    if (StringUtil.isNotBlank(title) || StringUtil.isNotBlank(description)) {
      return Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (StringUtil.isNotBlank(title))
              Padding(
                padding: const EdgeInsets.only(left: 10, bottom: 10),
                child: Text(
                  title!,
                  style: TextStyle(
                    color: isDark
                        ? PGColors.secondaryBorderColor
                        : PGColors.secondaryTextColor,
                    fontSize: 12,
                    height: 1.67,
                  ),
                ),
              ),
            if (groupValue != null && onChanged != null)
              RadioGroup(
                groupValue: groupValue,
                onChanged: onChanged!,
                child: itemWidgets,
              )
            else
              itemWidgets,
            if (StringUtil.isNotBlank(description))
              Padding(
                padding: const EdgeInsets.only(left: 10, top: 10),
                child: Text(
                  description!,
                  style: TextStyle(
                    color: isDark
                        ? PGColors.secondaryBorderColor
                        : PGColors.secondaryTextColor,
                    fontSize: 12,
                    height: 1.67,
                  ),
                ),
              ),
          ],
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: itemWidgets,
    );
  }
}

class MineSectionModel {
  const MineSectionModel({
    required this.title,
    this.color = PGColors.primaryTextColor,
    this.overlayColor = PGColors.primaryBackgroundColor,
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
