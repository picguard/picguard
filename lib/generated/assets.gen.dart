/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';

class $LogoGen {
  const $LogoGen();

  /// File path: logo/logo-128.png
  AssetGenImage get logo128 => const AssetGenImage('logo/logo-128.png');

  /// File path: logo/logo-256.png
  AssetGenImage get logo256 => const AssetGenImage('logo/logo-256.png');

  /// File path: logo/logo-32.png
  AssetGenImage get logo32 => const AssetGenImage('logo/logo-32.png');

  /// File path: logo/logo-512.png
  AssetGenImage get logo512 => const AssetGenImage('logo/logo-512.png');

  /// File path: logo/logo.png
  AssetGenImage get logo => const AssetGenImage('logo/logo.png');

  /// List of all assets
  List<AssetGenImage> get values => [logo128, logo256, logo32, logo512, logo];
}

class Assets {
  const Assets._();

  static const String changelog = 'CHANGELOG.md';
  static const String license = 'LICENSE';
  static const String readme = 'README.md';
  static const $LogoGen logo = $LogoGen();

  /// List of all assets
  static List<String> get values => [changelog, license, readme];
}

class AssetGenImage {
  const AssetGenImage(this._assetName, {this.size, this.flavors = const {}});

  final String _assetName;

  final Size? size;
  final Set<String> flavors;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = true,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.medium,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({AssetBundle? bundle, String? package}) {
    return AssetImage(_assetName, bundle: bundle, package: package);
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
