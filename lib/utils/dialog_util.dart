// Dart imports:
import 'dart:io';
import 'dart:math';

// Flutter imports:
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:collection/collection.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:url_launcher/url_launcher.dart';

// Project imports:
import 'package:picguard/app/config.dart';
import 'package:picguard/app/navigator.dart';
import 'package:picguard/constants/constants.dart';
import 'package:picguard/extensions/extensions.dart';
import 'package:picguard/generated/colors.gen.dart';
import 'package:picguard/i18n/i18n.dart';
import 'package:picguard/logger/logger.dart';
import 'package:picguard/models/models.dart';
import 'package:picguard/types/types.dart';
import 'package:picguard/utils/utils.dart';
import 'package:picguard/widgets/widgets.dart';

const double _buttonHeight = 54;

///
class DialogUtil {
  static void showLicenseDialog() {
    final context = AppNavigator.key.currentContext!;
    final isContainsKey = SpUtil.containsKey(Keys.licenseKey) ?? false;

    printDebugLog('isContainsKey: $isContainsKey');

    /// 未弹出过隐私协议弹窗
    if (!isContainsKey) {
      final t = Translations.of(context);
      final appName = t.appName(flavor: AppConfig.shared.flavor);
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
                      '${index + 1}. ${(permissionText as StringCallback)(appName: appName)}',
                      style: TextStyle(
                        color: isDark ? Colors.white : PGColors.primaryTextColor,
                        fontSize: 14,
                      ),
                    ).nestedPadding(padding: const EdgeInsets.only(top: 4)),
                  )
                  .toList();

          final iosPermissionTexts = t.dialogs.licenseDialog.iosPermissions
              .mapIndexed(
                (index, permissionText) => Text(
                  '${index + 1}. ${(permissionText as StringCallback)(appName: appName)}',
                  style: TextStyle(
                    color: isDark ? Colors.white : PGColors.primaryTextColor,
                    fontSize: 14,
                  ),
                ).nestedPadding(padding: const EdgeInsets.only(top: 4)),
              )
              .toList();

