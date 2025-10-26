// Copyright 2023 Insco. All rights reserved.
// This source code is licensed under the GNU General Public License v3.0.
// See the LICENSE file in the project root for full license information.

import 'dart:math';
import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:about/about.dart';
import 'package:collection/collection.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:url_launcher/url_launcher_string.dart';

import 'package:picguard/app/config.dart';
import 'package:picguard/constants/constants.dart';
import 'package:picguard/generated/assets.gen.dart';
import 'package:picguard/generated/colors.gen.dart';
import 'package:picguard/i18n/i18n.g.dart';
import 'package:picguard/logger/logger.dart';
import 'package:picguard/models/models.dart';
import 'package:picguard/types/types.dart';
import 'package:picguard/utils/utils.dart';
import 'package:picguard/widgets/widgets.dart';

const double _buttonHeight = 54;

///
class DialogUtil {
  static Future<void> showLicenseDialog() async {
    final context = navigatorKey.currentContext!;
    final isContainsKey = getBoolAsync(Keys.licenseKey);

    printDebugLog('isContainsKey: $isContainsKey');

    /// 未弹出过隐私协议弹窗
    if (!isContainsKey) {
      final t = Translations.of(context);
      final appName = t.appName(flavor: AppConfig.shared.flavor);
      final languageCode = LocaleSettings.currentLocale.languageCode;

      final width = MediaQuery.sizeOf(context).width;
      final height = MediaQuery.sizeOf(context).height;

      await showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          final isDark = Theme.of(context).brightness == Brightness.dark;

          final androidPermissionTexts = t
              .dialogs
              .licenseDialog
              .androidPermissions
              .mapIndexed(
                (index, permissionText) => Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(
                    '${index + 1}. ${(permissionText as StringCallback)(
                      appName: appName,
                    )}',
                    style: TextStyle(
                      color: isDark ? Colors.white : PGColors.primaryTextColor,
                      fontSize: 14,
                    ),
                  ),
                ),
              )
              .toList();

          final iosPermissionTexts = t.dialogs.licenseDialog.iosPermissions
              .mapIndexed(
                (index, permissionText) => Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(
                    '${index + 1}. ${(permissionText as StringCallback)(
                      appName: appName,
                    )}',
                    style: TextStyle(
                      color: isDark ? Colors.white : PGColors.primaryTextColor,
                      fontSize: 14,
                    ),
                  ),
                ),
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
            content: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: min(width, 600),
                maxHeight: height * 0.4,
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      t.dialogs.licenseDialog.licenseDialogContentContent(
                        appName: appName,
                      ),
                      style: TextStyle(
                        color: isDark
                            ? Colors.white
                            : PGColors.primaryTextColor,
                        fontSize: 14,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text(
                        t.dialogs.licenseDialog.licenseDialogContentTip,
                        style: TextStyle(
                          color: isDark
                              ? Colors.white
                              : PGColors.primaryTextColor,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    if (isAndroid) ...androidPermissionTexts,
                    if (isIOS) ...iosPermissionTexts,
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: t
                                  .dialogs
                                  .licenseDialog
                                  .licenseDialogContentPrefix,
                              style: TextStyle(
                                color: isDark
                                    ? Colors.white
                                    : PGColors.primaryTextColor,
                                fontSize: 14,
                              ),
                            ),
                            TextSpan(
                              text: t
                                  .dialogs
                                  .licenseDialog
                                  .licenseDialogContentUserAgreement,
                              recognizer: TapGestureRecognizer()
                                ..onTap = () async {
                                  final uri =
                                      '$websiteBaseUrl/$languageCode/legal/terms-of-use/';
                                  if (await canLaunchUrlString(uri)) {
                                    await launchUrlString(uri);
                                  }
                                },
                              style: const TextStyle(
                                color: PGColors.primaryColor,
                                fontSize: 14,
                              ),
                            ),
                            TextSpan(
                              text: t
                                  .dialogs
                                  .licenseDialog
                                  .licenseDialogContentAnd,
                              style: TextStyle(
                                color: isDark
                                    ? Colors.white
                                    : PGColors.primaryTextColor,
                                fontSize: 14,
                              ),
                            ),
                            TextSpan(
                              text: t
                                  .dialogs
                                  .licenseDialog
                                  .licenseDialogContentPrivacyPolicy,
                              recognizer: TapGestureRecognizer()
                                ..onTap = () async {
                                  final uri =
                                      '$websiteBaseUrl/$languageCode/legal/privacy/';
                                  if (await canLaunchUrlString(uri)) {
                                    await launchUrlString(uri);
                                  }
                                },
                              style: const TextStyle(
                                color: PGColors.primaryColor,
                                fontSize: 14,
                              ),
                            ),
                            TextSpan(
                              text: t
                                  .dialogs
                                  .licenseDialog
                                  .licenseDialogContentSuffix,
                              style: TextStyle(
                                color: isDark
                                    ? Colors.white
                                    : PGColors.primaryTextColor,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            actions: [
              DecoratedBox(
                decoration: const BoxDecoration(
                  border: Border(top: BorderSide(color: PGColors.borderColor)),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () async {
                          await setValue(Keys.licenseKey, false);
                          NavigatorUtil.pop();
                          // exit(0);
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          child: Text(
                            t.buttons.cancel,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: isDark
                                  ? Colors.white70
                                  : PGColors.secondaryTextColor,
                              fontSize: 16,
                              height: 1.375,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () async {
                          await setValue(Keys.licenseKey, true);
                          NavigatorUtil.pop();
                        },
                        child: DecoratedBox(
                          decoration: const BoxDecoration(
                            border: Border(
                              left: BorderSide(color: PGColors.borderColor),
                            ),
                          ),
                          child: Text(
                            t.buttons.agree,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: PGColors.primaryColor,
                              fontSize: 16,
                              height: 1.375,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
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

  static Future<AppExitResponse?> showExitDialog() async {
    final context = navigatorKey.currentContext!;

    return showDialog<AppExitResponse>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        final t = Translations.of(context);
        final isDark = Theme.of(context).brightness == Brightness.dark;

        final width = MediaQuery.sizeOf(context).width;
        final height = MediaQuery.sizeOf(context).height;

        return AlertDialog(
          title: Text(
            t.dialogs.exitDialog.title,
            style: TextStyle(
              color: isDark ? Colors.white : PGColors.primaryTextColor,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
          content: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: min(width, 600),
              maxHeight: height * 0.4,
            ),
            child:Text(
              t.dialogs.exitDialog.description,
              style: TextStyle(
                color: isDark
                    ? Colors.white
                    : PGColors.primaryTextColor,
                fontSize: 14,
              ),
            ),
          ),
          actions: [
            DecoratedBox(
              decoration: const BoxDecoration(
                border: Border(top: BorderSide(color: PGColors.borderColor)),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => NavigatorUtil.pop(AppExitResponse.cancel),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: Text(
                          t.buttons.cancel,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: isDark
                                ? Colors.white70
                                : PGColors.secondaryTextColor,
                            fontSize: 16,
                            height: 1.375,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => NavigatorUtil.pop(AppExitResponse.exit),
                      child: DecoratedBox(
                        decoration: const BoxDecoration(
                          border: Border(
                            left: BorderSide(color: PGColors.borderColor),
                          ),
                        ),
                        child: Text(
                          t.dialogs.exitConfirm.exit,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: PGColors.primaryColor,
                            fontSize: 16,
                            height: 1.375,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
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

  ///
  static Future<void> showCustomDialog({
    String? title,
    String? content,
    Widget? titleWidget,
    Widget? contentWidget,
    String cancelText = 'Cancel',
    String okText = 'OK',
    Color okColor = PGColors.primaryColor,
    bool hideCancel = false,
    bool barrierDismissible = false,
    VoidCallback? onCancel,
    VoidCallback? onOK,
    EdgeInsetsGeometry? titlePadding,
    EdgeInsetsGeometry? contentPadding,
  }) async {
    await showDialog<void>(
      context: navigatorKey.currentContext!,
      barrierDismissible: barrierDismissible,
      builder: (BuildContext context) {
        final isDark = Theme.of(context).brightness == Brightness.dark;
        return AlertDialog(
          title:
              titleWidget ??
              (StringUtil.isNotBlank(title)
                  ? Text(
                      title!,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: isDark
                            ? PGColors.white
                            : PGColors.primaryTextColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    )
                  : null),
          content:
              contentWidget ??
              (StringUtil.isNotBlank(content)
                  ? Text(
                      content!,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: isDark
                            ? PGColors.white
                            : PGColors.secondaryTextColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    )
                  : null),
          actions: [
            SizedBox(
              height: _buttonHeight,
              child: DecoratedBox(
                decoration: const BoxDecoration(
                  border: Border(
                    top: BorderSide(color: PGColors.borderColor),
                  ),
                ),
                child: Row(
                  children: [
                    if (!hideCancel) ...[
                      Expanded(
                        child: SizedBox(
                          height: _buttonHeight - 1,
                          child: TextButton(
                            onPressed: onCancel ?? NavigatorUtil.pop,
                            style: ButtonStyle(
                              textStyle: WidgetStateProperty.all(
                                const TextStyle(
                                  fontSize: 16,
                                  height: 1.375,
                                ),
                              ),
                              overlayColor: WidgetStateProperty.all(
                                isDark
                                    ? PGColors.warnTextColor.withValues(
                                        alpha: 0.1,
                                      )
                                    : PGColors.secondaryBackgroundColor,
                              ),
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
                                color: isDark
                                    ? Colors.white
                                    : PGColors.secondaryTextColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 1,
                        height: _buttonHeight,
                        child: ColoredBox(
                          color: PGColors.borderColor,
                        ),
                      ),
                    ],
                    Expanded(
                      child: SizedBox(
                        height: _buttonHeight - 1,
                        child: TextButton(
                          onPressed: onOK,
                          style: ButtonStyle(
                            textStyle: WidgetStateProperty.all(
                              const TextStyle(
                                fontSize: 16,
                                height: 1.375,
                              ),
                            ),
                            overlayColor: WidgetStateProperty.all(
                              isDark
                                  ? PGColors.primaryHoverColor.withValues(
                                      alpha: 0.1,
                                    )
                                  : PGColors.primaryBackgroundColor,
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
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
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
        );
      },
    );
  }

  ///
  static Future<void> showImagePreviewDialog(
    List<ImageProvider> imageProviders, {
    int initialPage = 0,
  }) async {
    final context = navigatorKey.currentContext!;
    final pageController = PageController(initialPage: initialPage);
    await showDialog<void>(
      context: context,
      builder: (context) => Stack(
        alignment: Alignment.center,
        children: [
          PhotoViewGallery.builder(
            pageController: pageController,
            scrollPhysics: const AlwaysScrollableScrollPhysics(),
            backgroundDecoration: const BoxDecoration(
              color: Colors.black45,
            ),
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
                backgroundColor: WidgetStateProperty.all(
                  PGColors.backgroundColor,
                ),
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
  static Future<void> showBottomSheetDialog({
    required String content,
    Color? barrierColor,
  }) async {
    final context = navigatorKey.currentContext!;
    final height = MediaQuery.sizeOf(context).height;
    final bottom = MediaQuery.paddingOf(context).bottom;
    await showModalBottomSheet<void>(
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

        return ConstrainedBox(
          constraints: BoxConstraints(maxHeight: height * 0.7),
          child: Padding(
            padding: EdgeInsets.only(
              left: 16,
              right: 16,
              bottom: 20 + bottom,
            ),
            child: SingleChildScrollView(
              child: SizedBox(
                width: double.infinity,
                child: contentWidget,
              ),
            ),
          ),
        );
      },
    );
  }

  ///
  static Future<void> showPGColorModal({
    required List<PGColor> items,
    required VoidPGColorCallback callback,
    int? color,
  }) async {
    final context = navigatorKey.currentContext!;
    await showModalBottomSheet<void>(
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
  static Future<void> showFontModal({
    required List<PGFont> items,
    required VoidPGFontCallback callback,
    String? font,
  }) async {
    final context = navigatorKey.currentContext!;
    await showModalBottomSheet<void>(
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
  static Future<void> showSettingsModal() async {
    final context = navigatorKey.currentContext!;
    await showModalBottomSheet<void>(
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

  ///
  static Future<void> showAboutModal() async {
    final context = navigatorKey.currentContext!;
    final t = Translations.of(context);
    final isPro = AppConfig.shared.isPro;
    final logo = isPro ? Assets.logo.pro.logo512 : Assets.logo.logo512;
    final appName = t.appName(flavor: AppConfig.shared.flavor);
    final packageInfo = await PackageInfo.fromPlatform();

    if (!context.mounted) {
      return;
    }

    final version = packageInfo.version;
    final buildNumber = packageInfo.buildNumber;
    final titleName = t.menus.about(appName: appName);

    await showAboutPage(
      context: context,
      title: Text(titleName),
      applicationIcon: logo.image(width: 100, height: 100),
      applicationName: appName,
      applicationVersion: t.aboutPage.version(
        version: version,
        buildNumber: buildNumber,
      ),
      applicationLegalese: t.aboutPage.copyright(
        year: '2023-${DateTime.now().year}',
        appName: appName,
      ),
      scaffoldBuilder:
          (
            BuildContext context,
            Widget title,
            Widget child,
          ) {
            final isDark = Theme.of(context).brightness == Brightness.dark;
            return SelectionArea(
              child: Scaffold(
                appBar: PGAppBar(
                  titleName: titleName,
                  isDark: isDark,
                  showBottom: false,
                ),
                body: child,
              ),
            );
          },
      applicationDescription: Text(
        t.aboutPage.slogan,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
      children: <Widget>[
        ListTile(
          leading: const Icon(Icons.all_inclusive),
          title: Text(t.aboutPage.readme),
          trailing: Icon(
            Directionality.of(context) == TextDirection.ltr
                ? Icons.chevron_right
                : Icons.chevron_left,
          ),
          onTap: () => gotoPage('/blob/v$version/README.md'),
        ),
        ListTile(
          leading: const Icon(Icons.description),
          title: Text(t.aboutPage.appLicense),
          trailing: Icon(
            Directionality.of(context) == TextDirection.ltr
                ? Icons.chevron_right
                : Icons.chevron_left,
          ),
          onTap: () => gotoPage('/blob/v$version/LICENSE'),
        ),
        ListTile(
          leading: const Icon(Icons.list),
          title: Text(t.aboutPage.changelog),
          trailing: Icon(
            Directionality.of(context) == TextDirection.ltr
                ? Icons.chevron_right
                : Icons.chevron_left,
          ),
          onTap: () => gotoPage('/releases/tag/v$version'),
        ),
        LicensesPageListTile(
          icon: const Icon(Icons.favorite),
          title: Text(t.aboutPage.thirdPartyLicense),
        ),
        ListTile(
          leading: const Icon(Icons.privacy_tip),
          title: Text(t.menus.privacy),
          trailing: Icon(
            Directionality.of(context) == TextDirection.ltr
                ? Icons.chevron_right
                : Icons.chevron_left,
          ),
          onTap: gotoPrivacyPage,
        ),
        ListTile(
          leading: const Icon(Icons.account_circle),
          title: Text(t.menus.userAgreement),
          trailing: Icon(
            Directionality.of(context) == TextDirection.ltr
                ? Icons.chevron_right
                : Icons.chevron_left,
          ),
          onTap: gotoTermsOfUsePage,
        ),
        ListTile(
          leading: const Icon(Icons.support),
          title: Text(t.menus.support),
          trailing: Icon(
            Directionality.of(context) == TextDirection.ltr
                ? Icons.chevron_right
                : Icons.chevron_left,
          ),
          onTap: gotoSupportPage,
        ),
      ],
    );
  }
}
