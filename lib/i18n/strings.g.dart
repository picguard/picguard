/// Generated file. Do not edit.
///
/// Original: lib/i18n
/// To regenerate, run: `dart run slang`
///
/// Locales: 2
/// Strings: 96 (48 per locale)
///
/// Built on 2024-08-05 at 05:14 UTC

// coverage:ignore-file
// ignore_for_file: type=lint

import 'package:flutter/widgets.dart';
import 'package:slang/builder/model/node.dart';
import 'package:slang_flutter/slang_flutter.dart';
export 'package:slang_flutter/slang_flutter.dart';

const AppLocale _baseLocale = AppLocale.en;

/// Supported locales, see extension methods below.
///
/// Usage:
/// - LocaleSettings.setLocale(AppLocale.en) // set locale
/// - Locale locale = AppLocale.en.flutterLocale // get flutter locale from enum
/// - if (LocaleSettings.currentLocale == AppLocale.en) // locale check
enum AppLocale with BaseAppLocale<AppLocale, Translations> {
	en(languageCode: 'en', build: Translations.build),
	zh(languageCode: 'zh', build: _StringsZh.build);

	const AppLocale({required this.languageCode, this.scriptCode, this.countryCode, required this.build}); // ignore: unused_element

	@override final String languageCode;
	@override final String? scriptCode;
	@override final String? countryCode;
	@override final TranslationBuilder<AppLocale, Translations> build;

	/// Gets current instance managed by [LocaleSettings].
	Translations get translations => LocaleSettings.instance.translationMap[this]!;
}

/// Method A: Simple
///
/// No rebuild after locale change.
/// Translation happens during initialization of the widget (call of t).
/// Configurable via 'translate_var'.
///
/// Usage:
/// String a = t.someKey.anotherKey;
/// String b = t['someKey.anotherKey']; // Only for edge cases!
Translations get t => LocaleSettings.instance.currentTranslations;

/// Method B: Advanced
///
/// All widgets using this method will trigger a rebuild when locale changes.
/// Use this if you have e.g. a settings page where the user can select the locale during runtime.
///
/// Step 1:
/// wrap your App with
/// TranslationProvider(
/// 	child: MyApp()
/// );
///
/// Step 2:
/// final t = Translations.of(context); // Get t variable.
/// String a = t.someKey.anotherKey; // Use t variable.
/// String b = t['someKey.anotherKey']; // Only for edge cases!
class TranslationProvider extends BaseTranslationProvider<AppLocale, Translations> {
	TranslationProvider({required super.child}) : super(settings: LocaleSettings.instance);

	static InheritedLocaleData<AppLocale, Translations> of(BuildContext context) => InheritedLocaleData.of<AppLocale, Translations>(context);
}

/// Method B shorthand via [BuildContext] extension method.
/// Configurable via 'translate_var'.
///
/// Usage (e.g. in a widget's build method):
/// context.t.someKey.anotherKey
extension BuildContextTranslationsExtension on BuildContext {
	Translations get t => TranslationProvider.of(this).translations;
}

/// Manages all translation instances and the current locale
class LocaleSettings extends BaseFlutterLocaleSettings<AppLocale, Translations> {
	LocaleSettings._() : super(utils: AppLocaleUtils.instance);

	static final instance = LocaleSettings._();

	// static aliases (checkout base methods for documentation)
	static AppLocale get currentLocale => instance.currentLocale;
	static Stream<AppLocale> getLocaleStream() => instance.getLocaleStream();
	static AppLocale setLocale(AppLocale locale, {bool? listenToDeviceLocale = false}) => instance.setLocale(locale, listenToDeviceLocale: listenToDeviceLocale);
	static AppLocale setLocaleRaw(String rawLocale, {bool? listenToDeviceLocale = false}) => instance.setLocaleRaw(rawLocale, listenToDeviceLocale: listenToDeviceLocale);
	static AppLocale useDeviceLocale() => instance.useDeviceLocale();
	@Deprecated('Use [AppLocaleUtils.supportedLocales]') static List<Locale> get supportedLocales => instance.supportedLocales;
	@Deprecated('Use [AppLocaleUtils.supportedLocalesRaw]') static List<String> get supportedLocalesRaw => instance.supportedLocalesRaw;
	static void setPluralResolver({String? language, AppLocale? locale, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver}) => instance.setPluralResolver(
		language: language,
		locale: locale,
		cardinalResolver: cardinalResolver,
		ordinalResolver: ordinalResolver,
	);
}

