///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import
// dart format off

part of 'i18n.g.dart';

// Path: <root>
typedef TranslationsEn = Translations; // ignore: unused_element
class Translations with BaseTranslations<AppLocale, Translations> {
	/// Returns the current translations of the given [context].
	///
	/// Usage:
	/// final t = Translations.of(context);
	static Translations of(BuildContext context) => InheritedLocaleData.of<AppLocale, Translations>(context).translations;

	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	Translations({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = meta ?? TranslationMetadata(
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

	Translations $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => Translations(meta: meta ?? this.$meta);

	// Translations

	/// en: '(free) {PicGuard} (pro) {PicGuard Pro}'
	String appName({required Flavor flavor}) {
		switch (flavor) {
			case Flavor.free:
				return 'PicGuard';
			case Flavor.pro:
				return 'PicGuard Pro';
		}
	}

	late final TranslationsHomePageEn homePage = TranslationsHomePageEn.internal(_root);
	late final TranslationsAboutPageEn aboutPage = TranslationsAboutPageEn.internal(_root);
	late final TranslationsColorsEn colors = TranslationsColorsEn.internal(_root);
	late final TranslationsMenusEn menus = TranslationsMenusEn.internal(_root);
	late final TranslationsButtonsEn buttons = TranslationsButtonsEn.internal(_root);
	late final TranslationsDialogsEn dialogs = TranslationsDialogsEn.internal(_root);
	Map<String, String> get locales => {
		'en': 'English',
		'it': 'Italian',
		'zh': '中文',
	};
}

// Path: homePage
class TranslationsHomePageEn {
	TranslationsHomePageEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'WARNING: Development version, automatically built on each commit'
	String get appPreview => 'WARNING: Development version, automatically built on each commit';

	/// en: 'Please upload pictures.'
	String get imageDescription => 'Please upload pictures.';

	/// en: 'This app will not upload any pictures to the server, all operations are completed locally'
	String get description => 'This app will not upload any pictures to the server, all operations are completed locally';

	/// en: 'Text'
	String get textLabel => 'Text';

	/// en: 'Text will be added to the image as a watermark'
	String get textLabelDescription => 'Text will be added to the image as a watermark';

	/// en: 'Please enter text.'
	String get textValidator => 'Please enter text.';

	/// en: 'This certificate is only used for handling xx business, and is invalid for other purposes.'
	String get textInput => 'This certificate is only used for handling xx business, and is invalid for other purposes.';

	/// en: 'Color'
	String get colorLabel => 'Color';

	/// en: 'Please select a color.'
	String get colorValidator => 'Please select a color.';

	/// en: 'Opacity'
	String get opacityLabel => 'Opacity';

	/// en: 'Font'
	String get fontLabel => 'Font';

	/// en: 'Some languages do not support custom fonts'
	String get fontLabelDescription => 'Some languages do not support custom fonts';

	/// en: 'Please select a font.'
	String get fontValidator => 'Please select a font.';

	/// en: 'Font size'
	String get fontSizeLabel => 'Font size';

	/// en: 'Text spacing'
	String get textGapLabel => 'Text spacing';

	/// en: 'The spacing between text in each line of text'
	String get textGapDescription => 'The spacing between text in each line of text';

	/// en: 'Line spacing'
	String get rowGapLabel => 'Line spacing';

	/// en: 'The spacing between each line of text'
	String get rowGapDescription => 'The spacing between each line of text';

	/// en: 'Dragging'
	String get dragging => 'Dragging';

	/// en: 'Drag canceled'
	String get cancelDrag => 'Drag canceled';

	/// en: 'Supports up to $maxImages pictures, you can also upload $lastImages picture(s).'
	String limitValidator({required Object maxImages, required Object lastImages}) => 'Supports up to ${maxImages} pictures, you can also upload ${lastImages} picture(s).';

	/// en: 'Only PNG and JPEG formats are supported.'
	String get formatValidator => 'Only PNG and JPEG formats are supported.';

	/// en: 'Preview'
	String get preview => 'Preview';

	/// en: 'Save'
	String get save => 'Save';

	/// en: 'Saved successfully'
	String get savedSuccess => 'Saved successfully';

	/// en: 'Failed to save image(s)'
	String get savedFailure => 'Failed to save image(s)';

	/// en: '$succeedNum image(s) saved, $failedNum image(s) failed to save'
	String saveInfo({required Object succeedNum, required Object failedNum}) => '${succeedNum} image(s) saved, ${failedNum} image(s) failed to save';
}

// Path: aboutPage
class TranslationsAboutPageEn {
	TranslationsAboutPageEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Version $version($buildNumber)'
	String version({required Object version, required Object buildNumber}) => 'Version ${version}(${buildNumber})';

	/// en: 'Copyright © $year $appName. All rights reserved.'
	String copyright({required Object year, required Object appName}) => 'Copyright © ${year} ${appName}. All rights reserved.';

	/// en: 'Your pictures, your signature.'
	String get slogan => 'Your pictures, your signature.';

	/// en: 'Readme'
	String get readme => 'Readme';

	/// en: 'Application License'
	String get appLicense => 'Application License';

	/// en: 'Changelog'
	String get changelog => 'Changelog';

	/// en: 'Third Party Licenses'
	String get thirdPartyLicense => 'Third Party Licenses';
}

// Path: colors
class TranslationsColorsEn {
	TranslationsColorsEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'White'
	String get white => 'White';

	/// en: 'Grey'
	String get grey => 'Grey';

	/// en: 'Black'
	String get black => 'Black';

	/// en: 'Red'
	String get red => 'Red';

	/// en: 'Orange'
	String get orange => 'Orange';

	/// en: 'Blue'
	String get blue => 'Blue';
}

// Path: menus
class TranslationsMenusEn {
	TranslationsMenusEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'About $appName'
	String about({required Object appName}) => 'About ${appName}';

	/// en: 'Hide $appName'
	String hide({required Object appName}) => 'Hide ${appName}';

	/// en: 'Hide Others'
	String get hideOthers => 'Hide Others';

	/// en: 'Show All'
	String get showAll => 'Show All';

	/// en: 'Quit $appName'
	String exit({required Object appName}) => 'Quit ${appName}';

	/// en: 'Help'
	String get help => 'Help';

	/// en: 'Support'
	String get support => 'Support';

	/// en: 'User Agreement'
	String get userAgreement => 'User Agreement';

	/// en: 'Privacy Policy'
	String get privacy => 'Privacy Policy';
}

// Path: buttons
class TranslationsButtonsEn {
	TranslationsButtonsEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Agree'
	String get agree => 'Agree';

	/// en: 'Cancel'
	String get cancel => 'Cancel';

	/// en: 'Ignore'
	String get ignore => 'Ignore';

	/// en: 'Turn On'
	String get turnOn => 'Turn On';
}

// Path: dialogs
class TranslationsDialogsEn {
	TranslationsDialogsEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Select a color'
	String get selectColor => 'Select a color';

	/// en: 'Select a font'
	String get selectFont => 'Select a font';

	late final TranslationsDialogsExitConfirmEn exitConfirm = TranslationsDialogsExitConfirmEn.internal(_root);
	late final TranslationsDialogsPermissionsEn permissions = TranslationsDialogsPermissionsEn.internal(_root);
	late final TranslationsDialogsLicenseDialogEn licenseDialog = TranslationsDialogsLicenseDialogEn.internal(_root);
	late final TranslationsDialogsSettingsDialogEn settingsDialog = TranslationsDialogsSettingsDialogEn.internal(_root);
}

// Path: dialogs.exitConfirm
class TranslationsDialogsExitConfirmEn {
	TranslationsDialogsExitConfirmEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Exit'
	String get exit => 'Exit';

	/// en: 'Cancel'
	String get cancel => 'Cancel';

	/// en: 'Close confirmation'
	String get title => 'Close confirmation';

	/// en: 'Are you sure you want to close this window?'
	String get description => 'Are you sure you want to close this window?';
}

// Path: dialogs.permissions
class TranslationsDialogsPermissionsEn {
	TranslationsDialogsPermissionsEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final TranslationsDialogsPermissionsPhotosEn photos = TranslationsDialogsPermissionsPhotosEn.internal(_root);
	late final TranslationsDialogsPermissionsStorageEn storage = TranslationsDialogsPermissionsStorageEn.internal(_root);
}

// Path: dialogs.licenseDialog
class TranslationsDialogsLicenseDialogEn {
	TranslationsDialogsLicenseDialogEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Terms and Conditions'
	String get licenseDialogTitle => 'Terms and Conditions';

	/// en: 'Protecting user's privacy and personal information is a fundamental principle of $appName.'
	String licenseDialogContentContent({required Object appName}) => 'Protecting user\'s privacy and personal information is a fundamental principle of ${appName}.';

	/// en: 'Below is a list of permissions required by this APP:'
	String get licenseDialogContentTip => 'Below is a list of permissions required by this APP:';

	/// en: 'Before you use this APP's services, please carefully read and agree to the '
	String get licenseDialogContentPrefix => 'Before you use this APP\'s services, please carefully read and agree to the ';

	/// en: 'User Agreement'
	String get licenseDialogContentUserAgreement => 'User Agreement';

	/// en: ' and '
	String get licenseDialogContentAnd => ' and ';

	/// en: 'Privacy Policy'
	String get licenseDialogContentPrivacyPolicy => 'Privacy Policy';

	/// en: ', start using our services after you agree and accept all terms.'
	String get licenseDialogContentSuffix => ', start using our services after you agree and accept all terms.';

	List<dynamic> get iosPermissions => [
		({required Object appName}) => 'In order to add watermarks to your images, ${appName} needs access to your Photos. (NSPhotoLibraryUsageDescription)',
	];
	List<dynamic> get androidPermissions => [
		({required Object appName}) => 'In order to use the Sentry Service, ${appName} needs access to your Internet. (android.permission.INTERNET)',
		({required Object appName}) => 'In order to add watermarks to your images, ${appName} needs access to your Storage. (android.permission.READ_EXTERNAL_STORAGE)',
		({required Object appName}) => 'In order to save images, ${appName} needs access to your Storage. (android.permission.WRITE_EXTERNAL_STORAGE)',
		({required Object appName}) => 'In order to add watermarks to your images, ${appName} needs access to your Photos. (android.permission.READ_MEDIA_IMAGES)',
	];
}

// Path: dialogs.settingsDialog
class TranslationsDialogsSettingsDialogEn {
	TranslationsDialogsSettingsDialogEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Settings'
	String get settings => 'Settings';

	/// en: 'Languages'
	String get languages => 'Languages';

	late final TranslationsDialogsSettingsDialogThemesEn themes = TranslationsDialogsSettingsDialogThemesEn.internal(_root);

	/// en: 'After turning it on, the dark mode will be turned on or off according to the system'
	String get themesDescription => 'After turning it on, the dark mode will be turned on or off according to the system';
}

// Path: dialogs.permissions.photos
class TranslationsDialogsPermissionsPhotosEn {
	TranslationsDialogsPermissionsPhotosEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Allow access to your album'
	String get title => 'Allow access to your album';

	/// en: 'Please go to your phone Settings to grant $appName the permission to visit your album.'
	String description({required Object appName}) => 'Please go to your phone Settings to grant ${appName} the permission to visit your album.';
}

// Path: dialogs.permissions.storage
class TranslationsDialogsPermissionsStorageEn {
	TranslationsDialogsPermissionsStorageEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Allow access to your storage'
	String get title => 'Allow access to your storage';

	/// en: 'Please go to your phone Settings to grant $appName the permission to visit your storage.'
	String description({required Object appName}) => 'Please go to your phone Settings to grant ${appName} the permission to visit your storage.';
}

// Path: dialogs.settingsDialog.themes
class TranslationsDialogsSettingsDialogThemesEn {
	TranslationsDialogsSettingsDialogThemesEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Manual Mode'
	String get manual => 'Manual Mode';

	/// en: 'Auto Mode'
	String get system => 'Auto Mode';

	/// en: 'Dark Mode'
	String get dark => 'Dark Mode';

	/// en: 'Light Mode'
	String get light => 'Light Mode';
}

/// The flat map containing all translations for locale <en>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on Translations {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'appName' => ({required Flavor flavor}) { switch (flavor) { case Flavor.free: return 'PicGuard'; case Flavor.pro: return 'PicGuard Pro'; } }, 
			'homePage.appPreview' => 'WARNING: Development version, automatically built on each commit',
			'homePage.imageDescription' => 'Please upload pictures.',
			'homePage.description' => 'This app will not upload any pictures to the server, all operations are completed locally',
			'homePage.textLabel' => 'Text',
			'homePage.textLabelDescription' => 'Text will be added to the image as a watermark',
			'homePage.textValidator' => 'Please enter text.',
			'homePage.textInput' => 'This certificate is only used for handling xx business, and is invalid for other purposes.',
			'homePage.colorLabel' => 'Color',
			'homePage.colorValidator' => 'Please select a color.',
			'homePage.opacityLabel' => 'Opacity',
			'homePage.fontLabel' => 'Font',
			'homePage.fontLabelDescription' => 'Some languages do not support custom fonts',
			'homePage.fontValidator' => 'Please select a font.',
			'homePage.fontSizeLabel' => 'Font size',
			'homePage.textGapLabel' => 'Text spacing',
			'homePage.textGapDescription' => 'The spacing between text in each line of text',
			'homePage.rowGapLabel' => 'Line spacing',
			'homePage.rowGapDescription' => 'The spacing between each line of text',
			'homePage.dragging' => 'Dragging',
			'homePage.cancelDrag' => 'Drag canceled',
			'homePage.limitValidator' => ({required Object maxImages, required Object lastImages}) => 'Supports up to ${maxImages} pictures, you can also upload ${lastImages} picture(s).',
			'homePage.formatValidator' => 'Only PNG and JPEG formats are supported.',
			'homePage.preview' => 'Preview',
			'homePage.save' => 'Save',
			'homePage.savedSuccess' => 'Saved successfully',
			'homePage.savedFailure' => 'Failed to save image(s)',
			'homePage.saveInfo' => ({required Object succeedNum, required Object failedNum}) => '${succeedNum} image(s) saved, ${failedNum} image(s) failed to save',
			'aboutPage.version' => ({required Object version, required Object buildNumber}) => 'Version ${version}(${buildNumber})',
			'aboutPage.copyright' => ({required Object year, required Object appName}) => 'Copyright © ${year} ${appName}. All rights reserved.',
			'aboutPage.slogan' => 'Your pictures, your signature.',
			'aboutPage.readme' => 'Readme',
			'aboutPage.appLicense' => 'Application License',
			'aboutPage.changelog' => 'Changelog',
			'aboutPage.thirdPartyLicense' => 'Third Party Licenses',
			'colors.white' => 'White',
			'colors.grey' => 'Grey',
			'colors.black' => 'Black',
			'colors.red' => 'Red',
			'colors.orange' => 'Orange',
			'colors.blue' => 'Blue',
			'menus.about' => ({required Object appName}) => 'About ${appName}',
			'menus.hide' => ({required Object appName}) => 'Hide ${appName}',
			'menus.hideOthers' => 'Hide Others',
			'menus.showAll' => 'Show All',
			'menus.exit' => ({required Object appName}) => 'Quit ${appName}',
			'menus.help' => 'Help',
			'menus.support' => 'Support',
			'menus.userAgreement' => 'User Agreement',
			'menus.privacy' => 'Privacy Policy',
			'buttons.agree' => 'Agree',
			'buttons.cancel' => 'Cancel',
			'buttons.ignore' => 'Ignore',
			'buttons.turnOn' => 'Turn On',
			'dialogs.selectColor' => 'Select a color',
			'dialogs.selectFont' => 'Select a font',
			'dialogs.exitConfirm.exit' => 'Exit',
			'dialogs.exitConfirm.cancel' => 'Cancel',
			'dialogs.exitConfirm.title' => 'Close confirmation',
			'dialogs.exitConfirm.description' => 'Are you sure you want to close this window?',
			'dialogs.permissions.photos.title' => 'Allow access to your album',
			'dialogs.permissions.photos.description' => ({required Object appName}) => 'Please go to your phone Settings to grant ${appName} the permission to visit your album.',
			'dialogs.permissions.storage.title' => 'Allow access to your storage',
			'dialogs.permissions.storage.description' => ({required Object appName}) => 'Please go to your phone Settings to grant ${appName} the permission to visit your storage.',
			'dialogs.licenseDialog.licenseDialogTitle' => 'Terms and Conditions',
			'dialogs.licenseDialog.licenseDialogContentContent' => ({required Object appName}) => 'Protecting user\'s privacy and personal information is a fundamental principle of ${appName}.',
			'dialogs.licenseDialog.licenseDialogContentTip' => 'Below is a list of permissions required by this APP:',
			'dialogs.licenseDialog.licenseDialogContentPrefix' => 'Before you use this APP\'s services, please carefully read and agree to the ',
			'dialogs.licenseDialog.licenseDialogContentUserAgreement' => 'User Agreement',
			'dialogs.licenseDialog.licenseDialogContentAnd' => ' and ',
			'dialogs.licenseDialog.licenseDialogContentPrivacyPolicy' => 'Privacy Policy',
			'dialogs.licenseDialog.licenseDialogContentSuffix' => ', start using our services after you agree and accept all terms.',
			'dialogs.licenseDialog.iosPermissions.0' => ({required Object appName}) => 'In order to add watermarks to your images, ${appName} needs access to your Photos. (NSPhotoLibraryUsageDescription)',
			'dialogs.licenseDialog.androidPermissions.0' => ({required Object appName}) => 'In order to use the Sentry Service, ${appName} needs access to your Internet. (android.permission.INTERNET)',
			'dialogs.licenseDialog.androidPermissions.1' => ({required Object appName}) => 'In order to add watermarks to your images, ${appName} needs access to your Storage. (android.permission.READ_EXTERNAL_STORAGE)',
			'dialogs.licenseDialog.androidPermissions.2' => ({required Object appName}) => 'In order to save images, ${appName} needs access to your Storage. (android.permission.WRITE_EXTERNAL_STORAGE)',
			'dialogs.licenseDialog.androidPermissions.3' => ({required Object appName}) => 'In order to add watermarks to your images, ${appName} needs access to your Photos. (android.permission.READ_MEDIA_IMAGES)',
			'dialogs.settingsDialog.settings' => 'Settings',
			'dialogs.settingsDialog.languages' => 'Languages',
			'dialogs.settingsDialog.themes.manual' => 'Manual Mode',
			'dialogs.settingsDialog.themes.system' => 'Auto Mode',
			'dialogs.settingsDialog.themes.dark' => 'Dark Mode',
			'dialogs.settingsDialog.themes.light' => 'Light Mode',
			'dialogs.settingsDialog.themesDescription' => 'After turning it on, the dark mode will be turned on or off according to the system',
			'locales.en' => 'English',
			'locales.it' => 'Italian',
			'locales.zh' => '中文',
			_ => null,
		};
	}
}