          return AlertDialog(
            title: Text(
              t.dialogs.licenseDialog.licenseDialogTitle,
              style: TextStyle(
                color: isDark ? Colors.white : PGColors.primaryTextColor,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  t.dialogs.licenseDialog
                      .licenseDialogContentContent(appName: appName),
                  style: TextStyle(
                    color: isDark ? Colors.white : PGColors.primaryTextColor,
                    fontSize: 14,
                  ),
                ),
                Text(
                  t.dialogs.licenseDialog.licenseDialogContentTip,
                  style: TextStyle(
                    color: isDark ? Colors.white : PGColors.primaryTextColor,
                    fontSize: 14,
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
                          color: isDark ? Colors.white : PGColors.primaryTextColor,
                          fontSize: 14,
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
                          color: PGColors.primaryColor,
                          fontSize: 14,
                        ),
                      ),
                      TextSpan(
                        text: t.dialogs.licenseDialog.licenseDialogContentAnd,
                        style: TextStyle(
                          color: isDark ? Colors.white : PGColors.primaryTextColor,
                          fontSize: 14,
                        ),
                      ),
                      TextSpan(
                        text: t.dialogs.licenseDialog
                            .licenseDialogContentPrivacyPolicy,
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
                          color: PGColors.primaryColor,
                          fontSize: 14,
                        ),
                      ),
                      TextSpan(
                        text:
                            t.dialogs.licenseDialog.licenseDialogContentSuffix,
                        style: TextStyle(
                          color: isDark ? Colors.white : PGColors.primaryTextColor,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ).nestedPadding(padding: const EdgeInsets.only(top: 8)),
              ],
            ).nestedSingleChildScrollView().nestedConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: min(width, 600),
                    maxHeight: height * 0.4,
                  ),
                ),
            actions: [
              Row(
                children: [
                  Text(
                    t.buttons.cancel,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: isDark ? Colors.white70 : PGColors.secondaryTextColor,
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
                      color: PGColors.primaryColor,
                      fontSize: 16,
                      height: 1.375,
                    ),
                  )
                      .nestedPadding(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      )
                      .nestedDecoratedBox(
                        decoration: const BoxDecoration(
                          border: Border(left: BorderSide(color: PGColors.borderColor)),
                        ),
                      )
                      .nestedTap(() {
                    SpUtil.putBool(Keys.licenseKey, true);
                    NavigatorUtil.pop();
                  }).nestedExpanded(),
                ],
              ).nestedDecoratedBox(
                decoration: const BoxDecoration(
                  border: Border(top: BorderSide(color: PGColors.borderColor)),
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
    Color cancelColor = PGColors.secondaryTextColor,
    Color okColor = PGColors.primaryColor,
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
                      color: PGColors.primaryTextColor,
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
                      color: PGColors.secondaryTextColor,
                      fontSize: 14,
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
                    textStyle: WidgetStateProperty.all(
                      const TextStyle(
                        fontSize: 16,
                        height: 1.375,
                      ),
                    ),
                    overlayColor: WidgetStateProperty.all(PGColors.backgroundColor),
                    shape: WidgetStateProperty.all(
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
                const ColoredBox(color: PGColors.borderColor)
                    .nestedSizedBox(width: 1, height: _buttonHeight),
              ],
              TextButton(
                onPressed: onOK,
                style: ButtonStyle(
                  textStyle: WidgetStateProperty.all(
                    const TextStyle(
                      fontSize: 16,
                      height: 1.375,
                    ),
                  ),
                  shape: WidgetStateProperty.all(
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
                  border: Border(top: BorderSide(color: PGColors.borderColor)),
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
  static void showImagePreviewDialog(
    List<ImageProvider> imageProviders, {
    int initialPage = 0,
  }) {
    final context = AppNavigator.key.currentContext!;
    final pageController = PageController(initialPage: initialPage);
    showDialog<void>(
      context: context,
      builder: (context) => Stack(
        alignment: Alignment.center,
        children: [
          PhotoViewGallery.builder(
            pageController: pageController,
            scrollPhysics: const AlwaysScrollableScrollPhysics(),
            backgroundDecoration: const BoxDecoration(color: Colors.black45),
            itemCount: imageProviders.length,
            builder: (BuildContext context, int index) {
              final imageProvider = imageProviders.elementAt(index);
              return PhotoViewGalleryPageOptions(
                initialScale: PhotoViewComputedScale.contained,
                imageProvider: imageProvider,
                heroAttributes: PhotoViewHeroAttributes(tag: index),
              );
            },
          ),
          Positioned(
            top: 8,
            right: 8,
            child: IconButton(
              style: ButtonStyle(
                padding: WidgetStateProperty.all(const EdgeInsets.all(4)),
                minimumSize: WidgetStateProperty.all(Size.zero),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                iconColor: WidgetStateProperty.all(Colors.red),
                backgroundColor: WidgetStateProperty.all(PGColors.backgroundColor),
              ),
              onPressed: NavigatorUtil.pop,
              icon: const Icon(Icons.close),
            ),
          ),
        ],
      ),
    );
  }

  ///
  static void showBottomSheetDialog({
    required String content,
    Color? barrierColor,
  }) {
    final context = AppNavigator.key.currentContext!;
    final height = MediaQuery.sizeOf(context).height;
    final bottom = MediaQuery.paddingOf(context).bottom;
    showModalBottomSheet<void>(
      context: context,
      barrierColor: barrierColor,
      showDragHandle: true,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
      ),
      builder: (BuildContext context) {
        final isDark = Theme.of(context).brightness == Brightness.dark;

        final Widget contentWidget = Text(
          content,
          style: TextStyle(
            color: isDark ? Colors.white : PGColors.secondaryTextColor,
            fontSize: 14,
            height: 1.43,
          ),
        );

        return contentWidget
            .nestedSizedBox(width: double.infinity)
            .nestedSingleChildScrollView()
            .nestedPadding(
              padding: EdgeInsets.only(
                left: 16,
                right: 16,
                bottom: 20 + bottom,
              ),
            )
            .nestedConstrainedBox(
              constraints: BoxConstraints(maxHeight: height * 0.7),
            );
      },
    );
  }

  ///
  static void showPGColorModal({
    required List<PGColor> items,
    required VoidPGColorCallback callback,
    int? color,
  }) {
    final context = AppNavigator.key.currentContext!;
    showModalBottomSheet<void>(
      context: context,
      isDismissible: false,
      enableDrag: false,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
      ),
      builder: (BuildContext context) => PGColorModal(
        items: items,
        callback: callback,
        color: color,
      ),
    );
  }

  ///
  static void showFontModal({
    required List<PGFont> items,
    required VoidPGFontCallback callback,
    String? font,
  }) {
    final context = AppNavigator.key.currentContext!;
    showModalBottomSheet<void>(
      context: context,
      isDismissible: false,
      enableDrag: false,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
      ),
      builder: (BuildContext context) => FontModal(
        items: items,
        callback: callback,
        font: font,
      ),
    );
  }

  ///
  static void showSettingsModal() {
    final context = AppNavigator.key.currentContext!;
    showModalBottomSheet<void>(
      context: context,
      isDismissible: false,
      enableDrag: false,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
      ),
      builder: (BuildContext context) => const SettingsModal(),
    );
  }
}
