///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import
// dart format off

import 'i18n.g.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:slang/generated.dart';

// Path: <root>
class TranslationsZh extends Translations with BaseTranslations<AppLocale, Translations> {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsZh({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = meta ?? TranslationMetadata(
		    locale: AppLocale.zh,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ),
		  super(cardinalResolver: cardinalResolver, ordinalResolver: ordinalResolver) {
		super.$meta.setFlatMapFunction($meta.getTranslation); // copy base translations to super.$meta
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <zh>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	@override dynamic operator[](String key) => $meta.getTranslation(key) ?? super.$meta.getTranslation(key);

	late final TranslationsZh _root = this; // ignore: unused_field

	@override 
	TranslationsZh $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => TranslationsZh(meta: meta ?? this.$meta);

	// Translations
	@override String appName({required Flavor flavor}) {
		switch (flavor) {
			case Flavor.free:
				return 'PicGuard';
			case Flavor.pro:
				return 'PicGuard Pro';
		}
	}
	@override late final _TranslationsHomePageZh homePage = _TranslationsHomePageZh._(_root);
	@override late final _TranslationsAboutPageZh aboutPage = _TranslationsAboutPageZh._(_root);
	@override late final _TranslationsColorsZh colors = _TranslationsColorsZh._(_root);
	@override late final _TranslationsMenusZh menus = _TranslationsMenusZh._(_root);
	@override late final _TranslationsButtonsZh buttons = _TranslationsButtonsZh._(_root);
	@override late final _TranslationsDialogsZh dialogs = _TranslationsDialogsZh._(_root);
	@override Map<String, String> get locales => {
		'en': 'English',
		'it': 'Italian',
		'zh': '中文',
	};
}

// Path: homePage
class _TranslationsHomePageZh extends TranslationsHomePageEn {
	_TranslationsHomePageZh._(TranslationsZh root) : this._root = root, super.internal(root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get appPreview => '警告: 开发版本, 每个提交自动构建';
	@override String get imageDescription => '请上传图片';
	@override String get description => '本app不会上传任何图片到服务器, 所有操作均在本地完成';
	@override String get textLabel => '文本';
	@override String get textLabelDescription => '文本会以水印添加到图片上';
	@override String get textValidator => '请输入文本.';
	@override String get textInput => '此证件仅用于办理xx业务, 其他用途无效';
	@override String get colorLabel => '颜色';
	@override String get colorValidator => '请选择颜色.';
	@override String get opacityLabel => '不透明度';
	@override String get fontLabel => '字体';
	@override String get fontLabelDescription => '部分语言不支持自定义字体';
	@override String get fontValidator => '请选择字体.';
	@override String get fontSizeLabel => '字体大小';
	@override String get textGapLabel => '文本间距';
	@override String get textGapDescription => '每行文本中, 文本与文本之间的间距';
	@override String get rowGapLabel => '行间距';
	@override String get rowGapDescription => '每行文本与每行文本之间的间距';
	@override String get dragging => '拖拽中';
	@override String get cancelDrag => '拖拽已取消';
	@override String limitValidator({required Object maxImages, required Object lastImages}) => '最多支持${maxImages}张图片，您还可以上传${lastImages}张图片.';
	@override String get formatValidator => '仅支持PNG和JPEG格式.';
	@override String get preview => '预览';
	@override String get save => '保存';
	@override String get savedSuccess => '保存成功';
	@override String get savedFailure => '保存失败';
	@override String saveInfo({required Object succeedNum, required Object failedNum}) => '已保存${succeedNum}张, 保存失败${failedNum}张';
	@override String get appNoUpdates => '应用是最新的!';
	@override String get backgroundCheckingStopped => '后台检查停止了';
	@override String backgroundCheckingAvailable({required Object latestVersion}) => '后台检查: ${latestVersion}更新可用!';
	@override String backgroundCheckingStarted({required Object seconds}) => '后台检查开启了 (每${seconds}秒)';
}

// Path: aboutPage
class _TranslationsAboutPageZh extends TranslationsAboutPageEn {
	_TranslationsAboutPageZh._(TranslationsZh root) : this._root = root, super.internal(root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String version({required Object version, required Object buildNumber}) => '版本号 ${version}(${buildNumber})';
	@override String copyright({required Object year, required Object appName}) => '版权 © ${year} ${appName}. 版权所有。';
	@override String get slogan => '给图片添加水印, 防止被恶意使用.';
	@override String get readme => '项目简介';
	@override String get appLicense => '应用许可证';
	@override String get changelog => '变更日志';
	@override String get thirdPartyLicense => '第三方许可证';
}

// Path: colors
class _TranslationsColorsZh extends TranslationsColorsEn {
	_TranslationsColorsZh._(TranslationsZh root) : this._root = root, super.internal(root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get white => '白色';
	@override String get grey => '灰色';
	@override String get black => '黑色';
	@override String get red => '红色';
	@override String get orange => '橙色';
	@override String get blue => '蓝色';
}

// Path: menus
class _TranslationsMenusZh extends TranslationsMenusEn {
	_TranslationsMenusZh._(TranslationsZh root) : this._root = root, super.internal(root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String about({required Object appName}) => '关于 ${appName}';
	@override String hide({required Object appName}) => '隐藏 ${appName}';
	@override String get hideOthers => '隐藏其它';
	@override String get showAll => '显示全部';
	@override String exit({required Object appName}) => '退出 ${appName}';
	@override String get help => '帮助';
	@override String get support => '支持';
	@override String get userAgreement => '用户协议';
	@override String get privacy => '隐私政策';
	@override String get updates => '更新';
}

// Path: buttons
class _TranslationsButtonsZh extends TranslationsButtonsEn {
	_TranslationsButtonsZh._(TranslationsZh root) : this._root = root, super.internal(root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get agree => '同意';
	@override String get cancel => '再想想';
	@override String get ignore => '忽略';
	@override String get turnOn => '打开';
}

// Path: dialogs
class _TranslationsDialogsZh extends TranslationsDialogsEn {
	_TranslationsDialogsZh._(TranslationsZh root) : this._root = root, super.internal(root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get selectColor => '选择颜色';
	@override String get selectFont => '选择字体';
	@override late final _TranslationsDialogsExitConfirmZh exitConfirm = _TranslationsDialogsExitConfirmZh._(_root);
	@override late final _TranslationsDialogsPermissionsZh permissions = _TranslationsDialogsPermissionsZh._(_root);
	@override late final _TranslationsDialogsLicenseDialogZh licenseDialog = _TranslationsDialogsLicenseDialogZh._(_root);
	@override late final _TranslationsDialogsSettingsDialogZh settingsDialog = _TranslationsDialogsSettingsDialogZh._(_root);
}

// Path: dialogs.exitConfirm
class _TranslationsDialogsExitConfirmZh extends TranslationsDialogsExitConfirmEn {
	_TranslationsDialogsExitConfirmZh._(TranslationsZh root) : this._root = root, super.internal(root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get exit => '退出';
	@override String get cancel => '取消';
	@override String get title => '关闭确认';
	@override String get description => '您确定要关闭此窗口吗?';
}

// Path: dialogs.permissions
class _TranslationsDialogsPermissionsZh extends TranslationsDialogsPermissionsEn {
	_TranslationsDialogsPermissionsZh._(TranslationsZh root) : this._root = root, super.internal(root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsDialogsPermissionsPhotosZh photos = _TranslationsDialogsPermissionsPhotosZh._(_root);
	@override late final _TranslationsDialogsPermissionsStorageZh storage = _TranslationsDialogsPermissionsStorageZh._(_root);
}

// Path: dialogs.licenseDialog
class _TranslationsDialogsLicenseDialogZh extends TranslationsDialogsLicenseDialogEn {
	_TranslationsDialogsLicenseDialogZh._(TranslationsZh root) : this._root = root, super.internal(root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get licenseDialogTitle => '隐私条款';
	@override String licenseDialogContentContent({required Object appName}) => '${appName}非常重视你的隐私保护和个人信息保护.';
	@override String get licenseDialogContentTip => '以下是该APP所需的权限列表:';
	@override String get licenseDialogContentPrefix => '在使用APP服务前, 请认真阅读 ';
	@override String get licenseDialogContentUserAgreement => '《用户服务协议》';
	@override String get licenseDialogContentAnd => '和';
	@override String get licenseDialogContentPrivacyPolicy => '《隐私政策》';
	@override String get licenseDialogContentSuffix => ', 你同意并接受全部条款后开始使用我们的服务.';
	@override List<dynamic> get iosPermissions => [
		({required Object appName}) => '为了给您的图像添加水印, ${appName}需要访问您的照片. (NSPhotoLibraryUsageDescription)',
	];
	@override List<dynamic> get androidPermissions => [
		({required Object appName}) => '为了使用 Sentry 服务, ${appName}需要访问您的互联网. (android.permission.INTERNET)',
		({required Object appName}) => '为了给您的图像添加水印, ${appName}需要访问您的存储. (android.permission.READ_EXTERNAL_STORAGE)',
		({required Object appName}) => '为了让您保存图片, ${appName}需要访问您的存储. (android.permission.WRITE_EXTERNAL_STORAGE)',
		({required Object appName}) => '为了给您的图像添加水印, ${appName}需要访问您的照片. (android.permission.READ_MEDIA_IMAGES)',
	];
}

// Path: dialogs.settingsDialog
class _TranslationsDialogsSettingsDialogZh extends TranslationsDialogsSettingsDialogEn {
	_TranslationsDialogsSettingsDialogZh._(TranslationsZh root) : this._root = root, super.internal(root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get settings => '设置';
	@override String get languages => '语言';
	@override late final _TranslationsDialogsSettingsDialogThemesZh themes = _TranslationsDialogsSettingsDialogThemesZh._(_root);
	@override String get themesDescription => '开启后, 将跟随系统打开或关闭深色模式';
}

// Path: dialogs.permissions.photos
class _TranslationsDialogsPermissionsPhotosZh extends TranslationsDialogsPermissionsPhotosEn {
	_TranslationsDialogsPermissionsPhotosZh._(TranslationsZh root) : this._root = root, super.internal(root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get title => '允许访问您的相册';
	@override String description({required Object appName}) => '请前往您的手机设置，授予${appName}访问您相册的权限.';
}

// Path: dialogs.permissions.storage
class _TranslationsDialogsPermissionsStorageZh extends TranslationsDialogsPermissionsStorageEn {
	_TranslationsDialogsPermissionsStorageZh._(TranslationsZh root) : this._root = root, super.internal(root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get title => '允许访问您的存储';
	@override String description({required Object appName}) => '请前往您的手机设置，授予${appName}访问您存储的权限.';
}

// Path: dialogs.settingsDialog.themes
class _TranslationsDialogsSettingsDialogThemesZh extends TranslationsDialogsSettingsDialogThemesEn {
	_TranslationsDialogsSettingsDialogThemesZh._(TranslationsZh root) : this._root = root, super.internal(root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get manual => '手动模式';
	@override String get system => '跟随系统';
	@override String get dark => '深色模式';
	@override String get light => '浅色模式';
}

/// The flat map containing all translations for locale <zh>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on TranslationsZh {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'appName' => ({required Flavor flavor}) { switch (flavor) { case Flavor.free: return 'PicGuard'; case Flavor.pro: return 'PicGuard Pro'; } }, 
			'homePage.appPreview' => '警告: 开发版本, 每个提交自动构建',
			'homePage.imageDescription' => '请上传图片',
			'homePage.description' => '本app不会上传任何图片到服务器, 所有操作均在本地完成',
			'homePage.textLabel' => '文本',
			'homePage.textLabelDescription' => '文本会以水印添加到图片上',
			'homePage.textValidator' => '请输入文本.',
			'homePage.textInput' => '此证件仅用于办理xx业务, 其他用途无效',
			'homePage.colorLabel' => '颜色',
			'homePage.colorValidator' => '请选择颜色.',
			'homePage.opacityLabel' => '不透明度',
			'homePage.fontLabel' => '字体',
			'homePage.fontLabelDescription' => '部分语言不支持自定义字体',
			'homePage.fontValidator' => '请选择字体.',
			'homePage.fontSizeLabel' => '字体大小',
			'homePage.textGapLabel' => '文本间距',
			'homePage.textGapDescription' => '每行文本中, 文本与文本之间的间距',
			'homePage.rowGapLabel' => '行间距',
			'homePage.rowGapDescription' => '每行文本与每行文本之间的间距',
			'homePage.dragging' => '拖拽中',
			'homePage.cancelDrag' => '拖拽已取消',
			'homePage.limitValidator' => ({required Object maxImages, required Object lastImages}) => '最多支持${maxImages}张图片，您还可以上传${lastImages}张图片.',
			'homePage.formatValidator' => '仅支持PNG和JPEG格式.',
			'homePage.preview' => '预览',
			'homePage.save' => '保存',
			'homePage.savedSuccess' => '保存成功',
			'homePage.savedFailure' => '保存失败',
			'homePage.saveInfo' => ({required Object succeedNum, required Object failedNum}) => '已保存${succeedNum}张, 保存失败${failedNum}张',
			'homePage.appNoUpdates' => '应用是最新的!',
			'homePage.backgroundCheckingStopped' => '后台检查停止了',
			'homePage.backgroundCheckingAvailable' => ({required Object latestVersion}) => '后台检查: ${latestVersion}更新可用!',
			'homePage.backgroundCheckingStarted' => ({required Object seconds}) => '后台检查开启了 (每${seconds}秒)',
			'aboutPage.version' => ({required Object version, required Object buildNumber}) => '版本号 ${version}(${buildNumber})',
			'aboutPage.copyright' => ({required Object year, required Object appName}) => '版权 © ${year} ${appName}. 版权所有。',
			'aboutPage.slogan' => '给图片添加水印, 防止被恶意使用.',
			'aboutPage.readme' => '项目简介',
			'aboutPage.appLicense' => '应用许可证',
			'aboutPage.changelog' => '变更日志',
			'aboutPage.thirdPartyLicense' => '第三方许可证',
			'colors.white' => '白色',
			'colors.grey' => '灰色',
			'colors.black' => '黑色',
			'colors.red' => '红色',
			'colors.orange' => '橙色',
			'colors.blue' => '蓝色',
			'menus.about' => ({required Object appName}) => '关于 ${appName}',
			'menus.hide' => ({required Object appName}) => '隐藏 ${appName}',
			'menus.hideOthers' => '隐藏其它',
			'menus.showAll' => '显示全部',
			'menus.exit' => ({required Object appName}) => '退出 ${appName}',
			'menus.help' => '帮助',
			'menus.support' => '支持',
			'menus.userAgreement' => '用户协议',
			'menus.privacy' => '隐私政策',
			'menus.updates' => '更新',
			'buttons.agree' => '同意',
			'buttons.cancel' => '再想想',
			'buttons.ignore' => '忽略',
			'buttons.turnOn' => '打开',
			'dialogs.selectColor' => '选择颜色',
			'dialogs.selectFont' => '选择字体',
			'dialogs.exitConfirm.exit' => '退出',
			'dialogs.exitConfirm.cancel' => '取消',
			'dialogs.exitConfirm.title' => '关闭确认',
			'dialogs.exitConfirm.description' => '您确定要关闭此窗口吗?',
			'dialogs.permissions.photos.title' => '允许访问您的相册',
			'dialogs.permissions.photos.description' => ({required Object appName}) => '请前往您的手机设置，授予${appName}访问您相册的权限.',
			'dialogs.permissions.storage.title' => '允许访问您的存储',
			'dialogs.permissions.storage.description' => ({required Object appName}) => '请前往您的手机设置，授予${appName}访问您存储的权限.',
			'dialogs.licenseDialog.licenseDialogTitle' => '隐私条款',
			'dialogs.licenseDialog.licenseDialogContentContent' => ({required Object appName}) => '${appName}非常重视你的隐私保护和个人信息保护.',
			'dialogs.licenseDialog.licenseDialogContentTip' => '以下是该APP所需的权限列表:',
			'dialogs.licenseDialog.licenseDialogContentPrefix' => '在使用APP服务前, 请认真阅读 ',
			'dialogs.licenseDialog.licenseDialogContentUserAgreement' => '《用户服务协议》',
			'dialogs.licenseDialog.licenseDialogContentAnd' => '和',
			'dialogs.licenseDialog.licenseDialogContentPrivacyPolicy' => '《隐私政策》',
			'dialogs.licenseDialog.licenseDialogContentSuffix' => ', 你同意并接受全部条款后开始使用我们的服务.',
			'dialogs.licenseDialog.iosPermissions.0' => ({required Object appName}) => '为了给您的图像添加水印, ${appName}需要访问您的照片. (NSPhotoLibraryUsageDescription)',
			'dialogs.licenseDialog.androidPermissions.0' => ({required Object appName}) => '为了使用 Sentry 服务, ${appName}需要访问您的互联网. (android.permission.INTERNET)',
			'dialogs.licenseDialog.androidPermissions.1' => ({required Object appName}) => '为了给您的图像添加水印, ${appName}需要访问您的存储. (android.permission.READ_EXTERNAL_STORAGE)',
			'dialogs.licenseDialog.androidPermissions.2' => ({required Object appName}) => '为了让您保存图片, ${appName}需要访问您的存储. (android.permission.WRITE_EXTERNAL_STORAGE)',
			'dialogs.licenseDialog.androidPermissions.3' => ({required Object appName}) => '为了给您的图像添加水印, ${appName}需要访问您的照片. (android.permission.READ_MEDIA_IMAGES)',
			'dialogs.settingsDialog.settings' => '设置',
			'dialogs.settingsDialog.languages' => '语言',
			'dialogs.settingsDialog.themes.manual' => '手动模式',
			'dialogs.settingsDialog.themes.system' => '跟随系统',
			'dialogs.settingsDialog.themes.dark' => '深色模式',
			'dialogs.settingsDialog.themes.light' => '浅色模式',
			'dialogs.settingsDialog.themesDescription' => '开启后, 将跟随系统打开或关闭深色模式',
			'locales.en' => 'English',
			'locales.it' => 'Italian',
			'locales.zh' => '中文',
			_ => null,
		};
	}
}
