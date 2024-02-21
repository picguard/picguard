import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:photo_view/photo_view.dart';
import 'package:picguard/app/navigator.dart';
import 'package:picguard/extensions/single.dart';
import 'package:picguard/gen/assets.gen.dart';
import 'package:picguard/theme/colors.dart';
import 'package:picguard/utils/navigator_util.dart';
import 'package:picguard/utils/string_util.dart';

const double _buttonHeight = 54;

///
class DialogUtil {
  ///
  static void showCustomDialog({
    String? title,
    String? content,
    Widget? titleWidget,
    Widget? contentWidget,
    String cancelText = 'Cancel',
    String okText = 'OK',
    Color cancelColor = secondaryTextColor,
    Color okColor = primaryColor,
    bool hideCancel = false,
    bool barrierDismissible = false,
    VoidCallback? onCancel,
    VoidCallback? onOK,
    EdgeInsetsGeometry? titlePadding,
    EdgeInsetsGeometry? contentPadding,
  }) {
    showDialog<void>(
      context: AppNavigator.key.currentContext!,
      barrierDismissible: barrierDismissible,
      builder: (BuildContext context) => AlertDialog(
        title: titleWidget ??
            (StringUtil.isNotBlank(title)
                ? Text(
                    title!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: primaryTextColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  )
                : null),
        content: contentWidget ??
            (StringUtil.isNotBlank(content)
                ? Text(
                    content!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: secondaryTextColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  )
                : null),
        actions: [
          Row(
            children: [
              if (!hideCancel) ...[
                TextButton(
                  onPressed: onCancel ?? NavigatorUtil.pop,
                  style: ButtonStyle(
                    textStyle: MaterialStateProperty.all(
                      const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        height: 1.375,
                      ),
                    ),
                    overlayColor: MaterialStateProperty.all(backgroundColor),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0),
                      ),
                    ),
                  ),
                  child: Text(
                    cancelText,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: cancelColor,
                    ),
                  ),
                ).nestedSizedBox(height: _buttonHeight - 1).nestedExpanded(),
                const ColoredBox(color: borderColor)
                    .nestedSizedBox(width: 1, height: _buttonHeight),
              ],
              TextButton(
                onPressed: onOK,
                style: ButtonStyle(
                  textStyle: MaterialStateProperty.all(
                    const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      height: 1.375,
                    ),
                  ),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0),
                    ),
                  ),
                ),
                child: Text(
                  okText,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: okColor,
                  ),
                ),
              ).nestedSizedBox(height: _buttonHeight - 1).nestedExpanded(),
            ],
          )
              .nestedDecoratedBox(
                decoration: const BoxDecoration(
                  border: Border(top: BorderSide(color: borderColor)),
                ),
              )
              .nestedSizedBox(height: _buttonHeight),
        ],
        titlePadding: titlePadding,
        contentPadding: contentPadding,
        actionsPadding: EdgeInsets.zero,
        buttonPadding: EdgeInsets.zero,
        actionsOverflowButtonSpacing: 0,
        actionsAlignment: MainAxisAlignment.center,
        clipBehavior: Clip.hardEdge,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  ///
  static void showImagePreviewDialog(String id, File file) {
    final context = AppNavigator.key.currentContext!;
    showDialog<void>(
      context: context,
      builder: (context) => PhotoView.customChild(
        backgroundDecoration: const BoxDecoration(color: Colors.black45),
        heroAttributes: PhotoViewHeroAttributes(tag: id),
        initialScale: 1,
        minScale: 0.5,
        maxScale: 2,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(8),
              bottomRight: Radius.circular(8),
            ),
            image: DecorationImage(
              image: (kIsWeb ? NetworkImage(file.path) : FileImage(file))
              as ImageProvider,
              fit: BoxFit.contain,
            ),
          ),
        ).nestedTap(NavigatorUtil.pop),
      ),
    );
  }

  ///
  static void showBottomSheetDialog(
    String title,
    String content, {
    Color? backgroundColor,
    Color? barrierColor,
  }) {
    final context = AppNavigator.key.currentContext!;
    final bottom = MediaQuery.of(context).padding.bottom;
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: backgroundColor,
      barrierColor: barrierColor,
      builder: (BuildContext context) => SingleChildScrollView(
        controller: ModalScrollController.of(context),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  textAlign: TextAlign.start,
                  style: const TextStyle(
                    color: primaryTextColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ).nestedExpanded(),
                Assets.icons.close
                    .image(width: 20, height: 20)
                    .nestedTap(NavigatorUtil.pop),
              ],
            ).nestedPadding(
              padding: const EdgeInsets.only(bottom: 20),
            ),
            Text(
              content,
              style: const TextStyle(
                color: secondaryTextColor,
                fontSize: 14,
                fontWeight: FontWeight.w400,
                height: 1.43,
              ),
            ),
          ],
        ),
      )
          .nestedPadding(
            padding: EdgeInsets.only(
              left: 16,
              top: 20,
              right: 16,
              bottom: 20 + bottom,
            ),
          )
          .nestedColoredBox(color: Colors.white),
    );
  }
}
