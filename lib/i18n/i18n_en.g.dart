///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import

part of 'i18n.g.dart';

// Path: <root>
typedef TranslationsEn = Translations; // ignore: unused_element
class Translations implements BaseTranslations<AppLocale, Translations> {
	/// Returns the current translations of the given [context].
	///
	/// Usage:
	/// final t = Translations.of(context);
	static Translations of(BuildContext context) => InheritedLocaleData.of<AppLocale, Translations>(context).translations;

	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	Translations({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver})
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
	late final TranslationsHomePageEn homePage = TranslationsHomePageEn.internal(_root);
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
	String get imageDescription => 'Please upload pictures.';
	String get description => 'This app will not upload any pictures to the server, all operations are completed locally';
	String get textLabel => 'Text';
	String get textLabelDescription => 'Text will be added to the image as a watermark';
	String get textValidator => 'Please enter text.';
	String get textInput => 'This certificate is only used for handling xx business, and is invalid for other purposes.';
	String get colorLabel => 'Color';
	String get colorValidator => 'Please select a color.';
	String get opacityLabel => 'Opacity';
	String get fontLabel => 'Font';
	String get fontLabelDescription => 'Some languages do not support custom fonts';
	String get fontValidator => 'Please select a font.';
	String get fontSizeLabel => 'Font size';
	String get textGapLabel => 'Text spacing';
	String get textGapDescription => 'The spacing between text in each line of text';
	String get rowGapLabel => 'Line spacing';
	String get rowGapDescription => 'The spacing between each line of text';
	String get preview => 'Preview';
	String get save => 'Save';
	String get savedSuccess => 'Saved successfully';
	String get savedFailure => 'Failed to save image(s)';
	String saveInfo({required Object succeedNum, required Object failedNum}) => '${succeedNum} image(s) saved, ${failedNum} image(s) failed to save';
}

// Path: menus
class TranslationsMenusEn {
	TranslationsMenusEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get help => 'Help';
	String get support => 'Support';
	String get userAgreement => 'User Agreement';
	String get privacy => 'Privacy Policy';
}

// Path: buttons
class TranslationsButtonsEn {
	TranslationsButtonsEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get agree => 'Agree';
	String get cancel => 'Cancel';
	String get ignore => 'Ignore';
	String get turnOn => 'Turn On';
}

// Path: dialogs
class TranslationsDialogsEn {
	TranslationsDialogsEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get selectColor => 'Select a color';
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
	String get exit => 'Exit';
	String get cancel => 'Cancel';
	String get title => 'Close confirmation';
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
	String get licenseDialogTitle => 'Terms and Conditions';
	String licenseDialogContentContent({required Object appName}) => 'Protecting user\'s privacy and personal information is a fundamental principle of ${appName}.';
	String get licenseDialogContentTip => 'Below is a list of permissions required by this APP:';
	String get licenseDialogContentPrefix => 'Before you use this APP\'s services, please carefully read and agree to the ';
	String get licenseDialogContentUserAgreement => 'User Agreement';
	String get licenseDialogContentAnd => ' and ';
	String get licenseDialogContentPrivacyPolicy => 'Privacy Policy';
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
	String get settings => 'Settings';
	String get languages => 'Languages';
	late final TranslationsDialogsSettingsDialogThemesEn themes = TranslationsDialogsSettingsDialogThemesEn.internal(_root);
	String get themesDescription => 'After turning it on, the dark mode will be turned on or off according to the system';
}

// Path: dialogs.permissions.photos
class TranslationsDialogsPermissionsPhotosEn {
	TranslationsDialogsPermissionsPhotosEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Allow access to your album';
	String description({required Object appName}) => 'Please go to your phone Settings to grant ${appName} the permission to visit your album.';
}

// Path: dialogs.permissions.storage
class TranslationsDialogsPermissionsStorageEn {
	TranslationsDialogsPermissionsStorageEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Allow access to your storage';
	String description({required Object appName}) => 'Please go to your phone Settings to grant ${appName} the permission to visit your storage.';
}

