///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import

import 'i18n.g.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:slang/generated.dart';

// Path: <root>
class TranslationsZh extends Translations {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsZh({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = TranslationMetadata(
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
	@override String get preview => '预览';
	@override String get save => '保存';
	@override String get savedSuccess => '保存成功';
	@override String get savedFailure => '保存失败';
	@override String saveInfo({required Object succeedNum, required Object failedNum}) => '已保存${succeedNum}张, 保存失败${failedNum}张';
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

/// Flat map(s) containing all translations.
/// Only for edge cases! For simple maps, use the map function of this library.
extension on TranslationsZh {
	dynamic _flatMapFunction(String path) {
		switch (path) {
			case 'appName': return ({required Flavor flavor}) {
				switch (flavor) {
					case Flavor.free:
						return 'PicGuard';
					case Flavor.pro:
						return 'PicGuard Pro';
				}
			};
			case 'homePage.appPreview': return '警告: 开发版本, 每个提交自动构建';
			case 'homePage.imageDescription': return '请上传图片';
			case 'homePage.description': return '本app不会上传任何图片到服务器, 所有操作均在本地完成';
			case 'homePage.textLabel': return '文本';
			case 'homePage.textLabelDescription': return '文本会以水印添加到图片上';
			case 'homePage.textValidator': return '请输入文本.';
			case 'homePage.textInput': return '此证件仅用于办理xx业务, 其他用途无效';
			case 'homePage.colorLabel': return '颜色';
			case 'homePage.colorValidator': return '请选择颜色.';
			case 'homePage.opacityLabel': return '不透明度';
			case 'homePage.fontLabel': return '字体';
			case 'homePage.fontLabelDescription': return '部分语言不支持自定义字体';
			case 'homePage.fontValidator': return '请选择字体.';
			case 'homePage.fontSizeLabel': return '字体大小';
			case 'homePage.textGapLabel': return '文本间距';
			case 'homePage.textGapDescription': return '每行文本中, 文本与文本之间的间距';
			case 'homePage.rowGapLabel': return '行间距';
			case 'homePage.rowGapDescription': return '每行文本与每行文本之间的间距';
			case 'homePage.preview': return '预览';
			case 'homePage.save': return '保存';
			case 'homePage.savedSuccess': return '保存成功';
			case 'homePage.savedFailure': return '保存失败';
			case 'homePage.saveInfo': return ({required Object succeedNum, required Object failedNum}) => '已保存${succeedNum}张, 保存失败${failedNum}张';
			case 'aboutPage.version': return ({required Object version, required Object buildNumber}) => '版本号 ${version}(${buildNumber})';
			case 'aboutPage.copyright': return ({required Object year, required Object appName}) => '版权 © ${year} ${appName}. 版权所有。';
			case 'aboutPage.slogan': return '给图片添加水印, 防止被恶意使用.';
			case 'aboutPage.readme': return '项目简介';
			case 'aboutPage.appLicense': return '应用许可证';
			case 'aboutPage.changelog': return '变更日志';
			case 'aboutPage.thirdPartyLicense': return '第三方许可证';
			case 'colors.white': return '白色';
			case 'colors.grey': return '灰色';
			case 'colors.black': return '黑色';
			case 'colors.red': return '红色';
			case 'colors.orange': return '橙色';
			case 'colors.blue': return '蓝色';
			case 'menus.about': return ({required Object appName}) => '关于 ${appName}';
			case 'menus.hide': return ({required Object appName}) => '隐藏 ${appName}';
			case 'menus.hideOthers': return '隐藏其它';
			case 'menus.showAll': return '显示全部';
			case 'menus.exit': return ({required Object appName}) => '退出 ${appName}';
			case 'menus.help': return '帮助';
			case 'menus.support': return '支持';
			case 'menus.userAgreement': return '用户协议';
			case 'menus.privacy': return '隐私政策';
			case 'buttons.agree': return '同意';
			case 'buttons.cancel': return '再想想';
			case 'buttons.ignore': return '忽略';
			case 'buttons.turnOn': return '打开';
			case 'dialogs.selectColor': return '选择颜色';
			case 'dialogs.selectFont': return '选择字体';
			case 'dialogs.exitConfirm.exit': return '退出';
			case 'dialogs.exitConfirm.cancel': return '取消';
			case 'dialogs.exitConfirm.title': return '关闭确认';
			case 'dialogs.exitConfirm.description': return '您确定要关闭此窗口吗?';
			case 'dialogs.permissions.photos.title': return '允许访问您的相册';
			case 'dialogs.permissions.photos.description': return ({required Object appName}) => '请前往您的手机设置，授予${appName}访问您相册的权限.';
			case 'dialogs.permissions.storage.title': return '允许访问您的存储';
			case 'dialogs.permissions.storage.description': return ({required Object appName}) => '请前往您的手机设置，授予${appName}访问您存储的权限.';
			case 'dialogs.licenseDialog.licenseDialogTitle': return '隐私条款';
			case 'dialogs.licenseDialog.licenseDialogContentContent': return ({required Object appName}) => '${appName}非常重视你的隐私保护和个人信息保护.';
			case 'dialogs.licenseDialog.licenseDialogContentTip': return '以下是该APP所需的权限列表:';
			case 'dialogs.licenseDialog.licenseDialogContentPrefix': return '在使用APP服务前, 请认真阅读 ';
			case 'dialogs.licenseDialog.licenseDialogContentUserAgreement': return '《用户服务协议》';
			case 'dialogs.licenseDialog.licenseDialogContentAnd': return '和';
			case 'dialogs.licenseDialog.licenseDialogContentPrivacyPolicy': return '《隐私政策》';
			case 'dialogs.licenseDialog.licenseDialogContentSuffix': return ', 你同意并接受全部条款后开始使用我们的服务.';
			case 'dialogs.licenseDialog.iosPermissions.0': return ({required Object appName}) => '为了给您的图像添加水印, ${appName}需要访问您的照片. (NSPhotoLibraryUsageDescription)';
			case 'dialogs.licenseDialog.androidPermissions.0': return ({required Object appName}) => '为了使用 Sentry 服务, ${appName}需要访问您的互联网. (android.permission.INTERNET)';
			case 'dialogs.licenseDialog.androidPermissions.1': return ({required Object appName}) => '为了给您的图像添加水印, ${appName}需要访问您的存储. (android.permission.READ_EXTERNAL_STORAGE)';
			case 'dialogs.licenseDialog.androidPermissions.2': return ({required Object appName}) => '为了让您保存图片, ${appName}需要访问您的存储. (android.permission.WRITE_EXTERNAL_STORAGE)';
			case 'dialogs.licenseDialog.androidPermissions.3': return ({required Object appName}) => '为了给您的图像添加水印, ${appName}需要访问您的照片. (android.permission.READ_MEDIA_IMAGES)';
			case 'dialogs.settingsDialog.settings': return '设置';
			case 'dialogs.settingsDialog.languages': return '语言';
			case 'dialogs.settingsDialog.themes.manual': return '手动模式';
			case 'dialogs.settingsDialog.themes.system': return '跟随系统';
			case 'dialogs.settingsDialog.themes.dark': return '深色模式';
			case 'dialogs.settingsDialog.themes.light': return '浅色模式';
			case 'dialogs.settingsDialog.themesDescription': return '开启后, 将跟随系统打开或关闭深色模式';
			case 'locales.en': return 'English';
			case 'locales.it': return 'Italian';
			case 'locales.zh': return '中文';
			default: return null;
		}
	}
}

