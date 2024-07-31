// Dart imports:
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math' as math;
import 'dart:ui' as ui;

// Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';

// Package imports:
import 'package:app_settings/app_settings.dart';
import 'package:collection/collection.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:file_saver/file_saver.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:gap/gap.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart' hide TextDirection;
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:path/path.dart' hide context;
import 'package:permission_handler/permission_handler.dart';
import 'package:reorderables/reorderables.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:window_manager/window_manager.dart';

// Project imports:
import 'package:picguard/app/navigator.dart';
import 'package:picguard/constants/constants.dart';
import 'package:picguard/extensions/extensions.dart';
import 'package:picguard/i18n/i18n.dart';
import 'package:picguard/logger/logger.dart';
import 'package:picguard/models/models.dart';
import 'package:picguard/theme/colors.dart';
import 'package:picguard/utils/utils.dart';
import 'package:picguard/widgets/widgets.dart';

enum Permissions {
  photos,
  storage,
  none,
}

/// colors
const colors = <PGColor>[
  PGColor(0xFFFFFFFF, 'White', '白色'),
  PGColor(0xFF9E9E9E, 'Grey', '灰色'),
  PGColor(0xFF000000, 'Black', '黑色'),
  PGColor(0xFFF44336, 'Red', '红色'),
  PGColor(0xFFFF9800, 'Orange', '橙色'),
  PGColor(0xFF2196F3, 'Blue', '蓝色'),
];

const spacing = 8.0;
const runSpacing = 4.0;
const padding = 10.0;
double initialGap = isMobile ? 100.0 : 30.0;

