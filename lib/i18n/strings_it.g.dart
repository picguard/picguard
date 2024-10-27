///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import

import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:slang/generated.dart';
import 'strings.g.dart';

// Path: <root>
class TranslationsIt implements Translations {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsIt({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = TranslationMetadata(
		    locale: AppLocale.it,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <it>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	@override dynamic operator[](String key) => $meta.getTranslation(key);

	late final TranslationsIt _root = this; // ignore: unused_field

	// Translations
	@override String appName({required Flavor flavor}) {
		switch (flavor) {
			case Flavor.free:
				return 'PicGuard';
			case Flavor.pro:
				return 'PicGuard Pro';
		}
	}
	@override late final _TranslationsHomePageIt homePage = _TranslationsHomePageIt._(_root);
	@override late final _TranslationsButtonsIt buttons = _TranslationsButtonsIt._(_root);
	@override late final _TranslationsDialogsIt dialogs = _TranslationsDialogsIt._(_root);
	@override Map<String, String> get locales => {
		'en': 'English',
		'it': 'Italiano',
		'zh': '中文',
	};
	@override late final _TranslationsThemesIt themes = _TranslationsThemesIt._(_root);
}

// Path: homePage
class _TranslationsHomePageIt implements TranslationsHomePageEn {
	_TranslationsHomePageIt._(this._root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get imageDescription => 'Si prega di caricare le immagini.';
	@override String get description => 'Questa app non caricherà alcuna immagine sul server, tutte le operazioni vengono completate localmente';
	@override String get textLabel => 'Testo';
	@override String get textLabelDescription => 'Il testo verrà aggiunto all\'immagine come filigrana';
	@override String get textValidator => 'Inserisci il testo.';
	@override String get textInput => 'Questo certificato è utilizzato solo per la gestione di xx attività e non è valido per altri scopi.';
	@override String get colorLabel => 'Colore';
	@override String get colorValidator => 'Seleziona un colore.';
	@override String get opacityLabel => 'Opacità';
	@override String get fontLabel => 'Font';
	@override String get fontValidator => 'Seleziona un font.';
	@override String get fontSizeLabel => 'Dimensione del font';
	@override String get textGapLabel => 'Spaziatura del testo';
	@override String get textGapDescription => 'La spaziatura tra il testo in ogni riga di testo';
	@override String get rowGapLabel => 'Interlinea';
	@override String get rowGapDescription => 'La spaziatura tra ogni riga di testo';
	@override String get preview => 'Anteprima';
	@override String get save => 'Salva';
	@override String get savedSuccess => 'Salvataggio riuscito';
	@override String get savedFailure => 'Impossibile salvare l\'immagine(i)';
	@override String get settings => 'Impostazioni';
	@override String get languages => 'Lingue';
}

// Path: buttons
class _TranslationsButtonsIt implements TranslationsButtonsEn {
	_TranslationsButtonsIt._(this._root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get agree => 'Accetto';
	@override String get cancel => 'Annulla';
	@override String get ignore => 'Ignora';
	@override String get turnOn => 'Accendi';
}

// Path: dialogs
class _TranslationsDialogsIt implements TranslationsDialogsEn {
	_TranslationsDialogsIt._(this._root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsDialogsExitConfirmIt exitConfirm = _TranslationsDialogsExitConfirmIt._(_root);
	@override late final _TranslationsDialogsPermissionsIt permissions = _TranslationsDialogsPermissionsIt._(_root);
	@override late final _TranslationsDialogsLicenseDialogIt licenseDialog = _TranslationsDialogsLicenseDialogIt._(_root);
}

// Path: themes
class _TranslationsThemesIt implements TranslationsThemesEn {
	_TranslationsThemesIt._(this._root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get manual => 'Modalità manuale';
	@override String get system => 'Modalità automatica';
	@override String get dark => 'Modalità scura';
	@override String get light => 'Modalità chiara';
	@override String get description => 'Dopo averlo attivato, la modalità scura verrà attivata o disattivata in base al sistema';
}

// Path: dialogs.exitConfirm
class _TranslationsDialogsExitConfirmIt implements TranslationsDialogsExitConfirmEn {
	_TranslationsDialogsExitConfirmIt._(this._root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get exit => 'Uscita';
	@override String get cancel => 'Annulla';
	@override String get title => 'Chiudi conferma';
	@override String get description => 'Sei sicuro di voler chiudere questa finestra?';
}

// Path: dialogs.permissions
class _TranslationsDialogsPermissionsIt implements TranslationsDialogsPermissionsEn {
	_TranslationsDialogsPermissionsIt._(this._root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsDialogsPermissionsPhotosIt photos = _TranslationsDialogsPermissionsPhotosIt._(_root);
	@override late final _TranslationsDialogsPermissionsStorageIt storage = _TranslationsDialogsPermissionsStorageIt._(_root);
}

// Path: dialogs.licenseDialog
class _TranslationsDialogsLicenseDialogIt implements TranslationsDialogsLicenseDialogEn {
	_TranslationsDialogsLicenseDialogIt._(this._root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get licenseDialogTitle => 'Termini e Condizioni';
	@override String licenseDialogContentContent({required Object appName}) => 'La protezione della privacy e delle informazioni personali degli utenti è un principio fondamentale di ${appName}.';
	@override String get licenseDialogContentTip => 'Di seguito è riportato l\'elenco delle autorizzazioni richieste da questa APP:';
	@override String get licenseDialogContentPrefix => 'Prima di utilizzare i servizi di questa APP, ti preghiamo di leggere attentamente e accettare il ';
	@override String get licenseDialogContentUserAgreement => 'Contratto d\'uso';
	@override String get licenseDialogContentAnd => ' e ';
	@override String get licenseDialogContentPrivacyAgreement => 'L\'accordo sulla privacy';
	@override String get licenseDialogContentSuffix => ', inizia a utilizzare i nostri servizi dopo aver accettato tutti i termini.';
	@override List<dynamic> get iosPermissions => [
		({required Object appName}) => 'Per aggiungere una filigrana alle tue immagini, ${appName} deve accedere alle tue foto. (NSPhotoLibraryUsageDescription)',
	];
	@override List<dynamic> get androidPermissions => [
		({required Object appName}) => 'Per poter utilizzare il servizio Sentry, ${appName} deve avere accesso a Internet. (android.permission.INTERNET)',
		({required Object appName}) => 'Per filigranare le tue immagini, ${appName} deve accedere al tuo spazio di archiviazione. (android.permission.READ_EXTERNAL_STORAGE)',
		({required Object appName}) => 'Per poter salvare le immagini, ${appName} deve accedere al tuo spazio di archiviazione. (android.permission.WRITE_EXTERNAL_STORAGE)',
		({required Object appName}) => 'Per aggiungere una filigrana alle tue immagini, ${appName} deve accedere alle tue foto. (android.permission.READ_MEDIA_IMAGES)',
	];
}

// Path: dialogs.permissions.photos
class _TranslationsDialogsPermissionsPhotosIt implements TranslationsDialogsPermissionsPhotosEn {
	_TranslationsDialogsPermissionsPhotosIt._(this._root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Consenti l\'accesso al tuo album';
	@override String description({required Object appName}) => 'Vai alle Impostazioni del tuo telefono per concedere a ${appName} l\'autorizzazione a visitare il tuo album.';
}

// Path: dialogs.permissions.storage
class _TranslationsDialogsPermissionsStorageIt implements TranslationsDialogsPermissionsStorageEn {
	_TranslationsDialogsPermissionsStorageIt._(this._root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Consenti l\'accesso al tuo archivio';
	@override String description({required Object appName}) => 'Accedi alle Impostazioni del tuo telefono per concedere a ${appName} l\'autorizzazione ad accedere al tuo archivio.';
}

/// Flat map(s) containing all translations.
/// Only for edge cases! For simple maps, use the map function of this library.
extension on TranslationsIt {
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
			case 'homePage.imageDescription': return 'Si prega di caricare le immagini.';
			case 'homePage.description': return 'Questa app non caricherà alcuna immagine sul server, tutte le operazioni vengono completate localmente';
			case 'homePage.textLabel': return 'Testo';
			case 'homePage.textLabelDescription': return 'Il testo verrà aggiunto all\'immagine come filigrana';
			case 'homePage.textValidator': return 'Inserisci il testo.';
			case 'homePage.textInput': return 'Questo certificato è utilizzato solo per la gestione di xx attività e non è valido per altri scopi.';
			case 'homePage.colorLabel': return 'Colore';
			case 'homePage.colorValidator': return 'Seleziona un colore.';
			case 'homePage.opacityLabel': return 'Opacità';
			case 'homePage.fontLabel': return 'Font';
			case 'homePage.fontValidator': return 'Seleziona un font.';
			case 'homePage.fontSizeLabel': return 'Dimensione del font';
			case 'homePage.textGapLabel': return 'Spaziatura del testo';
			case 'homePage.textGapDescription': return 'La spaziatura tra il testo in ogni riga di testo';
			case 'homePage.rowGapLabel': return 'Interlinea';
			case 'homePage.rowGapDescription': return 'La spaziatura tra ogni riga di testo';
			case 'homePage.preview': return 'Anteprima';
			case 'homePage.save': return 'Salva';
			case 'homePage.savedSuccess': return 'Salvataggio riuscito';
			case 'homePage.savedFailure': return 'Impossibile salvare l\'immagine(i)';
			case 'homePage.settings': return 'Impostazioni';
			case 'homePage.languages': return 'Lingue';
			case 'buttons.agree': return 'Accetto';
			case 'buttons.cancel': return 'Annulla';
			case 'buttons.ignore': return 'Ignora';
			case 'buttons.turnOn': return 'Accendi';
			case 'dialogs.exitConfirm.exit': return 'Uscita';
			case 'dialogs.exitConfirm.cancel': return 'Annulla';
			case 'dialogs.exitConfirm.title': return 'Chiudi conferma';
			case 'dialogs.exitConfirm.description': return 'Sei sicuro di voler chiudere questa finestra?';
			case 'dialogs.permissions.photos.title': return 'Consenti l\'accesso al tuo album';
			case 'dialogs.permissions.photos.description': return ({required Object appName}) => 'Vai alle Impostazioni del tuo telefono per concedere a ${appName} l\'autorizzazione a visitare il tuo album.';
			case 'dialogs.permissions.storage.title': return 'Consenti l\'accesso al tuo archivio';
			case 'dialogs.permissions.storage.description': return ({required Object appName}) => 'Accedi alle Impostazioni del tuo telefono per concedere a ${appName} l\'autorizzazione ad accedere al tuo archivio.';
			case 'dialogs.licenseDialog.licenseDialogTitle': return 'Termini e Condizioni';
			case 'dialogs.licenseDialog.licenseDialogContentContent': return ({required Object appName}) => 'La protezione della privacy e delle informazioni personali degli utenti è un principio fondamentale di ${appName}.';
			case 'dialogs.licenseDialog.licenseDialogContentTip': return 'Di seguito è riportato l\'elenco delle autorizzazioni richieste da questa APP:';
			case 'dialogs.licenseDialog.licenseDialogContentPrefix': return 'Prima di utilizzare i servizi di questa APP, ti preghiamo di leggere attentamente e accettare il ';
			case 'dialogs.licenseDialog.licenseDialogContentUserAgreement': return 'Contratto d\'uso';
			case 'dialogs.licenseDialog.licenseDialogContentAnd': return ' e ';
			case 'dialogs.licenseDialog.licenseDialogContentPrivacyAgreement': return 'L\'accordo sulla privacy';
			case 'dialogs.licenseDialog.licenseDialogContentSuffix': return ', inizia a utilizzare i nostri servizi dopo aver accettato tutti i termini.';
			case 'dialogs.licenseDialog.iosPermissions.0': return ({required Object appName}) => 'Per aggiungere una filigrana alle tue immagini, ${appName} deve accedere alle tue foto. (NSPhotoLibraryUsageDescription)';
			case 'dialogs.licenseDialog.androidPermissions.0': return ({required Object appName}) => 'Per poter utilizzare il servizio Sentry, ${appName} deve avere accesso a Internet. (android.permission.INTERNET)';
			case 'dialogs.licenseDialog.androidPermissions.1': return ({required Object appName}) => 'Per filigranare le tue immagini, ${appName} deve accedere al tuo spazio di archiviazione. (android.permission.READ_EXTERNAL_STORAGE)';
			case 'dialogs.licenseDialog.androidPermissions.2': return ({required Object appName}) => 'Per poter salvare le immagini, ${appName} deve accedere al tuo spazio di archiviazione. (android.permission.WRITE_EXTERNAL_STORAGE)';
			case 'dialogs.licenseDialog.androidPermissions.3': return ({required Object appName}) => 'Per aggiungere una filigrana alle tue immagini, ${appName} deve accedere alle tue foto. (android.permission.READ_MEDIA_IMAGES)';
			case 'locales.en': return 'English';
			case 'locales.it': return 'Italiano';
			case 'locales.zh': return '中文';
			case 'themes.manual': return 'Modalità manuale';
			case 'themes.system': return 'Modalità automatica';
			case 'themes.dark': return 'Modalità scura';
			case 'themes.light': return 'Modalità chiara';
			case 'themes.description': return 'Dopo averlo attivato, la modalità scura verrà attivata o disattivata in base al sistema';
			default: return null;
		}
	}
}
