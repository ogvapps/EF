import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'EF Quest';

  @override
  String helloUser(String name) {
    return 'Hola, $name';
  }

  @override
  String get tusUnidades => 'Tus unidades';

  @override
  String get racha => 'Racha';

  @override
  String get retoDiario => 'Reto diario';

  @override
  String get sinConexion => 'Sin conexión';

  @override
  String get explorador => 'Explorador';

  @override
  String get errorCargar => 'Error al cargar los datos';

  @override
  String get reintentar => 'Reintentar';

  @override
  String get noUnidades => 'No hay unidades disponibles';

  @override
  String get empezar => '¡Empezar!';

  @override
  String get completar => 'Completar';

  @override
  String get guardar => 'Guardar';

  @override
  String get cancelar => 'Cancelar';

  @override
  String get cerrar => 'Cerrar';

  @override
  String get iniciarSesion => 'Iniciar sesión';

  @override
  String get registrarse => 'Registrarse';

  @override
  String get correo => 'Correo electrónico';

  @override
  String get contrasena => 'Contraseña';

  @override
  String get nombre => 'Nombre';

  @override
  String get curso => 'Curso';

  @override
  String nivel(int level) {
    return 'Nv.$level';
  }

  @override
  String xpInLevel(int xp, int max) {
    return '$xp/$max XP';
  }

  @override
  String monedas(int coins) {
    return '$coins monedas';
  }

  @override
  String diasRacha(int streak) {
    return '$streak días';
  }

  @override
  String get progreso => 'Progreso';

  @override
  String get avatar => 'Avatar';

  @override
  String get mas => 'Más';

  @override
  String get inicio => 'Inicio';

  @override
  String get perfil => 'Perfil';

  @override
  String get logros => 'Logros';

  @override
  String get tienda => 'Tienda';

  @override
  String get inventario => 'Inventario';

  @override
  String get ranking => 'Ranking';

  @override
  String get ajustes => 'Ajustes';

  @override
  String get panelDocente => 'Panel docente';
}
