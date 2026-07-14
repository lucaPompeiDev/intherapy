import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_it.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('it')
  ];

  /// No description provided for @pageTitle.
  ///
  /// In en, this message translates to:
  /// **'Psicoterapia e Neuropsicologia a Poggio Mirteto | Studio Colantoni'**
  String get pageTitle;

  /// No description provided for @metaDescription.
  ///
  /// In en, this message translates to:
  /// **'Scopri il supporto psicologico professionale dello Studio Colantoni: terapia cognitivo-comportamentale, EMDR e neuropsicologia a Poggio Mirteto e dintorni.'**
  String get metaDescription;

  /// No description provided for @studioNameExtended.
  ///
  /// In en, this message translates to:
  /// **'Studio di psicoterapia e neuropsicologia Colantoni'**
  String get studioNameExtended;

  /// No description provided for @menuHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get menuHome;

  /// No description provided for @menuTherapies.
  ///
  /// In en, this message translates to:
  /// **'Terapie'**
  String get menuTherapies;

  /// No description provided for @menuCognitiveBehavioral.
  ///
  /// In en, this message translates to:
  /// **'Cognitivo Comportamentale'**
  String get menuCognitiveBehavioral;

  /// No description provided for @menuClinicalNeuropsychology.
  ///
  /// In en, this message translates to:
  /// **'Neuropsicologia Clinica'**
  String get menuClinicalNeuropsychology;

  /// No description provided for @menuEmdrTherapy.
  ///
  /// In en, this message translates to:
  /// **'Terapia EMDR'**
  String get menuEmdrTherapy;

  /// No description provided for @menuPsychologyPsychotherapy.
  ///
  /// In en, this message translates to:
  /// **'Psicologia e Psicoterapia'**
  String get menuPsychologyPsychotherapy;

  /// No description provided for @menuInformativeMeetings.
  ///
  /// In en, this message translates to:
  /// **'Incontri informativi'**
  String get menuInformativeMeetings;

  /// No description provided for @menuBookServices.
  ///
  /// In en, this message translates to:
  /// **'Prenota Servizi'**
  String get menuBookServices;

  /// No description provided for @menuTeam.
  ///
  /// In en, this message translates to:
  /// **'Team'**
  String get menuTeam;

  /// No description provided for @menuKatiaColantoni.
  ///
  /// In en, this message translates to:
  /// **'Katia Colantoni'**
  String get menuKatiaColantoni;

  /// No description provided for @menuWholeTeam.
  ///
  /// In en, this message translates to:
  /// **'Tutto il team'**
  String get menuWholeTeam;

  /// No description provided for @menuBlog.
  ///
  /// In en, this message translates to:
  /// **'Blog'**
  String get menuBlog;

  /// No description provided for @menuKatiaBlog.
  ///
  /// In en, this message translates to:
  /// **'Blog di Katia Colantoni'**
  String get menuKatiaBlog;

  /// No description provided for @menuCollaboratorsBlog.
  ///
  /// In en, this message translates to:
  /// **'Blog delle collaboratrici'**
  String get menuCollaboratorsBlog;

  /// No description provided for @mainTitle.
  ///
  /// In en, this message translates to:
  /// **'Studio di Psicoterapia e Neuropsicologia Colantoni'**
  String get mainTitle;

  /// No description provided for @curatedByLabel.
  ///
  /// In en, this message translates to:
  /// **'A Cura Della Dottoressa'**
  String get curatedByLabel;

  /// No description provided for @founderName.
  ///
  /// In en, this message translates to:
  /// **'Katia Colantoni'**
  String get founderName;

  /// No description provided for @bookServicesOnline.
  ///
  /// In en, this message translates to:
  /// **'Prenota servizi online'**
  String get bookServicesOnline;

  /// No description provided for @writeOnWhatsApp.
  ///
  /// In en, this message translates to:
  /// **'Scrivici su WhatsApp'**
  String get writeOnWhatsApp;

  /// No description provided for @sloganTitle.
  ///
  /// In en, this message translates to:
  /// **'Ascoltare, Sostenere, Curare'**
  String get sloganTitle;

  /// No description provided for @sloganSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Crescere è un\'avventura per i bambini, una sfida per gli adolescenti, un\'opportunità per gli adulti'**
  String get sloganSubtitle;

  /// No description provided for @quotePastPresent.
  ///
  /// In en, this message translates to:
  /// **'Non possiamo cambiare il nostro passato, ma possiamo creare la consapevolezza che ci permette di vivere meglio il presente e scegliere il nostro futuro.'**
  String get quotePastPresent;

  /// No description provided for @quotePastWounds.
  ///
  /// In en, this message translates to:
  /// **'Non permettere che le ferite del passato ti trasformino in qualcuno che non sei.'**
  String get quotePastWounds;

  /// No description provided for @whatWeDo.
  ///
  /// In en, this message translates to:
  /// **'Cosa facciamo'**
  String get whatWeDo;

  /// No description provided for @whatWeDoDescription.
  ///
  /// In en, this message translates to:
  /// **'Il nostro obiettivo è prevenire, diagnosticare, trattare e abilitare i disturbi comuni nell\'età evolutiva e adulta; fornendo ipotesi diagnostiche e percorsi terapeutici, e lavorando in sinergia con famiglie e scuole.'**
  String get whatWeDoDescription;

  /// No description provided for @cardAssessmentTitle.
  ///
  /// In en, this message translates to:
  /// **'Valutazione'**
  String get cardAssessmentTitle;

  /// No description provided for @cardAssessmentDescription.
  ///
  /// In en, this message translates to:
  /// **'Effettuiamo valutazioni neuropsicologiche finalizzate a fotografare il funzionamento attuale della persona, evidenziando risorse e fragilità (cognitive, emotive, relazionali e comportamentali).'**
  String get cardAssessmentDescription;

  /// No description provided for @cardTherapeuticProjectTitle.
  ///
  /// In en, this message translates to:
  /// **'Progetto Terapeutico'**
  String get cardTherapeuticProjectTitle;

  /// No description provided for @cardTherapeuticProjectDescription.
  ///
  /// In en, this message translates to:
  /// **'A seguito di quanto emerso dalla valutazione, progettiamo come sarti il percorso terapeutico a misura di persona.'**
  String get cardTherapeuticProjectDescription;

  /// No description provided for @cardPsychotherapySupportTitle.
  ///
  /// In en, this message translates to:
  /// **'Psicoterapia e Sostegno Psicologico'**
  String get cardPsychotherapySupportTitle;

  /// No description provided for @cardPsychotherapySupportDescription.
  ///
  /// In en, this message translates to:
  /// **'Rilasciamo valutazioni funzionali e cognitive dei Disturbi dell\'Apprendimento e del Neurosviluppo e valutazioni Psicopatologiche secondo il DSM 5.'**
  String get cardPsychotherapySupportDescription;

  /// No description provided for @cardTeamWorkTitle.
  ///
  /// In en, this message translates to:
  /// **'Lavoro Di Equipe'**
  String get cardTeamWorkTitle;

  /// No description provided for @cardTeamWorkDescription.
  ///
  /// In en, this message translates to:
  /// **'Ci confrontiamo tra colleghe per avere una visione globale della persona, ciascuna di noi grazie alla propria specifica formazione e alle proprie competenze apporterà un valore aggiunto alla cura della persona.'**
  String get cardTeamWorkDescription;

  /// No description provided for @cardInformativeMeetingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Incontri Informativi'**
  String get cardInformativeMeetingsTitle;

  /// No description provided for @cardInformativeMeetingsDescription.
  ///
  /// In en, this message translates to:
  /// **'Effettuiamo numerosi incontri informativi finalizzati a spargere conoscenza e fornire aiuti e servizi alla persona.'**
  String get cardInformativeMeetingsDescription;

  /// No description provided for @ourService.
  ///
  /// In en, this message translates to:
  /// **'I nostri servizi'**
  String get ourService;

  /// No description provided for @description.
  ///
  /// In en, this message translates to:
  /// **'Esplora i nostri servizi e il nostro team per comprendere meglio come possiamo esserti utili. Scrivici per qualsiasi dubbio o per semplici informazioni, ti risponderemo il prima possibile.'**
  String get description;

  /// No description provided for @bookServicesButton.
  ///
  /// In en, this message translates to:
  /// **'Prenota i nostri servizi'**
  String get bookServicesButton;

  /// No description provided for @writeOnWhatsAppButton.
  ///
  /// In en, this message translates to:
  /// **'Scrivici su Whatsapp'**
  String get writeOnWhatsAppButton;

  /// No description provided for @intervetionArea.
  ///
  /// In en, this message translates to:
  /// **'Aree Di Intervento'**
  String get intervetionArea;

  /// No description provided for @intervetionAreaDescription.
  ///
  /// In en, this message translates to:
  /// **'Scopri tutte le aree di intervento del nostro studio per capire se facciamo al caso tuo'**
  String get intervetionAreaDescription;

  /// No description provided for @cognitiveBehavioralTitle.
  ///
  /// In en, this message translates to:
  /// **'Psicoterapia Cognitivo Comportamentale (e altri approcci)'**
  String get cognitiveBehavioralTitle;

  /// No description provided for @cognitiveBehavioralDescription.
  ///
  /// In en, this message translates to:
  /// **'Ti aiutiamo tramite tecniche psicologiche cognitivo comportamentali a comprendere i tuoi processi di pensiero e il tuo funzionamento, e a comprendere e regolare il tuo comportamento e le tue emozioni.'**
  String get cognitiveBehavioralDescription;

  /// No description provided for @clinicalNeuropsychologyTitle.
  ///
  /// In en, this message translates to:
  /// **'Neuropsicologia Clinica'**
  String get clinicalNeuropsychologyTitle;

  /// No description provided for @clinicalNeuropsychologyDescription.
  ///
  /// In en, this message translates to:
  /// **'Effettuiamo valutazione e abilitazione/riabilitazione delle funzioni cognitive e neuropsicologiche per l\'adulto neurologico e per il bambino con difficoltà di sviluppo.'**
  String get clinicalNeuropsychologyDescription;

  /// No description provided for @psychologyPsychotherapyTitle.
  ///
  /// In en, this message translates to:
  /// **'Psicologia e Psicoterapia'**
  String get psychologyPsychotherapyTitle;

  /// No description provided for @psychologyPsychotherapyDescription.
  ///
  /// In en, this message translates to:
  /// **'E\' una terapia interpersonale che si basa sull\'ascolto attivo, un percorso introspettivo che ha lo scopo di comprendere e di far acquisire consapevolezza alla persona del proprio funzionamento.'**
  String get psychologyPsychotherapyDescription;

  /// No description provided for @emdrTherapyTitle.
  ///
  /// In en, this message translates to:
  /// **'Terapia EMDR'**
  String get emdrTherapyTitle;

  /// No description provided for @emdrTherapyDescription.
  ///
  /// In en, this message translates to:
  /// **'L\'EMDR (dall\'inglese Eye Movement Desensitization and Reprocessing, Desensibilizzazione e rielaborazione attraverso i movimenti oculari) è un approccio terapeutico validato scientificamente e finalizzato all\'elaborazione di esperienze traumatiche e stressanti'**
  String get emdrTherapyDescription;

  /// No description provided for @discoverMoreLabel.
  ///
  /// In en, this message translates to:
  /// **'Scopri di più'**
  String get discoverMoreLabel;

  /// No description provided for @doctorTitleLabel.
  ///
  /// In en, this message translates to:
  /// **'Dottoressa'**
  String get doctorTitleLabel;

  /// No description provided for @doctorName.
  ///
  /// In en, this message translates to:
  /// **'Katia Colantoni'**
  String get doctorName;

  /// No description provided for @doctorRole.
  ///
  /// In en, this message translates to:
  /// **'Responsabile dello studio e supervisore dei progetti di intervento'**
  String get doctorRole;

  /// No description provided for @qualificationPsychologist.
  ///
  /// In en, this message translates to:
  /// **'Psicologa'**
  String get qualificationPsychologist;

  /// No description provided for @qualificationCognitiveBehavioralTherapist.
  ///
  /// In en, this message translates to:
  /// **'Psicoterapeuta Cognitivo Comportamentale'**
  String get qualificationCognitiveBehavioralTherapist;

  /// No description provided for @qualificationClinicalNeuropsychology.
  ///
  /// In en, this message translates to:
  /// **'Perfezionata in Neuropsicologia Clinica del bambino, adulto e anziano'**
  String get qualificationClinicalNeuropsychology;

  /// No description provided for @qualificationEmdrTherapist.
  ///
  /// In en, this message translates to:
  /// **'Terapeuta EMDR Adulti e Bambini'**
  String get qualificationEmdrTherapist;

  /// No description provided for @qualificationNutritionSpecialist.
  ///
  /// In en, this message translates to:
  /// **'Perfezionata in probiotica e nutrizione'**
  String get qualificationNutritionSpecialist;

  /// No description provided for @qualificationFeuersteinMethod.
  ///
  /// In en, this message translates to:
  /// **'Metodo Feurstein'**
  String get qualificationFeuersteinMethod;

  /// No description provided for @qualificationSandtrayTherapy.
  ///
  /// In en, this message translates to:
  /// **'Perfezionata in Sandtray Therapy'**
  String get qualificationSandtrayTherapy;

  /// No description provided for @qualificationFlashTechnique.
  ///
  /// In en, this message translates to:
  /// **'Perfezionata in Flash Technique'**
  String get qualificationFlashTechnique;

  /// No description provided for @discoverMoreAboutDoctorLabel.
  ///
  /// In en, this message translates to:
  /// **'Scopri di più sulla Dott.ssa'**
  String get discoverMoreAboutDoctorLabel;

  /// No description provided for @sectionTitle.
  ///
  /// In en, this message translates to:
  /// **'Cosa dicono di noi'**
  String get sectionTitle;

  /// No description provided for @sectionSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Esplora le esperienze dei nostri clienti'**
  String get sectionSubtitle;

  /// No description provided for @katiaReviewsTitle.
  ///
  /// In en, this message translates to:
  /// **'Recensioni di Katia'**
  String get katiaReviewsTitle;

  /// No description provided for @studioReviewsTitle.
  ///
  /// In en, this message translates to:
  /// **'Recensioni dello studio'**
  String get studioReviewsTitle;

  /// No description provided for @title.
  ///
  /// In en, this message translates to:
  /// **'Incontri Informativi'**
  String get title;

  /// No description provided for @subtitle.
  ///
  /// In en, this message translates to:
  /// **'Scopri gli incontri in arrivo e consulta i contenuti degli eventi passati.'**
  String get subtitle;

  /// No description provided for @noResultsFoundText.
  ///
  /// In en, this message translates to:
  /// **'No blogs found'**
  String get noResultsFoundText;

  /// No description provided for @discoverMoreAboutMeetingsLabel.
  ///
  /// In en, this message translates to:
  /// **'Scopri di più sugli Incontri Informativi'**
  String get discoverMoreAboutMeetingsLabel;

  /// No description provided for @sectionLabel.
  ///
  /// In en, this message translates to:
  /// **'CONTATTACI | STUDIO COLANTONI'**
  String get sectionLabel;

  /// No description provided for @sectionDescription.
  ///
  /// In en, this message translates to:
  /// **'Se hai domande o vuoi richiedere informazioni puoi compilare il Modulo qui sotto!'**
  String get sectionDescription;

  /// No description provided for @fullNameFieldLabel.
  ///
  /// In en, this message translates to:
  /// **'Nome e Cognome'**
  String get fullNameFieldLabel;

  /// No description provided for @emailFieldLabel.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get emailFieldLabel;

  /// No description provided for @phoneFieldLabel.
  ///
  /// In en, this message translates to:
  /// **'Cellulare'**
  String get phoneFieldLabel;

  /// No description provided for @messageFieldLabel.
  ///
  /// In en, this message translates to:
  /// **'Messaggio'**
  String get messageFieldLabel;

  /// No description provided for @selectServicesFieldLabel.
  ///
  /// In en, this message translates to:
  /// **'Seleziona uno o più Servizi'**
  String get selectServicesFieldLabel;

  /// No description provided for @selectServicePlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Seleziona il Servizio'**
  String get selectServicePlaceholder;

  /// No description provided for @smsConsentText.
  ///
  /// In en, this message translates to:
  /// **'I Consent to Receive SMS Notifications, Alerts & Occasional Marketing Communication from company. Message frequency varies.'**
  String get smsConsentText;

  /// No description provided for @submitButtonLabel.
  ///
  /// In en, this message translates to:
  /// **'Invia richiesta'**
  String get submitButtonLabel;

  /// No description provided for @privacyPolicyLink.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyPolicyLink;

  /// No description provided for @termsOfServiceLink.
  ///
  /// In en, this message translates to:
  /// **'Terms of Service'**
  String get termsOfServiceLink;

  /// No description provided for @quickLinksLabel.
  ///
  /// In en, this message translates to:
  /// **'Collegamenti Rapidi'**
  String get quickLinksLabel;

  /// No description provided for @quickLinkHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get quickLinkHome;

  /// No description provided for @quickLinkServices.
  ///
  /// In en, this message translates to:
  /// **'Servizi'**
  String get quickLinkServices;

  /// No description provided for @quickLinkAboutUs.
  ///
  /// In en, this message translates to:
  /// **'Chi siamo'**
  String get quickLinkAboutUs;

  /// No description provided for @quickLinkWhereWeAre.
  ///
  /// In en, this message translates to:
  /// **'Dove siamo'**
  String get quickLinkWhereWeAre;

  /// No description provided for @quickLinkBlog.
  ///
  /// In en, this message translates to:
  /// **'Blog'**
  String get quickLinkBlog;

  /// No description provided for @quickLinkKatiaBlog.
  ///
  /// In en, this message translates to:
  /// **'Blog di Katia Colantoni'**
  String get quickLinkKatiaBlog;

  /// No description provided for @quickLinkContactUs.
  ///
  /// In en, this message translates to:
  /// **'Contattaci'**
  String get quickLinkContactUs;

  /// No description provided for @legalLinksLabel.
  ///
  /// In en, this message translates to:
  /// **'Link Legali'**
  String get legalLinksLabel;

  /// No description provided for @legalPrivacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get legalPrivacyPolicy;

  /// No description provided for @legalTermsAndConditions.
  ///
  /// In en, this message translates to:
  /// **'Terms and Conditions'**
  String get legalTermsAndConditions;

  /// No description provided for @legalPrivacyCookiePolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy and Cookie Policy'**
  String get legalPrivacyCookiePolicy;

  /// No description provided for @infoLabel.
  ///
  /// In en, this message translates to:
  /// **'Informazioni'**
  String get infoLabel;

  /// No description provided for @whatsAppNumber.
  ///
  /// In en, this message translates to:
  /// **'349 167 2298'**
  String get whatsAppNumber;

  /// No description provided for @address.
  ///
  /// In en, this message translates to:
  /// **'Via Ferruti, 60, 02047 Poggio Mirteto / Montopoli in Sabina (RI)'**
  String get address;

  /// No description provided for @copyrightText.
  ///
  /// In en, this message translates to:
  /// **'Studiodipsicoterapiaeneuropsicologia Colantoni| Copyright 2026 . All rights reserved'**
  String get copyrightText;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'it'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'it': return AppLocalizationsIt();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
