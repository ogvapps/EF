import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';

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
    Locale('es')
  ];

  /// No description provided for @appTitle.
  ///
  /// In es, this message translates to:
  /// **'EF Quest'**
  String get appTitle;

  /// No description provided for @helloUser.
  ///
  /// In es, this message translates to:
  /// **'Hola, {name}'**
  String helloUser(String name);

  /// No description provided for @tusUnidades.
  ///
  /// In es, this message translates to:
  /// **'Tus unidades'**
  String get tusUnidades;

  /// No description provided for @racha.
  ///
  /// In es, this message translates to:
  /// **'Racha'**
  String get racha;

  /// No description provided for @retoDiario.
  ///
  /// In es, this message translates to:
  /// **'Reto diario'**
  String get retoDiario;

  /// No description provided for @sinConexion.
  ///
  /// In es, this message translates to:
  /// **'Sin conexión'**
  String get sinConexion;

  /// No description provided for @explorador.
  ///
  /// In es, this message translates to:
  /// **'Explorador'**
  String get explorador;

  /// No description provided for @errorCargar.
  ///
  /// In es, this message translates to:
  /// **'Error al cargar los datos'**
  String get errorCargar;

  /// No description provided for @reintentar.
  ///
  /// In es, this message translates to:
  /// **'Reintentar'**
  String get reintentar;

  /// No description provided for @noUnidades.
  ///
  /// In es, this message translates to:
  /// **'No hay unidades disponibles'**
  String get noUnidades;

  /// No description provided for @empezar.
  ///
  /// In es, this message translates to:
  /// **'¡Empezar!'**
  String get empezar;

  /// No description provided for @completar.
  ///
  /// In es, this message translates to:
  /// **'Completar'**
  String get completar;

  /// No description provided for @guardar.
  ///
  /// In es, this message translates to:
  /// **'Guardar'**
  String get guardar;

  /// No description provided for @cancelar.
  ///
  /// In es, this message translates to:
  /// **'Cancelar'**
  String get cancelar;

  /// No description provided for @cerrar.
  ///
  /// In es, this message translates to:
  /// **'Cerrar'**
  String get cerrar;

  /// No description provided for @iniciarSesion.
  ///
  /// In es, this message translates to:
  /// **'Iniciar sesión'**
  String get iniciarSesion;

  /// No description provided for @registrarse.
  ///
  /// In es, this message translates to:
  /// **'Registrarse'**
  String get registrarse;

  /// No description provided for @correo.
  ///
  /// In es, this message translates to:
  /// **'Correo electrónico'**
  String get correo;

  /// No description provided for @contrasena.
  ///
  /// In es, this message translates to:
  /// **'Contraseña'**
  String get contrasena;

  /// No description provided for @nombre.
  ///
  /// In es, this message translates to:
  /// **'Nombre'**
  String get nombre;

  /// No description provided for @curso.
  ///
  /// In es, this message translates to:
  /// **'Curso'**
  String get curso;

  /// No description provided for @nivel.
  ///
  /// In es, this message translates to:
  /// **'Nv.{level}'**
  String nivel(int level);

  /// No description provided for @xpInLevel.
  ///
  /// In es, this message translates to:
  /// **'{xp}/{max} XP'**
  String xpInLevel(int xp, int max);

  /// No description provided for @monedas.
  ///
  /// In es, this message translates to:
  /// **'{coins} monedas'**
  String monedas(int coins);

  /// No description provided for @diasRacha.
  ///
  /// In es, this message translates to:
  /// **'{streak} días'**
  String diasRacha(int streak);

  /// No description provided for @progreso.
  ///
  /// In es, this message translates to:
  /// **'Progreso'**
  String get progreso;

  /// No description provided for @avatar.
  ///
  /// In es, this message translates to:
  /// **'Avatar'**
  String get avatar;

  /// No description provided for @mas.
  ///
  /// In es, this message translates to:
  /// **'Más'**
  String get mas;

  /// No description provided for @inicio.
  ///
  /// In es, this message translates to:
  /// **'Inicio'**
  String get inicio;

  /// No description provided for @perfil.
  ///
  /// In es, this message translates to:
  /// **'Perfil'**
  String get perfil;

  /// No description provided for @logros.
  ///
  /// In es, this message translates to:
  /// **'Logros'**
  String get logros;

  /// No description provided for @tienda.
  ///
  /// In es, this message translates to:
  /// **'Tienda'**
  String get tienda;

  /// No description provided for @inventario.
  ///
  /// In es, this message translates to:
  /// **'Inventario'**
  String get inventario;

  /// No description provided for @ranking.
  ///
  /// In es, this message translates to:
  /// **'Ranking'**
  String get ranking;

  /// No description provided for @ajustes.
  ///
  /// In es, this message translates to:
  /// **'Ajustes'**
  String get ajustes;

  /// No description provided for @panelDocente.
  ///
  /// In es, this message translates to:
  /// **'Panel docente'**
  String get panelDocente;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'es'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'es': return AppLocalizationsEs();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
