// Copyright 2023 Insco. All rights reserved.
// This source code is licensed under the GNU General Public License v3.0.
// See the LICENSE file in the project root for full license information.

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:bot_toast/bot_toast.dart';
import 'package:desktop_drop/desktop_drop.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart' hide TextInput;
import 'package:mime/mime.dart';

import 'package:app_settings/app_settings.dart';
import 'package:collection/collection.dart';
import 'package:file_picker/file_picker.dart';
import 'package:file_saver/file_saver.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:gap/gap.dart';
import 'package:image_gallery_saver_plus/image_gallery_saver_plus.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart' hide TextDirection;
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:multi_image_picker_view/multi_image_picker_view.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:path/path.dart' hide context;

import 'package:picguard/app/config.dart';
import 'package:picguard/constants/constants.dart';
import 'package:picguard/constants/uuid.dart';
import 'package:picguard/generated/colors.gen.dart';
import 'package:picguard/i18n/i18n.g.dart';
import 'package:picguard/logger/logger.dart';
import 'package:picguard/models/models.dart';
import 'package:picguard/utils/utils.dart';
import 'package:picguard/widgets/widgets.dart';

///
class HomePage extends StatefulWidget {
  ///
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late MultiImagePickerController controller;
  final _key = GlobalKey<ExpandableFabState>();
  final _formKey = GlobalKey<FormBuilderState>();
  final inputFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    controller =
        MultiImagePickerController(
          maxImages: 9,
          images: <ImageFile>[],
          picker: (limit, params) async => _pickImages(limit),
        )..addListener(() {
          if (mounted) {
            setState(() {});
          }
        });

    LocaleSettings.getLocaleStream().listen((event) {
      printDebugLog('locale changed: $event');
    });

