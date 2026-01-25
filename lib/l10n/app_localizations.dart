import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_id.dart';
import 'app_localizations_ja.dart';
import 'app_localizations_ko.dart';
import 'app_localizations_zh.dart';

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
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

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
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('de'),
    Locale('en'),
    Locale('id'),
    Locale('ja'),
    Locale('ko'),
    Locale('zh'),
  ];

  /// No description provided for @appSetting.
  ///
  /// In en, this message translates to:
  /// **'App Settings'**
  String get appSetting;

  /// No description provided for @darkmode.
  ///
  /// In en, this message translates to:
  /// **'Dark Mode'**
  String get darkmode;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @gunungRinjani.
  ///
  /// In en, this message translates to:
  /// **'Mount Rinjani'**
  String get gunungRinjani;

  /// No description provided for @openTrip.
  ///
  /// In en, this message translates to:
  /// **'Open Trip'**
  String get openTrip;

  /// No description provided for @height.
  ///
  /// In en, this message translates to:
  /// **'Height'**
  String get height;

  /// No description provided for @heightValue.
  ///
  /// In en, this message translates to:
  /// **'3726 masl'**
  String get heightValue;

  /// No description provided for @temp.
  ///
  /// In en, this message translates to:
  /// **'Temp'**
  String get temp;

  /// No description provided for @weather.
  ///
  /// In en, this message translates to:
  /// **'Weather'**
  String get weather;

  /// No description provided for @sunny.
  ///
  /// In en, this message translates to:
  /// **'Sunny'**
  String get sunny;

  /// No description provided for @cloudy.
  ///
  /// In en, this message translates to:
  /// **'Cloudy'**
  String get cloudy;

  /// No description provided for @rain.
  ///
  /// In en, this message translates to:
  /// **'Rain'**
  String get rain;

  /// No description provided for @clear.
  ///
  /// In en, this message translates to:
  /// **'Clear'**
  String get clear;

  /// No description provided for @route.
  ///
  /// In en, this message translates to:
  /// **'Route'**
  String get route;

  /// No description provided for @routeValue.
  ///
  /// In en, this message translates to:
  /// **'Senaru'**
  String get routeValue;

  /// No description provided for @aboutDestination.
  ///
  /// In en, this message translates to:
  /// **'About Destination'**
  String get aboutDestination;

  /// No description provided for @description.
  ///
  /// In en, this message translates to:
  /// **'Mount Rinjani trekking via Senaru is a favorite route to enjoy the view of Lake Segara Anak from the crater rim. This path passes through dense tropical rainforests.'**
  String get description;

  /// No description provided for @gallery.
  ///
  /// In en, this message translates to:
  /// **'Moment Gallery'**
  String get gallery;

  /// No description provided for @gallerySub.
  ///
  /// In en, this message translates to:
  /// **'Capture and immortalize your precious moments'**
  String get gallerySub;

  /// No description provided for @locationAndRoute.
  ///
  /// In en, this message translates to:
  /// **'Location & Route'**
  String get locationAndRoute;

  /// No description provided for @locationSub.
  ///
  /// In en, this message translates to:
  /// **'Automatic route from your location to Senaru Basecamp.'**
  String get locationSub;

  /// No description provided for @reviews.
  ///
  /// In en, this message translates to:
  /// **'What people say about this destination'**
  String get reviews;

  /// No description provided for @startFrom.
  ///
  /// In en, this message translates to:
  /// **'Starts from'**
  String get startFrom;

  /// No description provided for @price.
  ///
  /// In en, this message translates to:
  /// **'IDR 150K'**
  String get price;

  /// No description provided for @booking.
  ///
  /// In en, this message translates to:
  /// **'Book Now'**
  String get booking;

  /// No description provided for @addData.
  ///
  /// In en, this message translates to:
  /// **'Fill in booking data'**
  String get addData;

  /// No description provided for @addDesc.
  ///
  /// In en, this message translates to:
  /// **'Ensure the data you fill in is valid so we can contact you'**
  String get addDesc;

  /// No description provided for @name.
  ///
  /// In en, this message translates to:
  /// **'Full Name'**
  String get name;

  /// No description provided for @phoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get phoneNumber;

  /// No description provided for @numberVisitor.
  ///
  /// In en, this message translates to:
  /// **'Number of Visitors'**
  String get numberVisitor;

  /// No description provided for @withoutGuide.
  ///
  /// In en, this message translates to:
  /// **'Without Guide'**
  String get withoutGuide;

  /// No description provided for @withGuide.
  ///
  /// In en, this message translates to:
  /// **'With Guide'**
  String get withGuide;

  /// No description provided for @visitors.
  ///
  /// In en, this message translates to:
  /// **'Visitors:'**
  String get visitors;

  /// No description provided for @bill.
  ///
  /// In en, this message translates to:
  /// **'Total Price:'**
  String get bill;

  /// No description provided for @bookNow.
  ///
  /// In en, this message translates to:
  /// **'Book Now'**
  String get bookNow;

  /// No description provided for @showTicket.
  ///
  /// In en, this message translates to:
  /// **'Show this ticket upon arrival'**
  String get showTicket;

  /// No description provided for @backHome.
  ///
  /// In en, this message translates to:
  /// **'Back to Home'**
  String get backHome;

  /// No description provided for @noTicket.
  ///
  /// In en, this message translates to:
  /// **'No tickets booked yet'**
  String get noTicket;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
    'ar',
    'de',
    'en',
    'id',
    'ja',
    'ko',
    'zh',
  ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
    case 'id':
      return AppLocalizationsId();
    case 'ja':
      return AppLocalizationsJa();
    case 'ko':
      return AppLocalizationsKo();
    case 'zh':
      return AppLocalizationsZh();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
