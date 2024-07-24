import 'dart:developer';
import 'dart:io';

import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:picguard/app/navigator.dart';
import 'package:picguard/constants/constants.dart';
import 'package:picguard/extensions/extensions.dart';
import 'package:picguard/i18n/i18n.dart';
import 'package:picguard/models/models.dart';
import 'package:picguard/theme/colors.dart';
import 'package:picguard/utils/utils.dart';
import 'package:picguard/widgets/widgets.dart';
import 'package:url_launcher/url_launcher.dart';

const double _buttonHeight = 54;

///
class DialogUtil {
  static void showLicenseDialog() {
    final context = AppNavigator.key.currentContext!;
    final isContainsKey = SpUtil.containsKey(Keys.licenseKey) ?? false;

    log('isContainsKey: $isContainsKey');

    /// 未弹出过隐私协议弹窗
    if (!isContainsKey && isShowLicenseDialog) {
      final t = Translations.of(context);
      final languageCode = LocaleSettings.currentLocale.languageCode;

      final width = MediaQuery.sizeOf(context).width;
      final height = MediaQuery.sizeOf(context).height;

      showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          final isDark = Theme.of(context).brightness == Brightness.dark;

          final androidPermissionTexts =
              t.dialogs.licenseDialog.androidPermissions
                  .mapIndexed(
                    (index, permissionText) => Text(
                      '${index + 1}. $permissionText',
                      style: TextStyle(
                        color: isDark ? Colors.white : primaryTextColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ).nestedPadding(padding: const EdgeInsets.only(top: 4)),
                  )
                  .toList();

          final iosPermissionTexts = t.dialogs.licenseDialog.iosPermissions
              .mapIndexed(
                (index, permissionText) => Text(
                  '${index + 1}. $permissionText',
                  style: TextStyle(
                    color: isDark ? Colors.white : primaryTextColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ).nestedPadding(padding: const EdgeInsets.only(top: 4)),
              )
              .toList();

          return AlertDialog(
            title: Text(
              t.dialogs.licenseDialog.licenseDialogTitle,
              style: TextStyle(
                color: isDark ? Colors.white : primaryTextColor,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  t.dialogs.licenseDialog.licenseDialogContentContent,
                  style: TextStyle(
                    color: isDark ? Colors.white : primaryTextColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text(
                  t.dialogs.licenseDialog.licenseDialogContentTip,
                  style: TextStyle(
                    color: isDark ? Colors.white : primaryTextColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ).nestedPadding(padding: const EdgeInsets.only(top: 8)),
                if (Platform.isAndroid) ...androidPermissionTexts,
                if (Platform.isIOS) ...iosPermissionTexts,
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text:
                            t.dialogs.licenseDialog.licenseDialogContentPrefix,
                        style: TextStyle(
                          color: isDark ? Colors.white : primaryTextColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      TextSpan(
                        text: t.dialogs.licenseDialog
                            .licenseDialogContentUserAgreement,
                        recognizer: TapGestureRecognizer()
                          ..onTap = () async {
                            final uri = Uri.parse(
                              'https://www.picguard.app/$languageCode/legal/terms-of-use/',
                            );
                            if (await canLaunchUrl(uri)) {
                              await launchUrl(uri);
                            }
                          },
                        style: const TextStyle(
                          color: primaryColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      TextSpan(
                        text: t.dialogs.licenseDialog.licenseDialogContentAnd,
                        style: TextStyle(
                          color: isDark ? Colors.white : primaryTextColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      TextSpan(
                        text: t.dialogs.licenseDialog
                            .licenseDialogContentPrivacyAgreement,
                        recognizer: TapGestureRecognizer()
                          ..onTap = () async {
                            final uri = Uri.parse(
                              'https://www.picguard.app/$languageCode/legal/privacy/',
                            );
                            if (await canLaunchUrl(uri)) {
                              await launchUrl(uri);
                            }
                          },
                        style: const TextStyle(
                          color: primaryColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      TextSpan(
                        text:
                            t.dialogs.licenseDialog.licenseDialogContentSuffix,
                        style: TextStyle(
                          color: isDark ? Colors.white : primaryTextColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ).nestedPadding(padding: const EdgeInsets.only(top: 8)),
              ],
            )
                .nestedSingleChildScrollView()
                .nestedConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: height * 0.4,
                  ),
                )
                .nestedSizedBox(width: width),
            actions: [
              Row(
                children: [
                  Text(
                    t.buttons.cancel,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: isDark ? Colors.white70 : secondaryTextColor,
                      fontSize: 16,
                      height: 1.375,
                    ),
                  )
                      .nestedPadding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  )
                      .nestedTap(() {
                    SpUtil.putBool(Keys.licenseKey, false);
                    NavigatorUtil.pop();
                    // exit(0);
                  }).nestedExpanded(),
                  Text(
                    t.buttons.agree,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: primaryColor,
                      fontSize: 16,
                      height: 1.375,
                    ),
                  )
                      .nestedPadding(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      )
                      .nestedDecoratedBox(
                        decoration: const BoxDecoration(
                          border: Border(left: BorderSide(color: borderColor)),
                        ),
                      )
                      .nestedTap(() {
                    SpUtil.putBool(Keys.licenseKey, true);
                    NavigatorUtil.pop();
                  }).nestedExpanded(),
                ],
              ).nestedDecoratedBox(
                decoration: const BoxDecoration(
                  border: Border(top: BorderSide(color: borderColor)),
                ),
              ),
            ],
            actionsPadding: EdgeInsets.zero,
            buttonPadding: EdgeInsets.zero,
            actionsOverflowButtonSpacing: 0,
            actionsAlignment: MainAxisAlignment.center,
            contentPadding: const EdgeInsets.all(20),
            insetPadding: const EdgeInsets.symmetric(horizontal: 20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          );
        },
      );
    }
  }

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
  static void showImagePreviewDialog(String id, String path) {
    final context = AppNavigator.key.currentContext!;
    showDialog<void>(
      context: context,
      builder: (context) => PhotoView.customChild(
        backgroundDecoration: const BoxDecoration(color: Colors.black45),
        heroAttributes: PhotoViewHeroAttributes(tag: id),
        initialScale: 1.0,
        minScale: 0.5,
        maxScale: 2.0,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(8),
              bottomRight: Radius.circular(8),
            ),
            image: DecorationImage(
              image: (kIsWeb ? NetworkImage(path) : FileImage(File(path)))
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
    Color? barrierColor,
  }) {
    final context = AppNavigator.key.currentContext!;
    final bottom = MediaQuery.paddingOf(context).bottom;
    showModalBottomSheet<void>(
      context: context,
      barrierColor: barrierColor,
      isDismissible: false,
      enableDrag: false,
      builder: (BuildContext context) {
        final isDark = Theme.of(context).brightness == Brightness.dark;
        return SingleChildScrollView(
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
                    style: TextStyle(
                      color: isDark ? Colors.white : primaryTextColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ).nestedExpanded(),
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
                padding: const EdgeInsets.only(bottom: 20),
              ),
              Text(
                content,
                style: TextStyle(
                  color: isDark ? Colors.white : secondaryTextColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  height: 1.43,
                ),
              ),
            ],
          ),
        ).nestedPadding(
          padding: EdgeInsets.only(
            left: 16,
            top: 20,
            right: 16,
            bottom: 20 + bottom,
          ),
        );
      },
    );
  }

  ///
  static void showPGColorModal({
    required List<PGColor> items,
    required VoidPGColorCallback callback,
  }) {
    final context = AppNavigator.key.currentContext!;
    showModalBottomSheet<void>(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      builder: (BuildContext context) => PGColorModal(
        items: items,
        callback: callback,
      ),
    );
  }
}