// Path: dialogs.settingsDialog.themes
class TranslationsDialogsSettingsDialogThemesEn {
	TranslationsDialogsSettingsDialogThemesEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get manual => 'Manual Mode';
	String get system => 'Auto Mode';
	String get dark => 'Dark Mode';
	String get light => 'Light Mode';
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
			case 'homePage.opacityLabel': return 'Opacity';
			case 'homePage.fontLabel': return 'Font';
			case 'homePage.fontLabelDescription': return 'Some languages do not support custom fonts';
			case 'homePage.fontValidator': return 'Please select a font.';
			case 'homePage.fontSizeLabel': return 'Font size';
			case 'homePage.textGapLabel': return 'Text spacing';
			case 'homePage.textGapDescription': return 'The spacing between text in each line of text';
			case 'homePage.rowGapLabel': return 'Line spacing';
			case 'homePage.rowGapDescription': return 'The spacing between each line of text';
			case 'homePage.preview': return 'Preview';
			case 'homePage.save': return 'Save';
			case 'homePage.savedSuccess': return 'Saved successfully';
			case 'homePage.savedFailure': return 'Failed to save image(s)';
			case 'homePage.saveInfo': return ({required Object succeedNum, required Object failedNum}) => '${succeedNum} image(s) saved, ${failedNum} image(s) failed to save';
			case 'menus.help': return 'Help';
			case 'menus.support': return 'Support';
			case 'menus.userAgreement': return 'User Agreement';
			case 'menus.privacy': return 'Privacy Policy';
			case 'buttons.agree': return 'Agree';
			case 'buttons.cancel': return 'Cancel';
			case 'buttons.ignore': return 'Ignore';
			case 'buttons.turnOn': return 'Turn On';
			case 'dialogs.selectColor': return 'Select a color';
			case 'dialogs.selectFont': return 'Select a font';
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
			case 'dialogs.licenseDialog.licenseDialogContentPrivacyPolicy': return 'Privacy Policy';
			case 'dialogs.licenseDialog.licenseDialogContentSuffix': return ', start using our services after you agree and accept all terms.';
			case 'dialogs.licenseDialog.iosPermissions.0': return ({required Object appName}) => 'In order to add watermarks to your images, ${appName} needs access to your Photos. (NSPhotoLibraryUsageDescription)';
			case 'dialogs.licenseDialog.androidPermissions.0': return ({required Object appName}) => 'In order to use the Sentry Service, ${appName} needs access to your Internet. (android.permission.INTERNET)';
			case 'dialogs.licenseDialog.androidPermissions.1': return ({required Object appName}) => 'In order to add watermarks to your images, ${appName} needs access to your Storage. (android.permission.READ_EXTERNAL_STORAGE)';
			case 'dialogs.licenseDialog.androidPermissions.2': return ({required Object appName}) => 'In order to save images, ${appName} needs access to your Storage. (android.permission.WRITE_EXTERNAL_STORAGE)';
			case 'dialogs.licenseDialog.androidPermissions.3': return ({required Object appName}) => 'In order to add watermarks to your images, ${appName} needs access to your Photos. (android.permission.READ_MEDIA_IMAGES)';
			case 'dialogs.settingsDialog.settings': return 'Settings';
			case 'dialogs.settingsDialog.languages': return 'Languages';
			case 'dialogs.settingsDialog.themes.manual': return 'Manual Mode';
			case 'dialogs.settingsDialog.themes.system': return 'Auto Mode';
			case 'dialogs.settingsDialog.themes.dark': return 'Dark Mode';
			case 'dialogs.settingsDialog.themes.light': return 'Light Mode';
			case 'dialogs.settingsDialog.themesDescription': return 'After turning it on, the dark mode will be turned on or off according to the system';
			case 'locales.en': return 'English';
			case 'locales.it': return 'Italian';
			case 'locales.zh': return '中文';
			default: return null;
		}
	}
}

