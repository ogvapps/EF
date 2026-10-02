import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'EF Quest';

  @override
  String helloUser(String name) {
    return 'Hello, $name';
  }

  @override
  String get tusUnidades => 'Your Units';

  @override
  String get racha => 'Streak';

  @override
  String get retoDiario => 'Daily Challenge';

  @override
  String get sinConexion => 'No Connection';

  @override
  String get explorador => 'Explorer';

  @override
  String get errorCargar => 'Error loading data';

  @override
  String get reintentar => 'Retry';

  @override
  String get noUnidades => 'No units available';

  @override
  String get empezar => 'Start!';

  @override
  String get completar => 'Complete';

  @override
  String get guardar => 'Save';

  @override
  String get cancelar => 'Cancel';

  @override
  String get cerrar => 'Close';

  @override
  String get iniciarSesion => 'Log In';

  @override
  String get registrarse => 'Sign Up';

  @override
  String get correo => 'Email';

  @override
  String get contrasena => 'Password';

  @override
  String get nombre => 'Name';

  @override
  String get curso => 'Course';

  @override
  String nivel(int level) {
    return 'Lv.$level';
  }

  @override
  String xpInLevel(int xp, int max) {
    return '$xp/$max XP';
  }

  @override
  String monedas(int coins) {
    return '$coins coins';
  }

  @override
  String diasRacha(int streak) {
    return '$streak days';
  }

  @override
  String get progreso => 'Progress';

  @override
  String get avatar => 'Avatar';

  @override
  String get mas => 'More';

  @override
  String get inicio => 'Home';

  @override
  String get perfil => 'Profile';

  @override
  String get logros => 'Achievements';

  @override
  String get tienda => 'Shop';

  @override
  String get inventario => 'Inventory';

  @override
  String get ranking => 'Leaderboard';

  @override
  String get ajustes => 'Settings';

  @override
  String get panelDocente => 'Teacher Panel';
}
