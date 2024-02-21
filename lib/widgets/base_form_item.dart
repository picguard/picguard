import 'package:flutter/material.dart';
import 'package:picguard/extensions/extensions.dart';
import 'package:picguard/gen/assets.gen.dart';
import 'package:picguard/theme/colors.dart';

///
typedef BaseFormItemCallback = void Function();

///
class BaseFormItem extends StatefulWidget {
  ///
  const BaseFormItem({
    required this.child,
    this.title,
    this.required = true,
    this.showTip = true,
    this.padding = const EdgeInsets.only(top: 10),
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.mainAxisSize = MainAxisSize.max,
    this.tipWidget,
    this.onTipTap,
    super.key,
  });

  final Widget child;
  final String? title;
  final bool required;
  final bool showTip;
  final EdgeInsetsGeometry padding;
  final MainAxisAlignment mainAxisAlignment;
  final MainAxisSize mainAxisSize;
  final Widget? tipWidget;
  final BaseFormItemCallback? onTipTap;

  @override
  State<BaseFormItem> createState() => _BaseFormItemState();
}

class _BaseFormItemState extends State<BaseFormItem> {
  @override
  Widget build(BuildContext context) {
    return widget.title != null
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: widget.mainAxisSize,
            children: [
              if (!widget.showTip)
                content
              else
                content
                    .addWidgetAsList(
                      widget.tipWidget == null
                          ? tips
                          : widget.tipWidget!.nestedTap(() {
                              widget.onTipTap?.call();
                            }),
                    )
                    .nestedRow(mainAxisAlignment: widget.mainAxisAlignment),
              widget.child,
            ],
          ).nestedPadding(padding: widget.padding)
        : Padding(
            padding: widget.padding,
            child: widget.child,
          );
  }

  Widget get content {
    final brightness = Theme.of(context).brightness;
    final isDark = brightness == Brightness.dark;
    return RichText(
      text: TextSpan(
        children: [
          if (widget.required)
            const TextSpan(
              text: '*',
              style: TextStyle(
                color: errorTextColor,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
          TextSpan(
            text: widget.title,
            style: TextStyle(
              color: isDark ? Colors.white: primaryTextColor,
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget get tips {
    return Assets.icons.info
        .image(height: 12, width: 12)
        .nestedPadding(
          padding: const EdgeInsets.only(left: 4),
        )
        .nestedTap(() {
      widget.onTipTap?.call();
    });
  }
}
