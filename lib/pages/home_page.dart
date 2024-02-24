import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:app_settings/app_settings.dart';
import 'package:collection/collection.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:image_picker/image_picker.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:picguard/constrants/get.dart';
import 'package:picguard/extensions/extensions.dart';
import 'package:picguard/i18n/strings.g.dart';
import 'package:picguard/theme/colors.dart';
import 'package:picguard/utils/dialog_util.dart';
import 'package:picguard/utils/navigator_util.dart';
import 'package:picguard/utils/string_util.dart';
import 'package:picguard/widgets/app_bar.dart';
import 'package:picguard/widgets/base_form_item.dart';
import 'package:reorderables/reorderables.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';
import 'package:window_manager/window_manager.dart';

/// colors
const colors = <PGColor>[
  PGColor(0xFFFFFFFF, 'White', '白色'),
  PGColor(0xFF9E9E9E, 'Grey', '灰色'),
  PGColor(0xFF000000, 'Black', '黑色'),
  PGColor(0xFFF44336, 'Red', '红色'),
  PGColor(0xFFFF9800, 'Orange', '橙色'),
  PGColor(0xFF2196F3, 'Blue', '蓝色'),
];

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
  List<FileWrapper> _fileWrappers = [];

  @override
  void initState() {
    super.initState();
    windowManager.addListener(this);
    LocaleSettings.getLocaleStream().listen((event) {
      log('locale changed: $event');
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
    final brightness = Theme.of(context).brightness;
    final isDark = brightness == Brightness.dark;
    final languageCode = LocaleSettings.currentLocale.languageCode;
    log('languageCode: $languageCode');
    const spacing = 8.0;
    const padding = 10.0;
    final width = MediaQuery.of(context).size.width;
    final contentWidth = width - padding * 2;
    final itemWidth = ((contentWidth - spacing * 2) / 3).floorToDouble();
    final items = _fileWrappers
        .mapIndexed(
          (index, element) {
            log(element.file.path);
            final image = kIsWeb
                ? Image.network(
                    element.file.path,
                    fit: BoxFit.cover,
                    errorBuilder: (context, url, error) => const Icon(
                      Icons.error,
                      color: errorTextColor,
                      size: 24,
                    ),
                  )
                : Image.file(
                    element.file,
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
                  DialogUtil.showImagePreviewDialog(
                    element.name,
                    element.file,
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
                color: isDark ? Colors.black54 : secondaryGrayColor,
                border: Border.all(color: borderColor),
              ),
            )
            .nestedSizedBox(width: itemWidth, height: itemWidth)
            .nestedInkWell(onTap: _pickImages),
      );
    }

    return KeyboardDismisser(
      child: Title(
        title: t.homePage.title,
        color: isDark ? Colors.white : Colors.black,
        child: Scaffold(
          appBar:
              isMobile ? PGAppBar(titleWidget: Text(t.homePage.title)) : null,
          body: ListView(
            padding:
                const EdgeInsets.symmetric(horizontal: padding, vertical: 20),
            children: [
              ReorderableWrap(
                spacing: spacing,
                runSpacing: 4,
                onReorder: _onReorder,
                scrollPhysics: const NeverScrollableScrollPhysics(),
                alignment: _fileWrappers.isEmpty
                    ? WrapAlignment.center
                    : WrapAlignment.start,
                children: items,
              ),
              Text(
                t.homePage.description,
                style: const TextStyle(
                  color: errorTextColor,
                  fontSize: 12,
                  height: 1.5,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ).nestedPadding(
                padding: const EdgeInsets.symmetric(vertical: 10),
              ),
              FormBuilder(
                key: _formKey,
                child: Column(
                  children: [
                    BaseFormItem(
                      title: t.homePage.textLabel,
                      onTipTap: () {
                        DialogUtil.showBottomSheetDialog(
                          t.homePage.textLabel,
                          t.homePage.textLabelDescription,
                        );
                      },
                      child: FormBuilderField<String>(
                        name: 'text',
                        builder: (FormFieldState<String> field) {
                          final hasError =
                              StringUtil.isNotBlank(field.errorText);
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextFormField(
                                initialValue: field.value,
                                cursorColor:
                                    hasError ? errorTextColor : primaryColor,
                                autocorrect: false,
                                style: TextStyle(
                                  color:
                                      isDark ? Colors.white : primaryTextColor,
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
                                  contentPadding:
                                      const EdgeInsets.fromLTRB(10, 10, 5, 10),
                                  enabledBorder: hasError
                                      ? OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(4),
                                          borderSide: const BorderSide(
                                            color: errorTextColor,
                                          ),
                                          // borderSide: BorderSide.none,
                                          gapPadding: 0,
                                        )
                                      : OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(4),
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
                                    fontSize: 12,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.grey,
                                  ),
                                  focusedBorder: hasError
                                      ? OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(4),
                                          borderSide: const BorderSide(
                                            color: errorTextColor,
                                          ),
                                          // borderSide: BorderSide.none,
                                          gapPadding: 0,
                                        )
                                      : OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(4),
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
                                  padding:
                                      const EdgeInsets.only(top: 8, left: 8),
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
                      ).nestedPadding(padding: const EdgeInsets.only(top: 8.5)),
                    ),
                    const SizedBox(height: 5),
                    BaseFormItem(
                      title: t.homePage.colorLabel,
                      required: false,
                      showTip: false,
                      child: FormBuilderField<int>(
                        name: 'color',
                        initialValue: 0xFF9E9E9E,
                        builder: (FormFieldState<int> field) {
                          final hasError =
                              StringUtil.isNotBlank(field.errorText);
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              DropdownButtonFormField2<int>(
                                value: field.value,
                                style: const TextStyle(
                                  color: primaryTextColor,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                decoration: InputDecoration(
                                  isDense: true,
                                  contentPadding:
                                      const EdgeInsets.fromLTRB(10, 10, 5, 10),
                                  enabledBorder: hasError
                                      ? OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(4),
                                          borderSide: const BorderSide(
                                            color: errorTextColor,
                                          ),
                                          // borderSide: BorderSide.none,
                                          gapPadding: 0,
                                        )
                                      : OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(4),
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
                                          borderRadius:
                                              BorderRadius.circular(4),
                                          borderSide: const BorderSide(
                                            color: errorTextColor,
                                          ),
                                          // borderSide: BorderSide.none,
                                          gapPadding: 0,
                                        )
                                      : OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(4),
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
                                      child: TextButton(
                                        style: ButtonStyle(
                                          tapTargetSize:
                                              MaterialTapTargetSize.padded,
                                          fixedSize: MaterialStateProperty.all(
                                            Size.fromWidth(width),
                                          ),
                                          padding: MaterialStateProperty.all(
                                            const EdgeInsets.symmetric(
                                              horizontal: 10,
                                            ),
                                          ),
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                            Colors.transparent,
                                          ),
                                          foregroundColor:
                                              MaterialStateProperty.resolveWith(
                                            (Set<MaterialState> states) {
                                              if (states.contains(
                                                MaterialState.hovered,
                                              )) {
                                                return Colors.black;
                                              }
                                              return isDark
                                                  ? Colors.white
                                                  : primaryTextColor;
                                            },
                                          ),
                                          overlayColor:
                                              MaterialStateProperty.all(
                                            primaryBackgroundColor,
                                          ),
                                          elevation:
                                              MaterialStateProperty.all(0),
                                          shape: MaterialStateProperty.all(
                                            RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(0),
                                            ),
                                          ),
                                        ),
                                        onPressed: () {
                                          NavigatorUtil.pop();
                                          colorNotifier.value = color.value;
                                          field
                                            ..didChange(color.value)
                                            ..validate();
                                        },
                                        child: Text(
                                          languageCode == 'zh'
                                              ? color.zhText
                                              : color.enText,
                                          style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ).nestedAlign(
                                          alignment: Alignment.centerLeft,
                                        ),
                                      ),
                                    );
                                  },
                                ).toList(),
                                selectedItemBuilder: (context) {
                                  final color = colors.firstWhereOrNull(
                                    (color) => color.value == field.value,
                                  );
                                  return colors.map(
                                    (item) {
                                      return Container(
                                        alignment: AlignmentDirectional.center,
                                        child: Text(
                                          StringUtil.getValue(
                                            languageCode == 'zh'
                                                ? color?.zhText
                                                : color?.enText,
                                          ),
                                          style: TextStyle(
                                            color: isDark
                                                ? Colors.white
                                                : primaryTextColor,
                                            fontSize: 14,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          maxLines: 1,
                                        ),
                                      );
                                    },
                                  ).toList();
                                },
                                onChanged: (value) {},
                                onSaved: (value) {},
                                buttonStyleData: const ButtonStyleData(
                                  padding: EdgeInsets.only(right: 4),
                                  width: 0,
                                ),
                                iconStyleData: IconStyleData(
                                  icon: Icon(
                                    Icons.arrow_downward_sharp,
                                    color: isDark
                                        ? Colors.white
                                        : secondaryTextColor,
                                    size: 16,
                                  ),
                                ),
                                dropdownStyleData: DropdownStyleData(
                                  width: width - 20,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    color: isDark ? Colors.black : Colors.white,
                                  ),
                                ),
                                menuItemStyleData: const MenuItemStyleData(
                                  height: 36,
                                  padding: EdgeInsets.zero,
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
                      ).nestedPadding(padding: const EdgeInsets.only(top: 8.5)),
                    ),
                    const SizedBox(height: 5),
                    BaseFormItem(
                      title: t.homePage.transparencyLabel,
                      required: false,
                      showTip: false,
                      child: FormBuilderField<double>(
                        name: 'transparency',
                        initialValue: transparencyNotifier.value,
                        builder: (FormFieldState<double> field) {
                          final hasError =
                              StringUtil.isNotBlank(field.errorText);
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  SfSliderTheme(
                                    data: SfSliderThemeData(
                                      inactiveTrackHeight: 4,
                                      activeTrackHeight: 4,
                                      activeTrackColor: primaryColor,
                                      thumbRadius: 6,
                                      thumbColor: primaryColor,
                                      overlayRadius: 0,
                                    ),
                                    child: SfSlider(
                                      min: 0,
                                      max: 1,
                                      stepSize: 0.1,
                                      value: field.value,
                                      enableTooltip: true,
                                      onChanged: (dynamic value) {
                                        transparencyNotifier.value =
                                            value as double? ?? 0.0;
                                        field
                                          ..didChange(value ?? 0.0)
                                          ..validate();
                                      },
                                    ),
                                  )
                                      .nestedAlign()
                                      .nestedSizedBox(height: 30)
                                      .nestedExpanded(),
                                  ValueListenableBuilder(
                                    valueListenable: transparencyNotifier,
                                    builder: (
                                      BuildContext context,
                                      double value,
                                      Widget? child,
                                    ) =>
                                        Text(
                                      value.toString(),
                                      textAlign: TextAlign.center,
                                    ).nestedSizedBox(width: 28).nestedPadding(
                                              padding: const EdgeInsets.only(
                                                left: 4,
                                              ),
                                            ),
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
                                  padding:
                                      const EdgeInsets.only(top: 8, left: 8),
                                ),
                            ],
                          );
                        },
                      ).nestedPadding(padding: const EdgeInsets.only(top: 8.5)),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: _fileWrappers.isNotEmpty ? _preview : null,
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                    Colors.white,
                  ),
                  foregroundColor: MaterialStateProperty.resolveWith((
                    Set<MaterialState> states,
                  ) {
                    if (states.contains(MaterialState.disabled)) {
                      return secondaryBorderColor;
                    }
                    return primaryColor;
                  }),
                  shape: MaterialStateProperty.resolveWith((
                    Set<MaterialState> states,
                  ) {
                    if (states.contains(MaterialState.disabled)) {
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
                  elevation: MaterialStateProperty.all(0),
                ),
                child: Text(
                  t.homePage.preview,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              )
                  .nestedSizedBox(
                    height: 42,
                  )
                  .nestedPadding(
                    padding: const EdgeInsets.only(top: 20),
                  ),
              ElevatedButton(
                onPressed: _fileWrappers.isNotEmpty ? _save : null,
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith((
                    Set<MaterialState> states,
                  ) {
                    if (states.contains(MaterialState.disabled)) {
                      return secondaryGrayColor;
                    }
                    return primaryColor;
                  }),
                  foregroundColor: MaterialStateProperty.resolveWith((
                    Set<MaterialState> states,
                  ) {
                    if (states.contains(MaterialState.disabled)) {
                      return placeholderTextColor;
                    }
                    return Colors.white;
                  }),
                  elevation: MaterialStateProperty.all(0),
                ),
                child: Text(
                  t.homePage.save,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              )
                  .nestedSizedBox(
                    height: 42,
                  )
                  .nestedPadding(
                    padding: const EdgeInsets.only(top: 10),
                  ),
            ],
          ),
        ),
      ),
    );
  }

  void _preview() {
    if (_formKey.currentState!.validate()) {
      final values = _formKey.currentState!.instantValue;
      log(json.encode(values));
      final text = values['text'] as String;
      final color = values['color'] as int;
      final transparency = values['transparency'] as double;
      log('text: $text, color: $color, transparency: $transparency');
    }
  }

  void _save() {
    if (_formKey.currentState!.validate()) {
      final values = _formKey.currentState!.instantValue;
      log(json.encode(values));
      final text = values['text'] as String;
      final color = values['color'] as int;
      final transparency = values['transparency'] as double;
      log('text: $text, color: $color, transparency: $transparency');
    }
  }

  Future<void> _pickImages() async {
    if (isMobile) {
      Map<Permission, PermissionStatus> statuses;
      if (defaultTargetPlatform == TargetPlatform.android) {
        final deviceInfo = DeviceInfoPlugin();
        final androidInfo = await deviceInfo.androidInfo;
        if (androidInfo.version.sdkInt >= 33) {
          statuses = await [Permission.photos].request();
        } else {
          statuses = await [Permission.storage].request();
        }
      } else {
        statuses = await [Permission.photos].request();
      }

      if (kDebugMode) {
        print('statuses: $statuses');
      }

      final statusList = statuses.values.toList();
      final denied = statusList.every(
        (status) => [
          PermissionStatus.permanentlyDenied,
          PermissionStatus.denied,
        ].contains(status),
      );
      if (denied) {
        DialogUtil.showCustomDialog(
          title: 'Allow access to your album',
          content:
              'Please go to your phone Settings to grant PicGuard the permission to visit your album.',
          cancelText: 'Ignore',
          okText: 'Turn On',
          onOK: () async {
            NavigatorUtil.pop();
            await AppSettings.openAppSettings();
          },
        );
        return;
      }
    }

    await _gotoPickImages();
  }

  Future<void> _gotoPickImages() async {
    if (isMobile) {
      final assets = await AssetPicker.pickAssets(
        context,
        pickerConfig: AssetPickerConfig(
          requestType: RequestType.image,
          selectedAssets: _fileWrappers
              .map((fileWrapper) => fileWrapper.asset)
              .whereNotNull()
              .toList(),
        ),
      );

      if (assets != null && assets.isNotEmpty) {
        final fileWrapperFutures = assets.map((asset) async {
          final file = await asset.originFile;
          final name = await asset.titleAsync;
          return file != null
              ? FileWrapper(asset: asset, file: file, name: name)
              : null;
        }).toList();

        final fileWrappers =
            (await Future.wait(fileWrapperFutures)).whereNotNull().toList();

        setState(() => _fileWrappers = fileWrappers);
      }
    } else {
      final picker = ImagePicker();
      final image = await picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        final file = File(image.path);
        final name = image.name;
        setState(
          () => _fileWrappers =
              _fileWrappers + [FileWrapper(file: file, name: name)],
        );
      }
    }
  }

  void _onReorder(int oldIndex, int newIndex) {
    setState(
      () => _fileWrappers = _fileWrappers..swap(oldIndex, newIndex),
    );
  }

  @override
  Future<void> onWindowClose() async {
    final brightness = Theme.of(context).brightness;
    final isDark = brightness == Brightness.dark;
    final isPreventClose = await windowManager.isPreventClose();
    if (isDesktop && isPreventClose) {
      if (!mounted) return;
      await showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (_) {
          return AlertDialog(
            title: const Text('Confirm close'),
            content: const Text('Are you sure you want to close this window?'),
            actions: [
              TextButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                    isDark ? Colors.black : Colors.white,
                  ),
                ),
                child: const Text(
                  'Yes',
                  style: TextStyle(color: errorTextColor),
                ),
                onPressed: () {
                  Navigator.pop(context);
                  windowManager.destroy();
                },
              ),
              TextButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                    isDark ? Colors.black : Colors.white,
                  ),
                ),
                child: const Text(
                  'No',
                  style: TextStyle(color: primaryColor),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
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

///
class FileWrapper {
  ///
  const FileWrapper({
    required this.file,
    required this.name,
    this.asset,
  });

  ///
  final AssetEntity? asset;

  ///
  final File file;

  ///
  final String name;
}

///
class PGColor {
  ///
  const PGColor(this.value, this.enText, this.zhText);

  /// 颜色值
  final int value;

  /// 英文文案
  final String enText;

  /// 中文文案
  final String zhText;
}