///
class HomePage extends StatefulWidget {
  ///
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WindowListener {
  final _formKey = GlobalKey<FormBuilderState>();
  final colorNotifier = ValueNotifier<int>(0xFF9E9E9E);
  final transparencyNotifier = ValueNotifier<double>(1);
  final textGapNotifier = ValueNotifier<double>(initialGap);
  final rowGapNotifier = ValueNotifier<double>(initialGap);

  final inputFocusNode = FocusNode();

  List<FileWrapper> _fileWrappers = [];

  @override
  void initState() {
    super.initState();
    windowManager.addListener(this);
    LocaleSettings.getLocaleStream().listen((event) {
      printDebugLog('locale changed: $event');
    });

    SchedulerBinding.instance.addPostFrameCallback((timestamp) {
      DialogUtil.showLicenseDialog();
    });
  }

  @override
  void dispose() {
    windowManager.removeListener(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return KeyboardDismisser(
      child: Title(
        title: t.homePage.title,
        color: isDark ? Colors.white : Colors.black,
        child: Scaffold(
          appBar: isMobile
              ? PGAppBar(
                  titleWidget: Text(t.homePage.title),
                  isDark: isDark,
                )
              : null,
          body: ListView(
            padding: const EdgeInsets.symmetric(
              horizontal: padding,
              vertical: 20,
            ),
            children: [
              imageGroup,
              const Gap(10),
              description,
              const Gap(10),
              FormBuilder(
                key: _formKey,
                child: Column(
                  children: [
                    input,
                    const Gap(5),
                    colorSelect,
                    const Gap(5),
                    transparency,
                    const Gap(5),
                    textGap,
                    const Gap(5),
                    rowGap,
                  ],
                ),
              ),
              const Gap(20),
              previewBtn,
              const Gap(10),
              saveBtn,
              const Gap(20),
              Text(
                '${t.homePage.title} $appVersion',
                style: const TextStyle(
                  color: secondaryTextColor,
                  fontSize: 12,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// 图片组
  Widget get imageGroup {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final width = MediaQuery.sizeOf(context).width;
    final contentWidth = width - padding * 2;
    final itemWidth = ((contentWidth - spacing * 2) / 3).floorToDouble();
    final items = _fileWrappers
        .mapIndexed(
          (index, element) {
            printDebugLog(element.path);
            final image = kIsWeb
                ? Image.network(
                    element.path,
                    fit: BoxFit.cover,
                    errorBuilder: (context, url, error) => const Icon(
                      Icons.error,
                      color: errorTextColor,
                      size: 24,
                    ),
                  )
                : Image.file(
                    File(element.path),
                    fit: BoxFit.cover,
                    errorBuilder: (context, url, error) => const Icon(
                      Icons.error,
                      color: errorTextColor,
                      size: 24,
                    ),
                  );

            Widget child = image;

            if (kIsWeb || isDesktop) {
              child = SingleChildScrollView(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: child,
                ),
              );
            }

            return Stack(
              children: [
                child
                    .nestedSizedBox(width: itemWidth, height: itemWidth)
                    .nestedTap(() {
                  final imageProviders = _fileWrappers.map((fileWrapper) {
                    return (kIsWeb
                        ? NetworkImage(fileWrapper.path)
                        : FileImage(File(fileWrapper.path))) as ImageProvider;
                  }).toList();
                  DialogUtil.showImagePreviewDialog(
                    imageProviders,
                    initialPage: index,
                  );
                }),
                Positioned(
                  top: 2,
                  right: 2,
                  child: const Icon(
                    Icons.clear,
                    color: warnTextColor,
                    size: 14,
                  )
                      .nestedDecoratedBox(
                        decoration: BoxDecoration(
                          color: backgroundColor,
                          borderRadius: BorderRadius.circular(9),
                        ),
                      )
                      .nestedSizedBox(width: 18, height: 18)
                      .nestedTap(
                        () => setState(
                          () => _fileWrappers = _fileWrappers..removeAt(index),
                        ),
                      ),
                ),
              ],
            );
          },
        )
        .cast<Widget>()
        .toList();

    if (items.length < 9) {
      items.add(
        const Icon(
          Icons.add,
          size: 40,
          color: borderColor,
        )
            .nestedCenter()
            .nestedDecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: isDark ? Colors.black54 : secondaryGrayColor,
                border: Border.all(color: borderColor),
              ),
            )
            .nestedSizedBox(width: itemWidth, height: itemWidth)
            .nestedInkWell(onTap: _pickImages),
      );
    }

    return ReorderableWrap(
      spacing: spacing,
      runSpacing: runSpacing,
      onReorder: _onReorder,
      scrollPhysics: const NeverScrollableScrollPhysics(),
      alignment:
          _fileWrappers.isEmpty ? WrapAlignment.center : WrapAlignment.start,
      children: items,
    );
  }

  /// 声明文本
  Widget get description {
    final t = Translations.of(context);
    return Text(
      t.homePage.description,
      style: const TextStyle(
        color: errorTextColor,
        fontSize: 12,
        height: 1.5,
      ),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      textAlign: TextAlign.center,
    );
  }

  /// 输入框
  Widget get input {
    final t = Translations.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return BaseFormItem(
      title: t.homePage.textLabel,
      onTipTap: () {
        DialogUtil.showBottomSheetDialog(
          t.homePage.textLabel,
          t.homePage.textLabelDescription,
        );
      },
      child: FormBuilderField<String>(
        name: 'text',
        focusNode: inputFocusNode,
        builder: (FormFieldState<String> field) {
          final hasError = StringUtil.isNotBlank(field.errorText);
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                initialValue: field.value,
                focusNode: inputFocusNode,
                cursorColor: hasError ? errorTextColor : primaryColor,
                autocorrect: false,
                style: TextStyle(
                  color: isDark ? Colors.white : primaryTextColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
                onChanged: (value) {
                  field
                    ..didChange(value)
                    ..validate();
                },
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding: const EdgeInsets.fromLTRB(10, 11.5, 5, 11.5),
                  enabledBorder: hasError
                      ? OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                          borderSide: const BorderSide(
                            color: errorTextColor,
                          ),
                          // borderSide: BorderSide.none,
                          gapPadding: 0,
                        )
                      : OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                          borderSide: const BorderSide(
                            color: borderColor,
                          ),
                          gapPadding: 0,
                        ),
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                    borderSide: const BorderSide(
                      color: borderColor,
                    ),
                    gapPadding: 0,
                  ),
                  hintText: t.homePage.textInput,
                  hintMaxLines: 2,
                  hintStyle: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    color: Colors.grey,
                  ),
                  focusedBorder: hasError
                      ? OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                          borderSide: const BorderSide(
                            color: errorTextColor,
                          ),
                          // borderSide: BorderSide.none,
                          gapPadding: 0,
                        )
                      : OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                          borderSide: const BorderSide(
                            color: primaryColor,
                          ),
                          // borderSide: BorderSide.none,
                          gapPadding: 0,
                        ),
                ),
              ),
              if (hasError)
                Text(
                  field.errorText!,
                  style: const TextStyle(
                    fontSize: 12,
                    color: errorTextColor,
                  ),
                ).nestedPadding(
                  padding: const EdgeInsets.only(top: 8, left: 8),
                ),
            ],
          );
        },
        validator: (value) {
          if (StringUtil.isBlank(value)) {
            return t.homePage.textValidator;
          }
          return null;
        },
      ).nestedPadding(
        padding: const EdgeInsets.only(top: 8.5),
      ),
    );
  }

  /// 颜色选择
  Widget get colorSelect {
    final t = Translations.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final languageCode = LocaleSettings.currentLocale.languageCode;
    printDebugLog('languageCode: $languageCode');

    return BaseFormItem(
      title: t.homePage.colorLabel,
      required: false,
      showTip: false,
      child: FormBuilderField<int>(
        name: 'color',
        initialValue: colors.elementAt(1).value,
        builder: (FormFieldState<int> field) {
          final hasError = StringUtil.isNotBlank(field.errorText);
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DropdownButtonFormField<int>(
                value: field.value,
                onTap: () => onColorTap(field),
                style: TextStyle(
                  color: isDark ? Colors.white : primaryTextColor,
                  overflow: TextOverflow.ellipsis,
                ),
                icon: const Icon(
                  Icons.arrow_drop_down,
                  color: borderColor,
                  size: 20,
                ),
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding: const EdgeInsets.fromLTRB(10, 10, 5, 10),
                  enabledBorder: hasError
                      ? OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                          borderSide: const BorderSide(
                            color: errorTextColor,
                          ),
                          // borderSide: BorderSide.none,
                          gapPadding: 0,
                        )
                      : OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                          borderSide: const BorderSide(
                            color: borderColor,
                          ),
                          gapPadding: 0,
                        ),
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                    borderSide: const BorderSide(
                      color: borderColor,
                    ),
                    gapPadding: 0,
                  ),
                  focusedBorder: hasError
                      ? OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                          borderSide: const BorderSide(
                            color: errorTextColor,
                          ),
                          // borderSide: BorderSide.none,
                          gapPadding: 0,
                        )
                      : OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                          borderSide: const BorderSide(
                            color: primaryColor,
                          ),
                          gapPadding: 0,
                        ),
                ),
                items: colors.map(
                  (color) {
                    return DropdownMenuItem<int>(
                      value: color.value,
                      child: Text(
                        languageCode == 'zh' ? color.zhText : color.enText,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ).nestedAlign(
                        alignment: Alignment.centerLeft,
                      ),
                    );
                  },
                ).toList(),
                onChanged: (value) {},
              ),
              if (hasError)
                Text(
                  field.errorText!,
                  style: const TextStyle(
                    fontSize: 12,
                    color: errorTextColor,
                  ),
                ).nestedPadding(
                  padding: const EdgeInsets.only(
                    top: 8,
                    left: 8,
                  ),
                ),
            ],
          );
        },
        validator: (value) {
          if (value == null) {
            return t.homePage.colorValidator;
          }
          return null;
        },
      ).nestedPadding(
        padding: const EdgeInsets.only(top: 8.5),
      ),
    );
  }

  /// 透明度选择
  Widget get transparency {
    const min = 0.3;
    return BaseFormItem(
      title: t.homePage.transparencyLabel,
      required: false,
      showTip: false,
      child: FormBuilderField<double>(
        name: 'transparency',
        initialValue: transparencyNotifier.value,
        builder: (FormFieldState<double> field) {
          final hasError = StringUtil.isNotBlank(field.errorText);
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  SfSliderTheme(
                    data: const SfSliderThemeData(
                      activeTrackHeight: 4,
                      activeTrackColor: primaryColor,
                      inactiveTrackColor: primaryBackgroundColor,
                      thumbRadius: 6,
                      thumbColor: primaryColor,
                      overlayRadius: 0,
                    ),
                    child: SfSlider(
                      min: min,
                      max: 1,
                      stepSize: 0.1,
                      value: field.value,
                      enableTooltip: true,
                      onChanged: (dynamic value) {
                        final newValue = value as double? ?? min;
                        transparencyNotifier.value = newValue;
                        field
                          ..didChange(newValue)
                          ..validate();
                      },
                    ),
                  ).nestedAlign().nestedSizedBox(height: 30).nestedExpanded(),
                  const Gap(4),
                  ValueListenableBuilder(
                    valueListenable: transparencyNotifier,
                    builder: (
                      BuildContext context,
                      double value,
                      Widget? child,
                    ) =>
                        Text(
                      value.toStringAsFixed(1),
                      textAlign: TextAlign.center,
                    ).nestedSizedBox(width: 28),
                  ),
                ],
              ),
              if (hasError)
                Text(
                  field.errorText!,
                  style: const TextStyle(
                    fontSize: 12,
                    color: errorTextColor,
                  ),
                ).nestedPadding(
                  padding: const EdgeInsets.only(top: 8, left: 8),
                ),
            ],
          );
        },
      ).nestedPadding(
        padding: const EdgeInsets.only(top: 8.5),
      ),
    );
  }

  /// 文本之间间距
  Widget get textGap {
    return BaseFormItem(
      title: t.homePage.textGapLabel,
      required: false,
      onTipTap: () {
        DialogUtil.showBottomSheetDialog(
          t.homePage.textGapLabel,
          t.homePage.textGapDescription,
        );
      },
      child: FormBuilderField<double>(
        name: 'textGap',
        initialValue: textGapNotifier.value,
        builder: (FormFieldState<double> field) {
          final hasError = StringUtil.isNotBlank(field.errorText);
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  SfSliderTheme(
                    data: const SfSliderThemeData(
                      activeTrackHeight: 4,
                      activeTrackColor: primaryColor,
                      inactiveTrackColor: primaryBackgroundColor,
                      thumbRadius: 6,
                      thumbColor: primaryColor,
                      overlayRadius: 0,
                    ),
                    child: SfSlider(
                      min: initialGap,
                      max: initialGap * 3,
                      stepSize: 10,
                      value: field.value,
                      enableTooltip: true,
                      onChanged: (dynamic value) {
                        final newValue = value as double? ?? initialGap;
                        textGapNotifier.value = newValue;
                        field
                          ..didChange(newValue)
                          ..validate();
                      },
                    ),
                  ).nestedAlign().nestedSizedBox(height: 30).nestedExpanded(),
                  const Gap(4),
                  ValueListenableBuilder(
                    valueListenable: textGapNotifier,
                    builder: (
                      BuildContext context,
                      double value,
                      Widget? child,
                    ) =>
                        Text(
                      value.toStringAsFixed(0),
                      textAlign: TextAlign.center,
                    ).nestedSizedBox(width: 28),
                  ),
                ],
              ),
              if (hasError)
                Text(
                  field.errorText!,
                  style: const TextStyle(
                    fontSize: 12,
                    color: errorTextColor,
                  ),
                ).nestedPadding(
                  padding: const EdgeInsets.only(top: 8, left: 8),
                ),
            ],
          );
        },
      ).nestedPadding(
        padding: const EdgeInsets.only(top: 8.5),
      ),
    );
  }

  /// 文本行间距
  Widget get rowGap {
    return BaseFormItem(
      title: t.homePage.rowGapLabel,
      required: false,
      onTipTap: () {
        DialogUtil.showBottomSheetDialog(
          t.homePage.rowGapLabel,
          t.homePage.rowGapDescription,
        );
      },
      child: FormBuilderField<double>(
        name: 'rowGap',
        initialValue: rowGapNotifier.value,
        builder: (FormFieldState<double> field) {
          final hasError = StringUtil.isNotBlank(field.errorText);
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  SfSliderTheme(
                    data: const SfSliderThemeData(
                      activeTrackHeight: 4,
                      activeTrackColor: primaryColor,
                      inactiveTrackColor: primaryBackgroundColor,
                      thumbRadius: 6,
                      thumbColor: primaryColor,
                      overlayRadius: 0,
                    ),
                    child: SfSlider(
                      min: initialGap,
                      max: initialGap * 3,
                      stepSize: 10,
                      value: field.value,
                      enableTooltip: true,
                      onChanged: (dynamic value) {
                        final newValue = value as double? ?? initialGap;
                        rowGapNotifier.value = newValue;
                        field
                          ..didChange(newValue)
                          ..validate();
                      },
                    ),
                  ).nestedAlign().nestedSizedBox(height: 30).nestedExpanded(),
                  const Gap(4),
                  ValueListenableBuilder(
                    valueListenable: rowGapNotifier,
                    builder: (
                      BuildContext context,
                      double value,
                      Widget? child,
                    ) =>
                        Text(
                      value.toStringAsFixed(0),
                      textAlign: TextAlign.center,
                    ).nestedSizedBox(width: 28),
                  ),
                ],
              ),
              if (hasError)
                Text(
                  field.errorText!,
                  style: const TextStyle(
                    fontSize: 12,
                    color: errorTextColor,
                  ),
                ).nestedPadding(
                  padding: const EdgeInsets.only(top: 8, left: 8),
                ),
            ],
          );
        },
      ).nestedPadding(
        padding: const EdgeInsets.only(top: 8.5),
      ),
    );
  }

  /// 预览按钮
  Widget get previewBtn {
    return ElevatedButton(
      onPressed: _fileWrappers.isNotEmpty ? _preview : null,
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(
          Colors.white,
        ),
        foregroundColor: WidgetStateProperty.resolveWith((
          Set<WidgetState> states,
        ) {
          if (states.contains(WidgetState.disabled)) {
            return secondaryBorderColor;
          }
          return primaryColor;
        }),
        shape: WidgetStateProperty.resolveWith((
          Set<WidgetState> states,
        ) {
          if (states.contains(WidgetState.disabled)) {
            return RoundedRectangleBorder(
              side: const BorderSide(color: secondaryBorderColor),
              borderRadius: BorderRadius.circular(10),
            );
          }
          return RoundedRectangleBorder(
            side: const BorderSide(color: primaryColor),
            borderRadius: BorderRadius.circular(10),
          );
        }),
        elevation: WidgetStateProperty.all(0),
      ),
      child: Text(
        t.homePage.preview,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
      ),
    ).nestedSizedBox(
      height: 42,
    );
  }

  /// 保存按钮
  Widget get saveBtn {
    return ElevatedButton(
      onPressed: _fileWrappers.isNotEmpty ? _save : null,
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.resolveWith((
          Set<WidgetState> states,
        ) {
          if (states.contains(WidgetState.disabled)) {
            return secondaryGrayColor;
          }
          return primaryColor;
        }),
        foregroundColor: WidgetStateProperty.resolveWith((
          Set<WidgetState> states,
        ) {
          if (states.contains(WidgetState.disabled)) {
            return placeholderTextColor;
          }
          return Colors.white;
        }),
        elevation: WidgetStateProperty.all(0),
      ),
      child: Text(
        t.homePage.save,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
      ),
    ).nestedSizedBox(
      height: 42,
    );
  }

  /// 预览
  Future<void> _preview() async {
    if (_formKey.currentState!.validate()) {
      final values = _formKey.currentState!.instantValue;
      printDebugLog(json.encode(values));
      final text = values['text'] as String;
      final color = values['color'] as int;
      final transparency = values['transparency'] as double;
      final textGap = values['textGap'] as double;
      final rowGap = values['rowGap'] as double;
      printDebugLog(
        'text: $text, color: $color, transparency: $transparency, textGap: $textGap, rowGap: $rowGap',
      );

      try {
        await EasyLoading.show();
        final imageFutures = _fileWrappers
            .mapIndexed(
              (index, element) => _addWatermarkV2(
                imageIdx: index,
                bytes: element.bytes,
                name: element.name,
                watermark: text,
                colorValue: color,
                transparency: transparency,
                textGap: textGap,
                rowGap: rowGap,
              ),
            )
            .toList();

        final images = await Future.wait(imageFutures);
        printDebugLog('Length of images: ${images.length}');
        await EasyLoading.dismiss();
        final imageProviders = images
            .whereNotNull()
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
      final transparency = values['transparency'] as double;
      final textGap = values['textGap'] as double;
      final rowGap = values['rowGap'] as double;
      printDebugLog(
        'text: $text, color: $color, transparency: $transparency, textGap: $textGap, rowGap: $rowGap',
      );

      final permission = await _checkPermission();
      if (permission != Permissions.none) {
        final t = Translations.of(AppNavigator.key.currentContext!);
        final title = permission == Permissions.photos
            ? t.dialogs.permissions.photos.title
            : t.dialogs.permissions.storage.title;
        final description = permission == Permissions.photos
            ? t.dialogs.permissions.photos.description
            : t.dialogs.permissions.storage.description;
        DialogUtil.showCustomDialog(
          title: title,
          content: description,
          cancelText: t.buttons.ignore,
          okText: t.buttons.turnOn,
          onOK: () async {
            NavigatorUtil.pop();
            await AppSettings.openAppSettings();
          },
        );
        return;
      }

      try {
        await EasyLoading.show();
        final imageFutures = _fileWrappers
            .mapIndexed(
              (index, element) => _addWatermarkV2(
                imageIdx: index,
                bytes: element.bytes,
                name: element.name,
                watermark: text,
                colorValue: color,
                transparency: transparency,
                textGap: textGap,
                rowGap: rowGap,
              ),
            )
            .toList();

        final images = await Future.wait(imageFutures);

        final savedImageFutures =
            images.whereNotNull().map(_saveToDevice).toList();
        final savedImages = await Future.wait(savedImageFutures);
        final hasErrors = savedImages.where((element) => !element).isNotEmpty;
        if (hasErrors) {
          await EasyLoading.showError(t.homePage.savedFailure);
        } else {
          await EasyLoading.showSuccess(t.homePage.savedSuccess);
        }
      } on Exception catch (error, stackTrace) {
        await EasyLoading.showError(t.homePage.savedFailure);
        printErrorLog(error, stackTrace: stackTrace);
      }
    }
  }

  Future<bool> _saveToDevice(ReturnWrapper returnWrapper) async {
    final bytes = returnWrapper.bytes;
    final name = returnWrapper.name;
    final fileName = basenameWithoutExtension(name);
    final ext = extension(name);
    if (kIsWeb || isDesktop) {
      await FileSaver.instance.saveFile(
        name: fileName,
        bytes: bytes,
        ext: ext,
      );
      return true;
    } else {
      final result = await ImageGallerySaver.saveImage(
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
    required double transparency,
    required double textGap,
    required double rowGap,
  }) async {
    final image = await _loadImage(bytes);

    final width = image.width;
    final height = image.height;
    printDebugLog('image: $width, $height');

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

    // 设置文本样式
    final textStyle = TextStyle(
      color: Color(colorValue).withOpacity(transparency),
      fontSize: isMobile ? 72 : 36,
      fontWeight: FontWeight.w400,
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

    final multiply = (hypotenuseLength / (textPainter.width + textGap)).floor();
    if (multiply > 1) {
      final watermarks = List.generate(multiply, (index) => index)
          .map((e) => TextSpan(text: watermark))
          .toList();

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

      textPainter = TextPainter(
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
    final lines = (((hypotenuseLength - textPainter.height) / 2) /
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

    final ext = extension(name);
    final newFileName =
        '${basenameWithoutExtension(name)}_${DateFormat('yyyy-MM-dd_HH-mm-ss').format(DateTime.now())}';
    final fileName = '$newFileName$ext';

    return ReturnWrapper(bytes: watermarkedBytes, name: fileName);
  }

  Future<void> _pickImages() async {
    final permission = await _checkPermission();
    if (permission != Permissions.none) {
      final t = Translations.of(AppNavigator.key.currentContext!);
      final title = permission == Permissions.photos
          ? t.dialogs.permissions.photos.title
          : t.dialogs.permissions.storage.title;
      final description = permission == Permissions.photos
          ? t.dialogs.permissions.photos.description
          : t.dialogs.permissions.storage.description;
      DialogUtil.showCustomDialog(
        title: title,
        content: description,
        cancelText: t.buttons.ignore,
        okText: t.buttons.turnOn,
        onOK: () async {
          NavigatorUtil.pop();
          await AppSettings.openAppSettings();
        },
      );
      return;
    }

    await _gotoPickImages();
  }

  Future<void> _gotoPickImages() async {
    final picker = ImagePicker();
    final images = await picker.pickMultiImage(limit: 9 - _fileWrappers.length);
    if (images.isNotEmpty) {
      final imageFutures = images.map(
        (image) async {
          return FileWrapper(
            path: image.path,
            bytes: await image.readAsBytes(),
            name: image.name,
          );
        },
      ).toList();

      final fileWrappers = await Future.wait(imageFutures);

      setState(
        () => _fileWrappers = _fileWrappers + fileWrappers,
      );
    }
  }

  void _onReorder(int oldIndex, int newIndex) {
    setState(
      () => _fileWrappers = _fileWrappers..swap(oldIndex, newIndex),
    );
  }

  void onColorTap(FormFieldState<int> field) {
    // DO NOT REMOVE THIS LINE: 消除下拉选择默认弹窗
    NavigatorUtil.pop();
    DialogUtil.showPGColorModal(
      items: colors,
      callback: (PGColor value) {
        if (kDebugMode) {
          printDebugLog('id: ${value.value}, name: ${value.enText}');
        }

        field
          ..didChange(value.value)
          ..validate();

        NavigatorUtil.pop();
      },
    );
  }

  // 检查权限
  Future<Permissions> _checkPermission() async {
    if (defaultTargetPlatform == TargetPlatform.android) {
      final deviceInfo = DeviceInfoPlugin();
      final androidInfo = await deviceInfo.androidInfo;
      if (androidInfo.version.sdkInt >= 33) {
        final status = await Permission.photos.request();
        final denied = [
          PermissionStatus.permanentlyDenied,
          PermissionStatus.denied,
        ].contains(status);
        return denied ? Permissions.photos : Permissions.none;
      } else {
        final status = await Permission.storage.request();
        final denied = [
          PermissionStatus.permanentlyDenied,
          PermissionStatus.denied,
        ].contains(status);
        return denied ? Permissions.storage : Permissions.none;
      }
    } else if (defaultTargetPlatform == TargetPlatform.iOS) {
      final status = await Permission.photos.request();
      final denied = [
        PermissionStatus.permanentlyDenied,
        PermissionStatus.denied,
      ].contains(status);
      return denied ? Permissions.photos : Permissions.none;
    }

    return Permissions.none;
  }

  @override
  Future<void> onWindowClose() async {
    final isPreventClose = await windowManager.isPreventClose();
    if (isDesktop && isPreventClose) {
      if (!mounted) return;
      await showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (ctx) {
          final t = Translations.of(context);
          return AlertDialog(
            title: Text(
              t.dialogs.exitConfirm.title,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w500,
                height: 1.44,
              ),
              textAlign: TextAlign.center,
            ),
            content: Text(
              t.dialogs.exitConfirm.description,
              style: const TextStyle(fontSize: 14, height: 1.44),
              textAlign: TextAlign.center,
            ).nestedConstrainedBox(
              constraints: const BoxConstraints(minWidth: 300),
            ),
            actions: [
              TextButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(errorTextColor),
                  elevation: WidgetStateProperty.all(0),
                  minimumSize: WidgetStateProperty.all(Size.zero),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  padding: WidgetStateProperty.all(EdgeInsets.zero),
                  shape: WidgetStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
                child: Text(
                  t.dialogs.exitConfirm.exit,
                  style: const TextStyle(color: Colors.white),
                ).nestedPadding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 6,
                  ),
                ),
                onPressed: () {
                  NavigatorUtil.pop();
                  windowManager.destroy();
                },
              ),
              const SizedBox(width: 20),
              TextButton(
                style: ButtonStyle(
                  backgroundColor:
                      WidgetStateProperty.all(primaryBackgroundColor),
                  elevation: WidgetStateProperty.all(0),
                  minimumSize: WidgetStateProperty.all(Size.zero),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  padding: WidgetStateProperty.all(EdgeInsets.zero),
                  shape: WidgetStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                      side: const BorderSide(color: primaryColor),
                    ),
                  ),
                ),
                onPressed: NavigatorUtil.pop,
                child: Text(
                  t.dialogs.exitConfirm.cancel,
                  style: const TextStyle(color: primaryColor),
                ).nestedPadding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 6,
                  ),
                ),
              ),
            ],
            actionsAlignment: MainAxisAlignment.center,
          );
        },
      );
    }
  }

  @override
  void onWindowFocus() {
    // Make sure to call once.
    setState(() {});
    // do something
  }
}
