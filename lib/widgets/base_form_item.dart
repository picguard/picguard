// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:picguard/extensions/extensions.dart';
import 'package:picguard/generated/colors.gen.dart';

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
                          : widget.tipWidget!.nestedTap(
                              () {
                                widget.onTipTap?.call();
                              },
                            ),
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
    return Text.rich(
      TextSpan(
        children: [
          if (widget.required)
            const TextSpan(
              text: '*',
              style: TextStyle(
                color: PGColors.errorTextColor,
                fontSize: 14,
              ),
            ),
          TextSpan(
            text: widget.title,
            style: TextStyle(
              color: isDark ? Colors.white : PGColors.primaryTextColor,
              fontSize: 14,
            ),
          ),
        ],
      ),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget get tips {
    return IconButton(
      style: ButtonStyle(
        padding: WidgetStateProperty.all(EdgeInsets.zero),
        elevation: WidgetStateProperty.all(0),
        minimumSize: WidgetStateProperty.all(Size.zero),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      onPressed: widget.onTipTap,
      icon: const Icon(
        Icons.info,
        size: 16,
        color: PGColors.primaryColor,
      ),
    ).nestedPadding(padding: const EdgeInsets.only(left: 4));
  }
}