    SchedulerBinding.instance.addPostFrameCallback((timestamp) {
      if (isMobile) {
        DialogUtil.showLicenseDialog();
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final appName = t.appName(flavor: AppConfig.shared.flavor);
    const padding = EdgeInsets.symmetric(
      horizontal: paddingSize,
      vertical: 20,
    );

    Widget child = Scaffold(
      appBar: isMobile
          ? PGAppBar(
              titleWidget: Text(appName),
              isDark: isDark,
              actions: const [
                IconBtn(
                  icon: Icons.settings,
                  onPressed: DialogUtil.showSettingsModal,
                ),
                IconBtn(
                  icon: Icons.info,
                  iconColor: PGColors.warnTextColor,
                  overlayColor: PGColors.backgroundColor,
                  onPressed: DialogUtil.showAboutModal,
                ),
              ],
            )
          : isWeb && PgEnv.appPreviewEnabled
          ? PGAppBar(
              titleWidget: Text(
                t.homePage.appPreview,
                style: const TextStyle(
                  color: Colors.red,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 2,
                textAlign: TextAlign.center,
              ),
              isDark: isDark,
              showBottom: false,
            )
          : null,
      body: DropArea(
        onDragEntered: _onDragEntered,
        onDragExited: _onDragExited,
        onDragDone: _onDragDone,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final maxWidth = constraints.maxWidth;
            late Widget child;
            if ((isWeb || isDesktop) && maxWidth >= 800) {
              child = SingleChildScrollView(
                padding: padding,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 10,
                  children: [
                    Flexible(
                      flex: 6,
                      fit: FlexFit.tight,
                      child: Column(
                        spacing: 10,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ImageGroup(
                            controller: controller,
                          ),
                          const AppDescription(),
                        ],
                      ),
                    ),
                    Flexible(
                      flex: 4,
                      fit: FlexFit.tight,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          FormBuilder(
                            key: _formKey,
                            child: Column(
                              spacing: 5,
                              children: [
                                TextInput(focusNode: inputFocusNode),
                                const ColorPicker(),
                                const OpacityPicker(),
                                if (AppConfig.shared.isPro) ...[
                                  const FontPicker(),
                                  const FontSizePicker(),
                                  const TextColumnGap(),
                                  const TextRowGap(),
                                ],
                              ],
                            ),
                          ),
                          const Gap(20),
                          PreviewBtn(
                            onPressed: controller.images.isNotEmpty
                                ? _preview
                                : null,
                          ),
                          const Gap(10),
                          SaveBtn(
                            onPressed: controller.images.isNotEmpty
                                ? _save
                                : null,
                          ),
                          const Gap(14),
                          const AppVersion(),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            } else {
              child = ListView(
                padding: padding,
                shrinkWrap: true,
                children: [
                  ImageGroup(
                    controller: controller,
                  ),
                  const Gap(10),
                  const AppDescription(),
                  const Gap(10),
                  FormBuilder(
                    key: _formKey,
                    child: Column(
                      spacing: 5,
                      children: [
                        TextInput(focusNode: inputFocusNode),
                        const ColorPicker(),
                        const OpacityPicker(),
                        if (AppConfig.shared.isPro) ...[
                          const FontPicker(),
                          const FontSizePicker(),
                          const TextColumnGap(),
                          const TextRowGap(),
                        ],
                      ],
                    ),
                  ),
                  const Gap(20),
                  PreviewBtn(
                    onPressed: controller.images.isNotEmpty ? _preview : null,
                  ),
                  const Gap(10),
                  SaveBtn(
                    onPressed: controller.images.isNotEmpty ? _save : null,
                  ),
                  const Gap(14),
                  const AppVersion(),
                ],
              );
            }

            // if (isMobile) {
            //   return child;
            // }

            return Stack(
              fit: StackFit.expand,
              children: [
                child,
              ],
            );
          },
        ),
      ),
      floatingActionButtonLocation: ExpandableFab.location,
      floatingActionButton: isWeb
          ? ExpandableFab(
              key: _key,
              duration: const Duration(milliseconds: 500),
              distance: 60,
              type: ExpandableFabType.up,
              // pos: ExpandableFabPos.left,
              // childrenOffset: const Offset(0, 20),
              childrenAnimation: ExpandableFabAnimation.none,
              fanAngle: 40,
              openButtonBuilder: RotateFloatingActionButtonBuilder(
                child: const Icon(Icons.menu),
                fabSize: ExpandableFabSize.small,
                foregroundColor: PGColors.primaryColor,
                backgroundColor: PGColors.primaryBackgroundColor,
                shape: const CircleBorder(),
              ),
              closeButtonBuilder: FloatingActionButtonBuilder(
                size: 44,
                builder:
                    (
                      BuildContext context,
                      void Function()? onPressed,
                      Animation<double> progress,
                    ) {
                      return IconButton(
                        onPressed: onPressed,
                        style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.all(
                            PGColors.backgroundColor,
                          ),
                          foregroundColor: WidgetStateProperty.all(
                            PGColors.warnTextColor,
                          ),
                        ),
                        icon: const Icon(
                          Icons.close,
                          size: 24,
                        ),
                      );
                    },
              ),
              overlayStyle: ExpandableFabOverlayStyle(
                color: Colors.black.withValues(alpha: 0.5),
                blur: 5,
              ),
              children: [
                IconBtn(
                  icon: Icons.settings,
                  onPressed: () {
                    _key.currentState?.toggle();
                    DialogUtil.showSettingsModal();
                  },
                ),
                IconBtn(
                  icon: Icons.info,
                  iconColor: PGColors.warnTextColor,
                  overlayColor: PGColors.backgroundColor,
                  onPressed: () {
                    _key.currentState?.toggle();
                    DialogUtil.showAboutModal();
                  },
                ),
              ],
            )
          : null,
    );

    if (isWeb) {
      child = Title(
        title: appName,
        color: isDark ? Colors.white : Colors.black,
        child: child,
      );
    }

    return KeyboardDismisser(
      child: child,
    );
  }

  void _onDragEntered(DropEventDetails details) {
    BotToast.showText(text: t.homePage.dragging, duration: const Duration(seconds: 1));
  }

  void _onDragExited(DropEventDetails details) {
    // BotToast.showText(text: t.homePage.cancelDrag);
  }

  Future<void> _onDragDone(DropDoneDetails details) async {
    final items = details.files;
    final maxImages = controller.maxImages;
    final currentImages = controller.images.length;

    if (currentImages + items.length > maxImages) {
      BotToast.showText(
        text: t.homePage.limitValidator(
          maxImages: maxImages,
          lastImages: maxImages - currentImages,
        ),
      );
      return;
    }

    final supportedFormats = items.where(
      (item) {
        final mimeType = lookupMimeType(item.name);
        return ['image/jpeg', 'image/png'].contains(mimeType);
      },
    );

    if (supportedFormats.length != items.length) {
      BotToast.showText(text: t.homePage.formatValidator);
      return;
    }

    for (final item in supportedFormats) {
      final fileName = item.name;
      final data = await item.readAsBytes();
      final imageFile = ImageFile(
        'index_${uuid.v4()}',
        name: fileName,
        extension: extension(fileName),
        bytes: data,
      );

      if (maxImages > currentImages) {
        controller.addImage(imageFile);
        setState(() {});
      }
    }
  }

  /// 预览
  Future<void> _preview() async {
    if (_formKey.currentState!.validate()) {
      final values = _formKey.currentState!.instantValue;
      printDebugLog(json.encode(values));
      final text = values['text'] as String;
      final color = values['color'] as int;
      final opacity = values['opacity'] as double;
      final fontFamily = values['font'] as String?;
      final fontSize = values['fontSize'] as double?;
      final textGap = values['textGap'] as double?;
      final rowGap = values['rowGap'] as double?;
      printDebugLog(
        'text: $text, color: $color, opacity: $opacity, '
        'fontFamily: $fontFamily, fontSize: $fontSize, '
        'textGap: $textGap, rowGap: $rowGap',
      );

      try {
        await EasyLoading.show();
        final imageFutures = controller.images
            .where((element) => element.bytes != null)
            .mapIndexed(
              (index, element) => _addWatermarkV2(
                imageIdx: index,
                bytes: element.bytes!,
                name: element.name,
                watermark: text,
                colorValue: color,
                opacity: opacity,
                fontFamily: fontFamily,
                fontSize: fontSize,
                textGap: textGap,
                rowGap: rowGap,
              ),
            )
            .toList();

        final images = await Future.wait(imageFutures);
        printDebugLog('Length of images: ${images.length}');
        await EasyLoading.dismiss();
        final imageProviders = images.nonNulls
            .map((item) => MemoryImage(item.bytes))
            .toList();
        DialogUtil.showImagePreviewDialog(imageProviders);
      } on Exception catch (error, stackTrace) {
        await EasyLoading.dismiss();
        printErrorLog(error, stackTrace: stackTrace);
      }
    }
  }

  /// 保存
  Future<void> _save() async {
    if (_formKey.currentState!.validate()) {
      final values = _formKey.currentState!.instantValue;
      printDebugLog(json.encode(values));
      final text = values['text'] as String;
      final color = values['color'] as int;
      final opacity = values['opacity'] as double;
      final fontFamily = values['font'] as String?;
      final fontSize = values['fontSize'] as double?;
      final textGap = values['textGap'] as double?;
      final rowGap = values['rowGap'] as double?;
      printDebugLog(
        'text: $text, color: $color, opacity: $opacity, '
        'fontFamily: $fontFamily, fontSize: $fontSize, '
        'textGap: $textGap, rowGap: $rowGap',
      );

      final permission = await PermissionUtil.checkPermission();
      if (permission != Permissions.none) {
        final t = Translations.of(navigatorKey.currentContext!);
        final appName = t.appName(flavor: AppConfig.shared.flavor);
        final title = permission == Permissions.photos
            ? t.dialogs.permissions.photos.title
            : t.dialogs.permissions.storage.title;
        final description = permission == Permissions.photos
            ? t.dialogs.permissions.photos.description
            : t.dialogs.permissions.storage.description;
        DialogUtil.showCustomDialog(
          title: title,
          content: description(appName: appName),
          cancelText: t.buttons.ignore,
          okText: t.buttons.turnOn,
          onOK: () async {
            await AppSettings.openAppSettings().whenComplete(NavigatorUtil.pop);
          },
        );
        return;
      }

      try {
        await EasyLoading.show();
        final imageFutures = controller.images
            .where((element) => element.bytes != null)
            .mapIndexed(
              (index, element) => _addWatermarkV2(
                imageIdx: index,
                bytes: element.bytes!,
                name: element.name,
                watermark: text,
                colorValue: color,
                opacity: opacity,
                fontFamily: fontFamily,
                fontSize: fontSize,
                textGap: textGap,
                rowGap: rowGap,
              ),
            )
            .toList();

        final images = await Future.wait(imageFutures);

        String? selectedDirectory;
        if (isDesktop) {
          selectedDirectory = await FilePicker.platform.getDirectoryPath();
        }

        final results = <bool>[];
        for (final returnWrapper in images.nonNulls) {
          final result = await _saveToDevice(returnWrapper, selectedDirectory);
          results.add(result);
        }

        final savedLength = results.where((element) => element).length;
        final failedLength = results.length - savedLength;

        if (savedLength == 0) {
          await EasyLoading.showError(t.homePage.savedFailure);
        } else if (failedLength == 0) {
          await EasyLoading.showSuccess(t.homePage.savedSuccess);
        } else {
          await EasyLoading.showInfo(
            t.homePage.saveInfo(
              succeedNum: savedLength,
              failedNum: failedLength,
            ),
          );
        }
      } on Exception catch (error, stackTrace) {
        await EasyLoading.showError(t.homePage.savedFailure);
        printErrorLog(error, stackTrace: stackTrace);
      }
    }
  }

  Future<bool> _saveToDevice(
    ReturnWrapper returnWrapper,
    String? selectedDirectory,
  ) async {
    final bytes = returnWrapper.bytes;
    final name = returnWrapper.name;
    final fileName = basenameWithoutExtension(name);
    final ext = extension(name);
    if (kIsWeb) {
      await FileSaver.instance.saveFile(
        name: fileName,
        bytes: bytes,
        fileExtension: ext,
      );
      return true;
    } else if (isDesktop) {
      printDebugLog('selectedDirectory: $selectedDirectory');
      if (selectedDirectory == null) {
        return false;
      }

      final file = File('$selectedDirectory$separator$name');
      await file.writeAsBytes(bytes);
      return true;
    } else {
      final result = await ImageGallerySaverPlus.saveImage(
        bytes,
        quality: 100,
        name: name,
      );
      printDebugLog('result: $result');
      return result is Map && result['isSuccess'] == true;
    }
  }

  Future<ui.Image> _loadImage(Uint8List img) async {
    final completer = Completer<ui.Image>();
    ui.decodeImageFromList(img, completer.complete);
    return completer.future;
  }

  Future<ReturnWrapper?> _addWatermarkV2({
    required int imageIdx,
    required Uint8List bytes,
    required String name,
    required String watermark,
    required int colorValue,
    required double opacity,
    String? fontFamily,
    double? fontSize,
    double? textGap,
    double? rowGap,
  }) async {
    final image = await _loadImage(bytes);

    final width = image.width;
    final height = image.height;
    printDebugLog('image: $width, $height');

    textGap = textGap ?? initialGap;
    rowGap = rowGap ?? initialGap;

    // 斜边长度
    final hypotenuseLength = math.sqrt(width * width + height * height);

    // 创建一个 PictureRecorder
    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder);

    // 绘制图像
    paintImage(
      canvas: canvas,
      rect: Rect.fromLTWH(0, 0, width.toDouble(), height.toDouble()),
      image: image,
      fit: BoxFit.cover,
    );
    canvas.save();

    printDebugLog('fontFamily: $fontFamily');
    // 设置文本样式
    final textStyle = TextStyle(
      color: Color(colorValue).withAlpha((255.0 * opacity).round()),
      fontSize: fontSize ?? initialFontSize,
      fontWeight: FontWeight.normal,
      fontFamily: fontFamily,
    );

    // 创建文本画笔
    var textPainter = TextPainter(
      text: TextSpan(text: watermark, style: textStyle),
      // textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
      maxLines: 1,
    )..layout(maxWidth: hypotenuseLength);

    // 间距
    // final gap = isMobile ? 200.0 : 60.0;

    final multiply = (hypotenuseLength / (textPainter.width + textGap)).ceil();
    if (multiply > 1) {
      final watermarks = List.generate(
        multiply,
        (index) => index,
      ).map((e) => TextSpan(text: watermark)).toList();

      final children = <InlineSpan>[];
      final dimensions = <PlaceholderDimensions>[];
      for (var i = 0; i < watermarks.length; i++) {
        if (i == 0) {
          children.add(
            WidgetSpan(
              child: SizedBox(
                width: textGap / 2,
                height: 1,
              ),
            ),
          );
          dimensions.add(
            PlaceholderDimensions(
              size: Size(textGap / 2, 1),
              alignment: ui.PlaceholderAlignment.bottom,
            ),
          );
        }
        children.add(watermarks[i]);
        if (i < watermarks.length - 1) {
          children.add(
            WidgetSpan(
              child: SizedBox(
                width: textGap,
                height: 1,
              ),
            ),
          );
          dimensions.add(
            PlaceholderDimensions(
              size: Size(textGap, 1),
              alignment: ui.PlaceholderAlignment.bottom,
            ),
          );
        }
        if (i == watermarks.length - 1) {
          children.add(
            WidgetSpan(
              child: SizedBox(
                width: textGap / 2,
                height: 1,
              ),
            ),
          );
          dimensions.add(
            PlaceholderDimensions(
              size: Size(textGap / 2, 1),
              alignment: ui.PlaceholderAlignment.bottom,
            ),
          );
        }
      }

      textPainter =
          TextPainter(
              text: TextSpan(
                children: children,
                style: textStyle,
              ),
              textAlign: TextAlign.center,
              textDirection: TextDirection.ltr,
              maxLines: 1,
            )
            ..setPlaceholderDimensions(dimensions)
            ..layout(maxWidth: hypotenuseLength);
    }

    // 计算角度
    final angle = math.atan2(height, width);

    canvas
      ..translate(width / 2, height / 2)
      ..rotate(angle);

    // 计算中心文本位置
    final offset = Offset(-textPainter.width / 2, 0);
    textPainter.paint(canvas, offset);

    printDebugLog('Height of textPainter: ${textPainter.height}');

    // 绘制剩余文本
    final lines =
        (((hypotenuseLength - textPainter.height) / 2) /
                (textPainter.height + rowGap))
            .floor();

    for (var i = 0; i < lines; i++) {
      textPainter
        ..paint(
          canvas,
          Offset(
            -textPainter.width / 2,
            -(textPainter.height + rowGap) * (i + 1),
          ),
        )
        ..paint(
          canvas,
          Offset(
            -textPainter.width / 2,
            (textPainter.height + rowGap) * (i + 1),
          ),
        );
    }

    canvas.restore();

    // 结束录制并转换为 Image
    final picture = recorder.endRecording();
    final newImage = picture.toImageSync(width, height);
    final data = await newImage.toByteData(format: ui.ImageByteFormat.png);
    final watermarkedBytes = data?.buffer.asUint8List();

    if (watermarkedBytes == null) return null;

    // final ext = extension(name);
    final dateSuffix = DateFormat('yyyy-MM-dd_HH-mm-ss').format(DateTime.now());
    final newFileName = '${basenameWithoutExtension(name)}_$dateSuffix';
    final fileName = '$newFileName.png';

    return ReturnWrapper(bytes: watermarkedBytes, name: fileName);
  }

  Future<List<ImageFile>> _pickImages(int limit) async {
    final permission = await PermissionUtil.checkPermission();
    if (permission != Permissions.none) {
      final t = Translations.of(navigatorKey.currentContext!);
      final appName = t.appName(flavor: AppConfig.shared.flavor);
      final title = permission == Permissions.photos
          ? t.dialogs.permissions.photos.title
          : t.dialogs.permissions.storage.title;
      final description = permission == Permissions.photos
          ? t.dialogs.permissions.photos.description
          : t.dialogs.permissions.storage.description;
      DialogUtil.showCustomDialog(
        title: title,
        content: description(appName: appName),
        cancelText: t.buttons.ignore,
        okText: t.buttons.turnOn,
        onOK: () async {
          await AppSettings.openAppSettings().whenComplete(NavigatorUtil.pop);
        },
      );
      return [];
    }

    return _gotoPickImages(limit);
  }

  Future<List<ImageFile>> _gotoPickImages(int limit) async {
    final picker = ImagePicker();
    final images = await picker.pickMultiImage(limit: limit);
    final imageFutures = images.mapIndexed(
      (index, image) async {
        return ImageFile(
          'index_${uuid.v4()}',
          name: image.name,
          extension: extension(image.name),
          path: image.path,
          bytes: await image.readAsBytes(),
        );
      },
    ).toList();

    return Future.wait(imageFutures);
  }
}