/// Provides utility functions without any side effects.
class AppLocaleUtils extends BaseAppLocaleUtils<AppLocale, Translations> {
	AppLocaleUtils._() : super(baseLocale: _baseLocale, locales: AppLocale.values);

	static final instance = AppLocaleUtils._();

	// static aliases (checkout base methods for documentation)
	static AppLocale parse(String rawLocale) => instance.parse(rawLocale);
	static AppLocale parseLocaleParts({required String languageCode, String? scriptCode, String? countryCode}) => instance.parseLocaleParts(languageCode: languageCode, scriptCode: scriptCode, countryCode: countryCode);
	static AppLocale findDeviceLocale() => instance.findDeviceLocale();
	static List<Locale> get supportedLocales => instance.supportedLocales;
	static List<String> get supportedLocalesRaw => instance.supportedLocalesRaw;
}

// context enums

enum Flavor {
	free,
	pro,
}

// translations

// Path: <root>
class Translations implements BaseTranslations<AppLocale, Translations> {
	/// Returns the current translations of the given [context].
	///
	/// Usage:
	/// final t = Translations.of(context);
	static Translations of(BuildContext context) => InheritedLocaleData.of<AppLocale, Translations>(context).translations;

	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	Translations.build({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = TranslationMetadata(
		    locale: AppLocale.en,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <en>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	dynamic operator[](String key) => $meta.getTranslation(key);

	late final Translations _root = this; // ignore: unused_field

	// Translations
	String appName({required Flavor flavor}) {
		switch (flavor) {
			case Flavor.free:
				return 'PicGuard';
			case Flavor.pro:
				return 'PicGuard Pro';
		}
	}
	late final _StringsHomePageEn homePage = _StringsHomePageEn._(_root);
	late final _StringsButtonsEn buttons = _StringsButtonsEn._(_root);
	late final _StringsDialogsEn dialogs = _StringsDialogsEn._(_root);
	Map<String, String> get locales => {
		'en': 'English',
		'zh': '中文',
	};
}

// Path: homePage
class _StringsHomePageEn {
	_StringsHomePageEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get imageDescription => 'Please upload pictures.';
	String get description => 'This app will not upload any pictures to the server, all operations are completed locally';
	String get textLabel => 'Text';
	String get textLabelDescription => 'Text will be added to the image as a watermark';
	String get textValidator => 'Please enter text.';
	String get textInput => 'This certificate is only used for handling xx business, and is invalid for other purposes.';
	String get colorLabel => 'Color';
	String get colorValidator => 'Please select a color.';
	String get transparencyLabel => 'Transparency';
	String get fontLabel => 'Font';
	String get fontValidator => 'Please select a font.';
	String get textGapLabel => 'Text spacing';
	String get textGapDescription => 'The spacing between text in each line of text';
	String get rowGapLabel => 'Line spacing';
	String get rowGapDescription => 'The spacing between each line of text';
	String get preview => 'Preview';
	String get save => 'Save';
	String get savedSuccess => 'Saved successfully';
	String get savedFailure => 'Failed to save image(s)';
}

// Path: buttons
class _StringsButtonsEn {
	_StringsButtonsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get agree => 'Agree';
	String get cancel => 'Cancel';
	String get ignore => 'Ignore';
	String get turnOn => 'Turn On';
}

// Path: dialogs
class _StringsDialogsEn {
	_StringsDialogsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final _StringsDialogsExitConfirmEn exitConfirm = _StringsDialogsExitConfirmEn._(_root);
	late final _StringsDialogsPermissionsEn permissions = _StringsDialogsPermissionsEn._(_root);
	late final _StringsDialogsLicenseDialogEn licenseDialog = _StringsDialogsLicenseDialogEn._(_root);
}

// Path: dialogs.exitConfirm
class _StringsDialogsExitConfirmEn {
	_StringsDialogsExitConfirmEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get exit => 'Exit';
	String get cancel => 'Cancel';
	String get title => 'Close confirmation';
	String get description => 'Are you sure you want to close this window?';
}

// Path: dialogs.permissions
class _StringsDialogsPermissionsEn {
	_StringsDialogsPermissionsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final _StringsDialogsPermissionsPhotosEn photos = _StringsDialogsPermissionsPhotosEn._(_root);
	late final _StringsDialogsPermissionsStorageEn storage = _StringsDialogsPermissionsStorageEn._(_root);
}

// Path: dialogs.licenseDialog
class _StringsDialogsLicenseDialogEn {
	_StringsDialogsLicenseDialogEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get licenseDialogTitle => 'Terms and Conditions';
	String licenseDialogContentContent({required Object appName}) => 'Protecting user\'s privacy and personal information is a fundamental principle of ${appName}.';
	String get licenseDialogContentTip => 'Below is a list of permissions required by this APP:';
	String get licenseDialogContentPrefix => 'Before you use this APP\'s services, please carefully read and agree to the ';
	String get licenseDialogContentUserAgreement => 'User Agreement';
	String get licenseDialogContentAnd => ' and ';
	String get licenseDialogContentPrivacyAgreement => 'Privacy Agreement';
	String get licenseDialogContentSuffix => ', start using our services after you agree and accept all terms.';
	List<dynamic> get iosPermissions => [
		({required Object appName}) => 'For you to upload pictures, ${appName} needs access to your Photos. (NSPhotoLibraryUsageDescription)',
	];
	List<dynamic> get androidPermissions => [
		({required Object appName}) => 'In order to use the Sentry Service, ${appName} needs access to your Internet. (android.permission.INTERNET)',
		({required Object appName}) => 'For you to upload pictures, ${appName} needs access to your Storage. (android.permission.READ_EXTERNAL_STORAGE)',
		({required Object appName}) => 'For you to save pictures, ${appName} needs access to your Storage. (android.permission.WRITE_EXTERNAL_STORAGE)',
		({required Object appName}) => 'For you to upload pictures, ${appName} needs access to your Photos. (android.permission.READ_MEDIA_IMAGES)',
	];
}

// Path: dialogs.permissions.photos
class _StringsDialogsPermissionsPhotosEn {
	_StringsDialogsPermissionsPhotosEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Allow access to your album';
	String description({required Object appName}) => 'Please go to your phone Settings to grant ${appName} the permission to visit your album.';
}

// Path: dialogs.permissions.storage
class _StringsDialogsPermissionsStorageEn {
	_StringsDialogsPermissionsStorageEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Allow access to your storage';
	String description({required Object appName}) => 'Please go to your phone Settings to grant ${appName} the permission to visit your storage.';
}

// Path: <root>
class _StringsZh implements Translations {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	_StringsZh.build({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = TranslationMetadata(
		    locale: AppLocale.zh,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <zh>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	@override dynamic operator[](String key) => $meta.getTranslation(key);

	@override late final _StringsZh _root = this; // ignore: unused_field

	// Translations
	@override String appName({required Flavor flavor}) {
		switch (flavor) {
			case Flavor.free:
				return 'PicGuard';
			case Flavor.pro:
				return 'PicGuard Pro';
		}
	}
	@override late final _StringsHomePageZh homePage = _StringsHomePageZh._(_root);
	@override late final _StringsButtonsZh buttons = _StringsButtonsZh._(_root);
	@override late final _StringsDialogsZh dialogs = _StringsDialogsZh._(_root);
	@override Map<String, String> get locales => {
		'en': 'English',
		'zh': '中文',
	};
}

// Path: homePage
class _StringsHomePageZh implements _StringsHomePageEn {
	_StringsHomePageZh._(this._root);

	@override final _StringsZh _root; // ignore: unused_field

	// Translations
	@override String get imageDescription => '请上传图片';
	@override String get description => '本app不会上传任何图片到服务器, 所有操作均在本地完成';
	@override String get textLabel => '文本';
	@override String get textLabelDescription => '文本会以水印添加到图片上';
	@override String get textValidator => '请输入文本.';
	@override String get textInput => '此证件仅用于办理xx业务, 其他用途无效';
	@override String get colorLabel => '颜色';
	@override String get colorValidator => '请选择颜色.';
	@override String get transparencyLabel => '透明度';
	@override String get fontLabel => '字体';
	@override String get fontValidator => '请选择字体.';
	@override String get textGapLabel => '文本间距';
	@override String get textGapDescription => '每行文本中, 文本与文本之间的间距';
	@override String get rowGapLabel => '行间距';
	@override String get rowGapDescription => '每行文本与每行文本之间的间距';
	@override String get preview => '预览';
	@override String get save => '保存';
	@override String get savedSuccess => '保存成功';
	@override String get savedFailure => '保存失败';
}

// Path: buttons
class _StringsButtonsZh implements _StringsButtonsEn {
	_StringsButtonsZh._(this._root);

	@override final _StringsZh _root; // ignore: unused_field

	// Translations
	@override String get agree => '同意';
	@override String get cancel => '再想想';
	@override String get ignore => '忽略';
	@override String get turnOn => '打开';
}

// Path: dialogs
class _StringsDialogsZh implements _StringsDialogsEn {
	_StringsDialogsZh._(this._root);

	@override final _StringsZh _root; // ignore: unused_field

	// Translations
	@override late final _StringsDialogsExitConfirmZh exitConfirm = _StringsDialogsExitConfirmZh._(_root);
	@override late final _StringsDialogsPermissionsZh permissions = _StringsDialogsPermissionsZh._(_root);
	@override late final _StringsDialogsLicenseDialogZh licenseDialog = _StringsDialogsLicenseDialogZh._(_root);
}

// Path: dialogs.exitConfirm
class _StringsDialogsExitConfirmZh implements _StringsDialogsExitConfirmEn {
	_StringsDialogsExitConfirmZh._(this._root);

	@override final _StringsZh _root; // ignore: unused_field

	// Translations
	@override String get exit => '退出';
	@override String get cancel => '取消';
	@override String get title => '关闭确认';
	@override String get description => '您确定要关闭此窗口吗?';
}

// Path: dialogs.permissions
class _StringsDialogsPermissionsZh implements _StringsDialogsPermissionsEn {
	_StringsDialogsPermissionsZh._(this._root);

	@override final _StringsZh _root; // ignore: unused_field

	// Translations
	@override late final _StringsDialogsPermissionsPhotosZh photos = _StringsDialogsPermissionsPhotosZh._(_root);
	@override late final _StringsDialogsPermissionsStorageZh storage = _StringsDialogsPermissionsStorageZh._(_root);
}

// Path: dialogs.licenseDialog
class _StringsDialogsLicenseDialogZh implements _StringsDialogsLicenseDialogEn {
	_StringsDialogsLicenseDialogZh._(this._root);

	@override final _StringsZh _root; // ignore: unused_field

	// Translations
	@override String get licenseDialogTitle => '隐私条款';
	@override String licenseDialogContentContent({required Object appName}) => '${appName}非常重视你的隐私保护和个人信息保护.';
	@override String get licenseDialogContentTip => '以下是该APP所需的权限列表:';
	@override String get licenseDialogContentPrefix => '在使用APP服务前, 请认真阅读 ';
	@override String get licenseDialogContentUserAgreement => '《隐私政策》';
	@override String get licenseDialogContentAnd => '和';
	@override String get licenseDialogContentPrivacyAgreement => '《用户服务协议》';
	@override String get licenseDialogContentSuffix => ', 你同意并接受全部条款后开始使用我们的服务.';
	@override List<dynamic> get iosPermissions => [
		({required Object appName}) => '为了让您上传图片, ${appName}需要访问您的照片. (NSPhotoLibraryUsageDescription)',
	];
	@override List<dynamic> get androidPermissions => [
		({required Object appName}) => '为了使用 Sentry 服务, ${appName}需要访问您的互联网. (android.permission.INTERNET)',
		({required Object appName}) => '为了让您上传图片, ${appName}需要访问您的存储. (android.permission.READ_EXTERNAL_STORAGE)',
		({required Object appName}) => '为了让您保存图片, ${appName}需要访问您的存储. (android.permission.WRITE_EXTERNAL_STORAGE)',
		({required Object appName}) => '为了让您上传图片, ${appName}需要访问您的照片. (android.permission.READ_MEDIA_IMAGES)',
	];
}

// Path: dialogs.permissions.photos
class _StringsDialogsPermissionsPhotosZh implements _StringsDialogsPermissionsPhotosEn {
	_StringsDialogsPermissionsPhotosZh._(this._root);

	@override final _StringsZh _root; // ignore: unused_field

	// Translations
	@override String get title => '允许访问您的相册';
	@override String description({required Object appName}) => '请前往您的手机设置，授予${appName}访问您相册的权限.';
}

// Path: dialogs.permissions.storage
class _StringsDialogsPermissionsStorageZh implements _StringsDialogsPermissionsStorageEn {
	_StringsDialogsPermissionsStorageZh._(this._root);

	@override final _StringsZh _root; // ignore: unused_field

	// Translations
	@override String get title => '允许访问您的存储';
	@override String description({required Object appName}) => '请前往您的手机设置，授予${appName}访问您存储的权限.';
}

/// Flat map(s) containing all translations.
/// Only for edge cases! For simple maps, use the map function of this library.

extension on Translations {
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
			case 'homePage.imageDescription': return 'Please upload pictures.';
			case 'homePage.description': return 'This app will not upload any pictures to the server, all operations are completed locally';
			case 'homePage.textLabel': return 'Text';
			case 'homePage.textLabelDescription': return 'Text will be added to the image as a watermark';
			case 'homePage.textValidator': return 'Please enter text.';
			case 'homePage.textInput': return 'This certificate is only used for handling xx business, and is invalid for other purposes.';
			case 'homePage.colorLabel': return 'Color';
			case 'homePage.colorValidator': return 'Please select a color.';
			case 'homePage.transparencyLabel': return 'Transparency';
			case 'homePage.fontLabel': return 'Font';
			case 'homePage.fontValidator': return 'Please select a font.';
			case 'homePage.textGapLabel': return 'Text spacing';
			case 'homePage.textGapDescription': return 'The spacing between text in each line of text';
			case 'homePage.rowGapLabel': return 'Line spacing';
			case 'homePage.rowGapDescription': return 'The spacing between each line of text';
			case 'homePage.preview': return 'Preview';
			case 'homePage.save': return 'Save';
			case 'homePage.savedSuccess': return 'Saved successfully';
			case 'homePage.savedFailure': return 'Failed to save image(s)';
			case 'buttons.agree': return 'Agree';
			case 'buttons.cancel': return 'Cancel';
			case 'buttons.ignore': return 'Ignore';
			case 'buttons.turnOn': return 'Turn On';
			case 'dialogs.exitConfirm.exit': return 'Exit';
			case 'dialogs.exitConfirm.cancel': return 'Cancel';
			case 'dialogs.exitConfirm.title': return 'Close confirmation';
			case 'dialogs.exitConfirm.description': return 'Are you sure you want to close this window?';
			case 'dialogs.permissions.photos.title': return 'Allow access to your album';
			case 'dialogs.permissions.photos.description': return ({required Object appName}) => 'Please go to your phone Settings to grant ${appName} the permission to visit your album.';
			case 'dialogs.permissions.storage.title': return 'Allow access to your storage';
			case 'dialogs.permissions.storage.description': return ({required Object appName}) => 'Please go to your phone Settings to grant ${appName} the permission to visit your storage.';
			case 'dialogs.licenseDialog.licenseDialogTitle': return 'Terms and Conditions';
			case 'dialogs.licenseDialog.licenseDialogContentContent': return ({required Object appName}) => 'Protecting user\'s privacy and personal information is a fundamental principle of ${appName}.';
			case 'dialogs.licenseDialog.licenseDialogContentTip': return 'Below is a list of permissions required by this APP:';
			case 'dialogs.licenseDialog.licenseDialogContentPrefix': return 'Before you use this APP\'s services, please carefully read and agree to the ';
			case 'dialogs.licenseDialog.licenseDialogContentUserAgreement': return 'User Agreement';
			case 'dialogs.licenseDialog.licenseDialogContentAnd': return ' and ';
			case 'dialogs.licenseDialog.licenseDialogContentPrivacyAgreement': return 'Privacy Agreement';
			case 'dialogs.licenseDialog.licenseDialogContentSuffix': return ', start using our services after you agree and accept all terms.';
			case 'dialogs.licenseDialog.iosPermissions.0': return ({required Object appName}) => 'For you to upload pictures, ${appName} needs access to your Photos. (NSPhotoLibraryUsageDescription)';
			case 'dialogs.licenseDialog.androidPermissions.0': return ({required Object appName}) => 'In order to use the Sentry Service, ${appName} needs access to your Internet. (android.permission.INTERNET)';
			case 'dialogs.licenseDialog.androidPermissions.1': return ({required Object appName}) => 'For you to upload pictures, ${appName} needs access to your Storage. (android.permission.READ_EXTERNAL_STORAGE)';
			case 'dialogs.licenseDialog.androidPermissions.2': return ({required Object appName}) => 'For you to save pictures, ${appName} needs access to your Storage. (android.permission.WRITE_EXTERNAL_STORAGE)';
			case 'dialogs.licenseDialog.androidPermissions.3': return ({required Object appName}) => 'For you to upload pictures, ${appName} needs access to your Photos. (android.permission.READ_MEDIA_IMAGES)';
			case 'locales.en': return 'English';
			case 'locales.zh': return '中文';
			default: return null;
		}
	}
}

extension on _StringsZh {
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
			case 'homePage.imageDescription': return '请上传图片';
			case 'homePage.description': return '本app不会上传任何图片到服务器, 所有操作均在本地完成';
			case 'homePage.textLabel': return '文本';
			case 'homePage.textLabelDescription': return '文本会以水印添加到图片上';
			case 'homePage.textValidator': return '请输入文本.';
			case 'homePage.textInput': return '此证件仅用于办理xx业务, 其他用途无效';
			case 'homePage.colorLabel': return '颜色';
			case 'homePage.colorValidator': return '请选择颜色.';
			case 'homePage.transparencyLabel': return '透明度';
			case 'homePage.fontLabel': return '字体';
			case 'homePage.fontValidator': return '请选择字体.';
			case 'homePage.textGapLabel': return '文本间距';
			case 'homePage.textGapDescription': return '每行文本中, 文本与文本之间的间距';
			case 'homePage.rowGapLabel': return '行间距';
			case 'homePage.rowGapDescription': return '每行文本与每行文本之间的间距';
			case 'homePage.preview': return '预览';
			case 'homePage.save': return '保存';
			case 'homePage.savedSuccess': return '保存成功';
			case 'homePage.savedFailure': return '保存失败';
			case 'buttons.agree': return '同意';
			case 'buttons.cancel': return '再想想';
			case 'buttons.ignore': return '忽略';
			case 'buttons.turnOn': return '打开';
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
			case 'dialogs.licenseDialog.licenseDialogContentUserAgreement': return '《隐私政策》';
			case 'dialogs.licenseDialog.licenseDialogContentAnd': return '和';
			case 'dialogs.licenseDialog.licenseDialogContentPrivacyAgreement': return '《用户服务协议》';
			case 'dialogs.licenseDialog.licenseDialogContentSuffix': return ', 你同意并接受全部条款后开始使用我们的服务.';
			case 'dialogs.licenseDialog.iosPermissions.0': return ({required Object appName}) => '为了让您上传图片, ${appName}需要访问您的照片. (NSPhotoLibraryUsageDescription)';
			case 'dialogs.licenseDialog.androidPermissions.0': return ({required Object appName}) => '为了使用 Sentry 服务, ${appName}需要访问您的互联网. (android.permission.INTERNET)';
			case 'dialogs.licenseDialog.androidPermissions.1': return ({required Object appName}) => '为了让您上传图片, ${appName}需要访问您的存储. (android.permission.READ_EXTERNAL_STORAGE)';
			case 'dialogs.licenseDialog.androidPermissions.2': return ({required Object appName}) => '为了让您保存图片, ${appName}需要访问您的存储. (android.permission.WRITE_EXTERNAL_STORAGE)';
			case 'dialogs.licenseDialog.androidPermissions.3': return ({required Object appName}) => '为了让您上传图片, ${appName}需要访问您的照片. (android.permission.READ_MEDIA_IMAGES)';
			case 'locales.en': return 'English';
			case 'locales.zh': return '中文';
			default: return null;
		}
	}
}
