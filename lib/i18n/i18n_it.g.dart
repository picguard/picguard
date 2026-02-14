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
class TranslationsIt extends Translations with BaseTranslations<AppLocale, Translations> {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsIt({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = meta ?? TranslationMetadata(
		    locale: AppLocale.it,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ),
		  super(cardinalResolver: cardinalResolver, ordinalResolver: ordinalResolver) {
		super.$meta.setFlatMapFunction($meta.getTranslation); // copy base translations to super.$meta
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <it>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	@override dynamic operator[](String key) => $meta.getTranslation(key) ?? super.$meta.getTranslation(key);

	late final TranslationsIt _root = this; // ignore: unused_field

	@override 
	TranslationsIt $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => TranslationsIt(meta: meta ?? this.$meta);

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
	@override late final _TranslationsAboutPageIt aboutPage = _TranslationsAboutPageIt._(_root);
	@override late final _TranslationsColorsIt colors = _TranslationsColorsIt._(_root);
	@override late final _TranslationsMenusIt menus = _TranslationsMenusIt._(_root);
	@override late final _TranslationsButtonsIt buttons = _TranslationsButtonsIt._(_root);
	@override late final _TranslationsDialogsIt dialogs = _TranslationsDialogsIt._(_root);
	@override Map<String, String> get locales => {
		'en': 'English',
		'it': 'Italian',
		'zh': '中文',
	};
}

// Path: homePage
class _TranslationsHomePageIt extends TranslationsHomePageEn {
	_TranslationsHomePageIt._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get appPreview => 'ATTENZIONE: Versione di sviluppo, basata automaticamente su ogni commit';
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
	@override String get fontLabelDescription => 'Alcune lingue non supportano i font personalizzati';
	@override String get fontValidator => 'Seleziona un font.';
	@override String get fontSizeLabel => 'Dimensione del font';
	@override String get textGapLabel => 'Spaziatura del testo';
	@override String get textGapDescription => 'La spaziatura tra il testo in ogni riga di testo';
	@override String get rowGapLabel => 'Interlinea';
	@override String get rowGapDescription => 'La spaziatura tra ogni riga di testo';
	@override String get dragging => 'Trascinamento';
	@override String get cancelDrag => 'Trascinamento annullato';
	@override String limitValidator({required Object maxImages, required Object lastImages}) => 'Supporta fino a ${maxImages} immagini, puoi anche caricare ${lastImages} immagini.';
	@override String get formatValidator => 'Supportare solo i formati PNG e JPEG';
	@override String get preview => 'Anteprima';
	@override String get save => 'Salva';
	@override String get savedSuccess => 'Salvataggio riuscito';
	@override String get savedFailure => 'Impossibile salvare l\'immagine(i)';
	@override String saveInfo({required Object succeedNum, required Object failedNum}) => 'Sono state salvate ${succeedNum} l\'immagine(i) e non è stato possibile salvare ${failedNum} l\'immagine(i).';
	@override String get appNoUpdates => 'L\'app è aggiornata.';
	@override String get backgroundCheckingStopped => 'Background checking stopped';
	@override String backgroundCheckingAvailable({required Object latestVersion}) => 'Background check: Update ${latestVersion} available!';
	@override String backgroundCheckingStarted({required Object seconds}) => 'Background checking started (every ${seconds}s)';
}

// Path: aboutPage
class _TranslationsAboutPageIt extends TranslationsAboutPageEn {
	_TranslationsAboutPageIt._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String version({required Object version, required Object buildNumber}) => 'Versione ${version}(${buildNumber})';
	@override String copyright({required Object year, required Object appName}) => 'Copyright © ${year} ${appName}. Tutti i diritti riservati.';
	@override String get slogan => 'Le tue foto, la tua firma.';
	@override String get readme => 'Introduzione del progetto';
	@override String get appLicense => 'Licenza di applicazione';
	@override String get changelog => 'Changelog';
	@override String get thirdPartyLicense => 'Licenze di terze parti';
}

// Path: colors
class _TranslationsColorsIt extends TranslationsColorsEn {
	_TranslationsColorsIt._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get white => 'Bianco';
	@override String get grey => 'Grigio';
	@override String get black => 'Nero';
	@override String get red => 'Rosso';
	@override String get orange => 'Arancione';
	@override String get blue => 'Blu';
}

// Path: menus
class _TranslationsMenusIt extends TranslationsMenusEn {
	_TranslationsMenusIt._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String about({required Object appName}) => 'Di ${appName}';
	@override String hide({required Object appName}) => 'Nascondere ${appName}';
	@override String get hideOthers => 'Nascondere gli altri';
	@override String get showAll => 'Mostra tutto';
	@override String exit({required Object appName}) => 'Esentato ${appName}';
	@override String get help => 'Aiuto';
	@override String get support => 'Supporto';
	@override String get userAgreement => 'Accordo utente';
	@override String get privacy => 'Politica sulla riservatezza';
	@override String get updates => 'Aggiornamenti';
}

// Path: buttons
class _TranslationsButtonsIt extends TranslationsButtonsEn {
	_TranslationsButtonsIt._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get agree => 'Accetto';
	@override String get cancel => 'Annulla';
	@override String get ignore => 'Ignora';
	@override String get turnOn => 'Accendi';
}

// Path: dialogs
class _TranslationsDialogsIt extends TranslationsDialogsEn {
	_TranslationsDialogsIt._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get selectColor => 'Seleziona un colore';
	@override String get selectFont => 'Seleziona un carattere';
	@override late final _TranslationsDialogsExitConfirmIt exitConfirm = _TranslationsDialogsExitConfirmIt._(_root);
	@override late final _TranslationsDialogsPermissionsIt permissions = _TranslationsDialogsPermissionsIt._(_root);
	@override late final _TranslationsDialogsLicenseDialogIt licenseDialog = _TranslationsDialogsLicenseDialogIt._(_root);
	@override late final _TranslationsDialogsSettingsDialogIt settingsDialog = _TranslationsDialogsSettingsDialogIt._(_root);
}

// Path: dialogs.exitConfirm
class _TranslationsDialogsExitConfirmIt extends TranslationsDialogsExitConfirmEn {
	_TranslationsDialogsExitConfirmIt._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get exit => 'Uscita';
	@override String get cancel => 'Annulla';
	@override String get title => 'Chiudi conferma';
	@override String get description => 'Sei sicuro di voler chiudere questa finestra?';
}

// Path: dialogs.permissions
class _TranslationsDialogsPermissionsIt extends TranslationsDialogsPermissionsEn {
	_TranslationsDialogsPermissionsIt._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsDialogsPermissionsPhotosIt photos = _TranslationsDialogsPermissionsPhotosIt._(_root);
	@override late final _TranslationsDialogsPermissionsStorageIt storage = _TranslationsDialogsPermissionsStorageIt._(_root);
}

// Path: dialogs.licenseDialog
class _TranslationsDialogsLicenseDialogIt extends TranslationsDialogsLicenseDialogEn {
	_TranslationsDialogsLicenseDialogIt._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get licenseDialogTitle => 'Termini e Condizioni';
	@override String licenseDialogContentContent({required Object appName}) => 'La protezione della privacy e delle informazioni personali degli utenti è un principio fondamentale di ${appName}.';
	@override String get licenseDialogContentTip => 'Di seguito è riportato l\'elenco delle autorizzazioni richieste da questa APP:';
	@override String get licenseDialogContentPrefix => 'Prima di utilizzare i servizi di questa APP, ti preghiamo di leggere attentamente e accettare il ';
	@override String get licenseDialogContentUserAgreement => 'Contratto d\'uso';
	@override String get licenseDialogContentAnd => ' e ';
	@override String get licenseDialogContentPrivacyPolicy => 'L\'accordo sulla privacy';
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

// Path: dialogs.settingsDialog
class _TranslationsDialogsSettingsDialogIt extends TranslationsDialogsSettingsDialogEn {
	_TranslationsDialogsSettingsDialogIt._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get settings => 'Impostazioni';
	@override String get languages => 'Lingue';
	@override late final _TranslationsDialogsSettingsDialogThemesIt themes = _TranslationsDialogsSettingsDialogThemesIt._(_root);
	@override String get themesDescription => 'Dopo averlo attivato, la modalità scura verrà attivata o disattivata in base al sistema';
}

// Path: dialogs.permissions.photos
class _TranslationsDialogsPermissionsPhotosIt extends TranslationsDialogsPermissionsPhotosEn {
	_TranslationsDialogsPermissionsPhotosIt._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Consenti l\'accesso al tuo album';
	@override String description({required Object appName}) => 'Vai alle Impostazioni del tuo telefono per concedere a ${appName} l\'autorizzazione a visitare il tuo album.';
}

// Path: dialogs.permissions.storage
class _TranslationsDialogsPermissionsStorageIt extends TranslationsDialogsPermissionsStorageEn {
	_TranslationsDialogsPermissionsStorageIt._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Consenti l\'accesso al tuo archivio';
	@override String description({required Object appName}) => 'Accedi alle Impostazioni del tuo telefono per concedere a ${appName} l\'autorizzazione ad accedere al tuo archivio.';
}

// Path: dialogs.settingsDialog.themes
class _TranslationsDialogsSettingsDialogThemesIt extends TranslationsDialogsSettingsDialogThemesEn {
	_TranslationsDialogsSettingsDialogThemesIt._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get manual => 'Modalità manuale';
	@override String get system => 'Modalità automatica';
	@override String get dark => 'Modalità scura';
	@override String get light => 'Modalità chiara';
}

/// The flat map containing all translations for locale <it>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on TranslationsIt {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'appName' => ({required Flavor flavor}) { switch (flavor) { case Flavor.free: return 'PicGuard'; case Flavor.pro: return 'PicGuard Pro'; } }, 
			'homePage.appPreview' => 'ATTENZIONE: Versione di sviluppo, basata automaticamente su ogni commit',
			'homePage.imageDescription' => 'Si prega di caricare le immagini.',
			'homePage.description' => 'Questa app non caricherà alcuna immagine sul server, tutte le operazioni vengono completate localmente',
			'homePage.textLabel' => 'Testo',
			'homePage.textLabelDescription' => 'Il testo verrà aggiunto all\'immagine come filigrana',
			'homePage.textValidator' => 'Inserisci il testo.',
			'homePage.textInput' => 'Questo certificato è utilizzato solo per la gestione di xx attività e non è valido per altri scopi.',
			'homePage.colorLabel' => 'Colore',
			'homePage.colorValidator' => 'Seleziona un colore.',
			'homePage.opacityLabel' => 'Opacità',
			'homePage.fontLabel' => 'Font',
			'homePage.fontLabelDescription' => 'Alcune lingue non supportano i font personalizzati',
			'homePage.fontValidator' => 'Seleziona un font.',
			'homePage.fontSizeLabel' => 'Dimensione del font',
			'homePage.textGapLabel' => 'Spaziatura del testo',
			'homePage.textGapDescription' => 'La spaziatura tra il testo in ogni riga di testo',
			'homePage.rowGapLabel' => 'Interlinea',
			'homePage.rowGapDescription' => 'La spaziatura tra ogni riga di testo',
			'homePage.dragging' => 'Trascinamento',
			'homePage.cancelDrag' => 'Trascinamento annullato',
			'homePage.limitValidator' => ({required Object maxImages, required Object lastImages}) => 'Supporta fino a ${maxImages} immagini, puoi anche caricare ${lastImages} immagini.',
			'homePage.formatValidator' => 'Supportare solo i formati PNG e JPEG',
			'homePage.preview' => 'Anteprima',
			'homePage.save' => 'Salva',
			'homePage.savedSuccess' => 'Salvataggio riuscito',
			'homePage.savedFailure' => 'Impossibile salvare l\'immagine(i)',
			'homePage.saveInfo' => ({required Object succeedNum, required Object failedNum}) => 'Sono state salvate ${succeedNum} l\'immagine(i) e non è stato possibile salvare ${failedNum} l\'immagine(i).',
			'homePage.appNoUpdates' => 'L\'app è aggiornata.',
			'homePage.backgroundCheckingStopped' => 'Background checking stopped',
			'homePage.backgroundCheckingAvailable' => ({required Object latestVersion}) => 'Background check: Update ${latestVersion} available!',
			'homePage.backgroundCheckingStarted' => ({required Object seconds}) => 'Background checking started (every ${seconds}s)',
			'aboutPage.version' => ({required Object version, required Object buildNumber}) => 'Versione ${version}(${buildNumber})',
			'aboutPage.copyright' => ({required Object year, required Object appName}) => 'Copyright © ${year} ${appName}. Tutti i diritti riservati.',
			'aboutPage.slogan' => 'Le tue foto, la tua firma.',
			'aboutPage.readme' => 'Introduzione del progetto',
			'aboutPage.appLicense' => 'Licenza di applicazione',
			'aboutPage.changelog' => 'Changelog',
			'aboutPage.thirdPartyLicense' => 'Licenze di terze parti',
			'colors.white' => 'Bianco',
			'colors.grey' => 'Grigio',
			'colors.black' => 'Nero',
			'colors.red' => 'Rosso',
			'colors.orange' => 'Arancione',
			'colors.blue' => 'Blu',
			'menus.about' => ({required Object appName}) => 'Di ${appName}',
			'menus.hide' => ({required Object appName}) => 'Nascondere ${appName}',
			'menus.hideOthers' => 'Nascondere gli altri',
			'menus.showAll' => 'Mostra tutto',
			'menus.exit' => ({required Object appName}) => 'Esentato ${appName}',
			'menus.help' => 'Aiuto',
			'menus.support' => 'Supporto',
			'menus.userAgreement' => 'Accordo utente',
			'menus.privacy' => 'Politica sulla riservatezza',
			'menus.updates' => 'Aggiornamenti',
			'buttons.agree' => 'Accetto',
			'buttons.cancel' => 'Annulla',
			'buttons.ignore' => 'Ignora',
			'buttons.turnOn' => 'Accendi',
			'dialogs.selectColor' => 'Seleziona un colore',
			'dialogs.selectFont' => 'Seleziona un carattere',
			'dialogs.exitConfirm.exit' => 'Uscita',
			'dialogs.exitConfirm.cancel' => 'Annulla',
			'dialogs.exitConfirm.title' => 'Chiudi conferma',
			'dialogs.exitConfirm.description' => 'Sei sicuro di voler chiudere questa finestra?',
			'dialogs.permissions.photos.title' => 'Consenti l\'accesso al tuo album',
			'dialogs.permissions.photos.description' => ({required Object appName}) => 'Vai alle Impostazioni del tuo telefono per concedere a ${appName} l\'autorizzazione a visitare il tuo album.',
			'dialogs.permissions.storage.title' => 'Consenti l\'accesso al tuo archivio',
			'dialogs.permissions.storage.description' => ({required Object appName}) => 'Accedi alle Impostazioni del tuo telefono per concedere a ${appName} l\'autorizzazione ad accedere al tuo archivio.',
			'dialogs.licenseDialog.licenseDialogTitle' => 'Termini e Condizioni',
			'dialogs.licenseDialog.licenseDialogContentContent' => ({required Object appName}) => 'La protezione della privacy e delle informazioni personali degli utenti è un principio fondamentale di ${appName}.',
			'dialogs.licenseDialog.licenseDialogContentTip' => 'Di seguito è riportato l\'elenco delle autorizzazioni richieste da questa APP:',
			'dialogs.licenseDialog.licenseDialogContentPrefix' => 'Prima di utilizzare i servizi di questa APP, ti preghiamo di leggere attentamente e accettare il ',
			'dialogs.licenseDialog.licenseDialogContentUserAgreement' => 'Contratto d\'uso',
			'dialogs.licenseDialog.licenseDialogContentAnd' => ' e ',
			'dialogs.licenseDialog.licenseDialogContentPrivacyPolicy' => 'L\'accordo sulla privacy',
			'dialogs.licenseDialog.licenseDialogContentSuffix' => ', inizia a utilizzare i nostri servizi dopo aver accettato tutti i termini.',
			'dialogs.licenseDialog.iosPermissions.0' => ({required Object appName}) => 'Per aggiungere una filigrana alle tue immagini, ${appName} deve accedere alle tue foto. (NSPhotoLibraryUsageDescription)',
			'dialogs.licenseDialog.androidPermissions.0' => ({required Object appName}) => 'Per poter utilizzare il servizio Sentry, ${appName} deve avere accesso a Internet. (android.permission.INTERNET)',
			'dialogs.licenseDialog.androidPermissions.1' => ({required Object appName}) => 'Per filigranare le tue immagini, ${appName} deve accedere al tuo spazio di archiviazione. (android.permission.READ_EXTERNAL_STORAGE)',
			'dialogs.licenseDialog.androidPermissions.2' => ({required Object appName}) => 'Per poter salvare le immagini, ${appName} deve accedere al tuo spazio di archiviazione. (android.permission.WRITE_EXTERNAL_STORAGE)',
			'dialogs.licenseDialog.androidPermissions.3' => ({required Object appName}) => 'Per aggiungere una filigrana alle tue immagini, ${appName} deve accedere alle tue foto. (android.permission.READ_MEDIA_IMAGES)',
			'dialogs.settingsDialog.settings' => 'Impostazioni',
			'dialogs.settingsDialog.languages' => 'Lingue',
			'dialogs.settingsDialog.themes.manual' => 'Modalità manuale',
			'dialogs.settingsDialog.themes.system' => 'Modalità automatica',
			'dialogs.settingsDialog.themes.dark' => 'Modalità scura',
			'dialogs.settingsDialog.themes.light' => 'Modalità chiara',
			'dialogs.settingsDialog.themesDescription' => 'Dopo averlo attivato, la modalità scura verrà attivata o disattivata in base al sistema',
			'locales.en' => 'English',
			'locales.it' => 'Italian',
			'locales.zh' => '中文',
			_ => null,
		};
	}
}
