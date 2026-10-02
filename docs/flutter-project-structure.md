# ESTRUCTURA DEL PROYECTO FLUTTER — EF App

## 1. ÁRBOL COMPLETO DEL PROYECTO

```
ef_app/
├── android/
├── ios/
├── web/
├── test/
│   ├── unit/
│   │   ├── models/
│   │   ├── repositories/
│   │   └── providers/
│   ├── widget/
│   │   ├── common/
│   │   └── features/
│   └── integration/
│       ├── auth_flow_test.dart
│       ├── unit_flow_test.dart
│       └── challenge_flow_test.dart
│
├── lib/
│   ├── main.dart
│   ├── app.dart
│   │
│   ├── bootstrap/
│   │   ├── app_bootstrap.dart        # Inicialización Firebase, Hive, etc.
│   │   ├── dependency_injection.dart  # GetIt / Provider setup
│   │   └── error_handler.dart        # Global error handling
│   │
│   ├── router/
│   │   ├── app_router.dart           # Config GoRouter
│   │   ├── route_names.dart          # Constantes de rutas
│   │   └── guards/
│   │       ├── auth_guard.dart
│   │       └── role_guard.dart
│   │
│   ├── core/
│   │   ├── theme/
│   │   │   ├── app_theme.dart
│   │   │   ├── app_colors.dart
│   │   │   ├── app_typography.dart
│   │   │   └── app_spacing.dart
│   │   │
│   │   ├── constants/
│   │   │   ├── app_constants.dart
│   │   │   ├── firestore_collections.dart
│   │   │   └── api_endpoints.dart
│   │   │
│   │   ├── utils/
│   │   │   ├── date_utils.dart
│   │   │   ├── number_utils.dart
│   │   │   ├── validation_utils.dart
│   │   │   ├── permission_utils.dart
│   │   │   └── device_utils.dart
│   │   │
│   │   ├── enums/
│   │   │   ├── user_role.dart
│   │   │   ├── challenge_type.dart
│   │   │   ├── lesson_type.dart
│   │   │   ├── difficulty.dart
│   │   │   ├── avatar_tier.dart
│   │   │   ├── attribute_type.dart
│   │   │   ├── progress_status.dart
│   │   │   └── achievement_category.dart
│   │   │
│   │   ├── exceptions/
│   │   │   ├── app_exception.dart
│   │   │   ├── auth_exception.dart
│   │   │   ├── firestore_exception.dart
│   │   │   └── network_exception.dart
│   │   │
│   │   └── extensions/
│   │       ├── context_extensions.dart
│   │       ├── string_extensions.dart
│   │       ├── num_extensions.dart
│   │       └── datetime_extensions.dart
│   │
│   ├── data/
│   │   ├── models/
│   │   │   ├── user_model.dart
│   │   │   ├── unit_model.dart
│   │   │   ├── lesson_model.dart
│   │   │   ├── challenge_model.dart
│   │   │   ├── minigame_model.dart
│   │   │   ├── user_progress_model.dart
│   │   │   ├── achievement_model.dart
│   │   │   ├── user_achievement_model.dart
│   │   │   ├── shop_item_model.dart
│   │   │   ├── user_inventory_model.dart
│   │   │   ├── class_model.dart
│   │   │   ├── notification_model.dart
│   │   │   ├── ai_adaptation_model.dart
│   │   │   └── quiz_question_model.dart
│   │   │
│   │   ├── datasources/
│   │   │   ├── remote/
│   │   │   │   ├── firestore_datasource.dart
│   │   │   │   ├── auth_datasource.dart
│   │   │   │   ├── storage_datasource.dart
│   │   │   │   └── ai_datasource.dart      # OpenAI API calls
│   │   │   │
│   │   │   ├── local/
│   │   │   │   ├── local_database.dart      # SQLite (drift)
│   │   │   │   ├── preferences_datasource.dart # SharedPreferences
│   │   │   │   └── cache_datasource.dart    # Caché en disco
│   │   │   │
│   │   │   └── sensor/
│   │   │       ├── step_counter_datasource.dart
│   │   │       ├── heart_rate_datasource.dart
│   │   │       └── location_datasource.dart
│   │   │
│   │   └── repositories/
│   │       ├── auth_repository.dart
│   │       ├── user_repository.dart
│   │       ├── unit_repository.dart
│   │       ├── lesson_repository.dart
│   │       ├── challenge_repository.dart
│   │       ├── progress_repository.dart
│   │       ├── achievement_repository.dart
│   │       ├── shop_repository.dart
│   │       ├── class_repository.dart
│   │       ├── notification_repository.dart
│   │       └── ai_repository.dart
│   │
│   ├── features/
│   │   ├── auth/
│   │   │   ├── providers/
│   │   │   │   ├── auth_provider.dart
│   │   │   │   ├── auth_state.dart
│   │   │   │   └── auth_notifier.dart
│   │   │   ├── screens/
│   │   │   │   ├── splash_screen.dart
│   │   │   │   ├── onboarding_screen.dart
│   │   │   │   ├── login_screen.dart
│   │   │   │   ├── register_screen.dart
│   │   │   │   └── role_select_screen.dart
│   │   │   ├── widgets/
│   │   │   │   ├── auth_text_field.dart
│   │   │   │   ├── social_login_button.dart
│   │   │   │   └── onboarding_page.dart
│   │   │   └── validators/
│   │   │       └── auth_validators.dart
│   │   │
│   │   ├── home/
│   │   │   ├── providers/
│   │   │   │   ├── home_provider.dart
│   │   │   │   └── unit_map_provider.dart
│   │   │   ├── screens/
│   │   │   │   └── home_screen.dart
│   │   │   └── widgets/
│   │   │       ├── unit_map_widget.dart
│   │   │       ├── unit_node_widget.dart
│   │   │       ├── streak_banner.dart
│   │   │       ├── daily_challenge_card.dart
│   │   │       └── motivational_banner.dart
│   │   │
│   │   ├── units/
│   │   │   ├── providers/
│   │   │   │   ├── unit_detail_provider.dart
│   │   │   │   └── unit_progress_provider.dart
│   │   │   ├── screens/
│   │   │   │   └── unit_detail_screen.dart
│   │   │   └── widgets/
│   │   │       ├── unit_header_widget.dart
│   │   │       ├── lesson_list_widget.dart
│   │   │       ├── challenge_list_widget.dart
│   │   │       ├── unit_progress_bar.dart
│   │   │       └── boss_lock_widget.dart
│   │   │
│   │   ├── lessons/
│   │   │   ├── providers/
│   │   │   │   ├── lesson_provider.dart
│   │   │   │   └── quiz_provider.dart
│   │   │   ├── screens/
│   │   │   │   ├── lesson_screen.dart
│   │   │   │   ├── video_screen.dart
│   │   │   │   ├── quiz_screen.dart
│   │   │   │   └── flashcards_screen.dart
│   │   │   └── widgets/
│   │   │       ├── video_player_widget.dart
│   │   │       ├── quiz_question_card.dart
│   │   │       ├── quiz_progress_bar.dart
│   │   │       ├── flashcard_deck.dart
│   │   │       └── lesson_complete_dialog.dart
│   │   │
│   │   ├── challenges/
│   │   │   ├── providers/
│   │   │   │   ├── challenge_provider.dart
│   │   │   │   ├── step_counter_provider.dart
│   │   │   │   └── timer_provider.dart
│   │   │   ├── screens/
│   │   │   │   ├── challenge_screen.dart
│   │   │   │   ├── challenge_result_screen.dart
│   │   │   │   ├── step_counter_screen.dart
│   │   │   │   ├── mobility_screen.dart
│   │   │   │   └── heart_rate_screen.dart
│   │   │   └── widgets/
│   │   │       ├── challenge_timer.dart
│   │   │       ├── step_counter_widget.dart
│   │   │       ├── heart_rate_monitor.dart
│   │   │       ├── challenge_intro_card.dart
│   │   │       └── star_rating.dart
│   │   │
│   │   ├── minigames/
│   │   │   ├── providers/
│   │   │   │   ├── minigame_provider.dart
│   │   │   │   └── reflex_game_provider.dart
│   │   │   ├── screens/
│   │   │   │   └── minigame_screen.dart
│   │   │   └── games/
│   │   │       ├── reflex_game_widget.dart
│   │   │       ├── timing_game_widget.dart
│   │   │       ├── pattern_game_widget.dart
│   │   │       ├── tactical_decision_widget.dart
│   │   │       └── puzzle_game_widget.dart
│   │   │
│   │   ├── boss/
│   │   │   ├── providers/
│   │   │   │   └── boss_fight_provider.dart
│   │   │   ├── screens/
│   │   │   │   ├── boss_fight_screen.dart
│   │   │   │   └── boss_result_screen.dart
│   │   │   └── widgets/
│   │   │       ├── boss_health_bar.dart
│   │   │       ├── boss_challenge_card.dart
│   │   │       └── boss_reward_animation.dart
│   │   │
│   │   ├── avatar/
│   │   │   ├── providers/
│   │   │   │   ├── avatar_provider.dart
│   │   │   │   └── shop_provider.dart
│   │   │   ├── screens/
│   │   │   │   ├── avatar_screen.dart
│   │   │   │   ├── avatar_customize_screen.dart
│   │   │   │   └── shop_screen.dart
│   │   │   └── widgets/
│   │   │       ├── avatar_render_widget.dart
│   │   │       ├── outfit_grid.dart
│   │   │       ├── accessory_picker.dart
│   │   │       ├── shop_item_card.dart
│   │   │       └── inventory_grid.dart
│   │   │
│   │   ├── progress/
│   │   │   ├── providers/
│   │   │   │   ├── progress_provider.dart
│   │   │   │   ├── stats_provider.dart
│   │   │   │   └── leaderboard_provider.dart
│   │   │   ├── screens/
│   │   │   │   ├── progress_screen.dart
│   │   │   │   ├── attribute_detail_screen.dart
│   │   │   │   ├── achievement_list_screen.dart
│   │   │   │   ├── stats_screen.dart
│   │   │   │   └── leaderboard_screen.dart
│   │   │   └── widgets/
│   │   │       ├── radar_chart_widget.dart
│   │   │       ├── xp_progress_bar.dart
│   │   │       ├── weekly_heatmap.dart
│   │   │       ├── achievement_card.dart
│   │   │       ├── leaderboard_tile.dart
│   │   │       └── streak_display.dart
│   │   │
│   │   ├── qr_scanner/
│   │   │   ├── providers/
│   │   │   │   └── qr_scanner_provider.dart
│   │   │   ├── screens/
│   │   │   │   └── qr_scanner_screen.dart
│   │   │   └── widgets/
│   │   │       └── scanner_overlay.dart
│   │   │
│   │   ├── profile/
│   │   │   ├── providers/
│   │   │   │   └── profile_provider.dart
│   │   │   ├── screens/
│   │   │   │   ├── profile_screen.dart
│   │   │   │   └── edit_profile_screen.dart
│   │   │   └── widgets/
│   │   │       ├── profile_header.dart
│   │   │       └── badge_display.dart
│   │   │
│   │   ├── settings/
│   │   │   ├── providers/
│   │   │   │   └── settings_provider.dart
│   │   │   ├── screens/
│   │   │   │   └── settings_screen.dart
│   │   │   └── widgets/
│   │   │       ├── settings_tile.dart
│   │   │       └── theme_selector.dart
│   │   │
│   │   ├── notifications/
│   │   │   ├── providers/
│   │   │   │   └── notification_provider.dart
│   │   │   └── widgets/
│   │   │       ├── notification_tile.dart
│   │   │       └── notification_badge.dart
│   │   │
│   │   └── teacher/
│   │       ├── providers/
│   │       │   ├── teacher_dashboard_provider.dart
│   │       │   ├── class_provider.dart
│   │       │   └── analytics_provider.dart
│   │       ├── screens/
│   │       │   ├── teacher_dashboard_screen.dart
│   │       │   ├── class_list_screen.dart
│   │       │   ├── class_detail_screen.dart
│   │       │   ├── student_detail_screen.dart
│   │       │   ├── create_assignment_screen.dart
│   │       │   ├── create_challenge_screen.dart
│   │       │   ├── export_grades_screen.dart
│   │       │   └── analytics_screen.dart
│   │       └── widgets/
│   │           ├── student_list_tile.dart
│   │           ├── class_progress_card.dart
│   │           ├── attribute_distribution_chart.dart
│   │           ├── grades_export_panel.dart
│   │           └── assignment_card.dart
│   │
│   └── shared/
│       └── widgets/
│           ├── app_scaffold.dart
│           ├── loading_overlay.dart
│           ├── error_widget.dart
│           ├── empty_state_widget.dart
│           ├── xp_reward_animation.dart
│           ├── coin_display.dart
│           ├── avatar_tier_badge.dart
│           ├── difficulty_indicator.dart
│           ├── network_aware_widget.dart
│           ├── confirm_dialog.dart
│           └── bottom_sheet_wrapper.dart
│
├── assets/
│   ├── images/
│   │   ├── logo.png
│   │   ├── splash_bg.png
│   │   ├── onboarding_1.png
│   │   ├── onboarding_2.png
│   │   ├── onboarding_3.png
│   │   ├── avatar_rookie.png
│   │   ├── avatar_amateur.png
│   │   ├── avatar_competidor.png
│   │   ├── avatar_capitan.png
│   │   └── avatar_elite.png
│   │
│   ├── icons/
│   │   ├── attribute_fuerza.svg
│   │   ├── attribute_resistencia.svg
│   │   ├── attribute_estrategia.svg
│   │   ├── attribute_cooperacion.svg
│   │   ├── attribute_salud.svg
│   │   ├── attribute_liderazgo.svg
│   │   └── ... (más iconos)
│   │
│   ├── animations/
│   │   ├── reward_lottie.json
│   │   ├── boss_victory.json
│   │   ├── level_up.json
│   │   ├── achievement_unlock.json
│   │   └── streak_fire.json
│   │
│   ├── fonts/
│   │   ├── Poppins-Regular.ttf
│   │   ├── Poppins-Bold.ttf
│   │   └── Poppins-SemiBold.ttf
│   │
│   └── sounds/
│       ├── correct_answer.mp3
│       ├── wrong_answer.mp3
│       ├── level_up.mp3
│       ├── achievement_unlock.mp3
│       └── challenge_complete.mp3
│
├── pubspec.yaml
├── analysis_options.yaml
├── .env.example
├── .gitignore
└── README.md
```

---

## 2. pubspec.yaml (dependencias clave)

```yaml
name: ef_app
description: App gamificada de Educación Física (LOMLOE)
version: 1.0.0

environment:
  sdk: '>=3.2.0 <4.0.0'

dependencies:
  flutter:
    sdk: flutter

  # Firebase
  firebase_core: ^2.25.0
  firebase_auth: ^4.17.0
  cloud_firestore: ^4.15.0
  firebase_storage: ^11.6.0
  firebase_messaging: ^14.7.0
  firebase_analytics: ^10.8.0

  # Navegación
  go_router: ^13.0.0

  # State Management
  flutter_riverpod: ^2.4.9
  riverpod_annotation: ^2.3.3

  # Base de datos local
  drift: ^2.15.0
  sqlite3_flutter_libs: ^0.5.0
  shared_preferences: ^2.2.2

  # UI / Animaciones
  lottie: ^2.7.0
  flutter_animate: ^4.3.0
  fl_chart: ^0.66.0          # gráficos radar, barras
  shimmer: ^3.0.0             # loading skeletons

  # Sensores / Hardware
  sensors_plus: ^4.0.0
  health: ^8.0.0              # Google Health Connect
  camera: ^0.10.5
  mobile_scanner: ^3.5.5      # QR scanner
  geolocator: ^10.1.0
  geocoding: ^2.1.1

  # IA
  http: ^1.2.0                # OpenAI API calls
  google_generative_ai: ^0.2.0

  # Utilidades
  intl: ^0.19.0
  uuid: ^4.2.1
  logger: ^2.0.2
  flutter_secure_storage: ^9.0.0
  permission_handler: ^11.1.0
  connectivity_plus: ^5.0.2
  package_info_plus: ^5.0.1
  url_launcher: ^6.2.1
  cached_network_image: ^3.3.0
  flutter_local_notifications: ^16.3.0

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^3.0.1
  riverpod_generator: ^2.3.9
  build_runner: ^2.4.7
  mockito: ^5.4.4
  drift_dev: ^2.15.0
  json_serializable: ^6.7.1

flutter:
  uses-material-design: true

  assets:
    - assets/images/
    - assets/icons/
    - assets/animations/
    - assets/fonts/
    - assets/sounds/

  fonts:
    - family: Poppins
      fonts:
        - asset: assets/fonts/Poppins-Regular.ttf
        - asset: assets/fonts/Poppins-Bold.ttf
          weight: 700
        - asset: assets/fonts/Poppins-SemiBold.ttf
          weight: 600
```

---

## 3. ARQUITECTURA DE DATOS (Offline-First)

```
┌─────────────────────────────────────────────────┐
│                    UI LAYER                      │
│         Screens + Widgets (Riverpod)            │
└────────────────────┬────────────────────────────┘
                     │ consume
┌────────────────────▼────────────────────────────┐
│                 PROVIDERS                        │
│      Notifiers + State (Riverpod)               │
└────────────────────┬────────────────────────────┘
                     │ llama
┌────────────────────▼────────────────────────────┐
│               REPOSITORIES                       │
│   Orquestan remote + local (single source of    │
│   truth = Firestore, caché = SQLite)            │
└────────┬───────────────────────────┬────────────┘
         │                           │
┌────────▼──────────┐   ┌───────────▼────────────┐
│  REMOTE DATASOURCE │   │   LOCAL DATASOURCE     │
│  Firestore/Auth/API│   │   SQLite (drift)       │
│  OpenAI            │   │   SharedPreferences    │
└────────────────────┘   └───────────────────────┘
```

### Flujo Offline-First

```
1. Usuario realiza acción
2. Repositorio escribe a Firestore (remote)
3. Repositorio escribe a SQLite (local cache)
4. UI escucha stream de Firestore (con soporte offline)
5. Si no hay conexión → lee de SQLite
6. Al reconectar → sincronización automática
```

---

## 4. PATRÓN RIVERPOD (State Management)

### Estructura de cada Provider

```dart
// 1. State
@freezed
class UnitState with _$UnitState {
  const factory UnitState.initial() = _Initial;
  const factory UnitState.loading() = _Loading;
  const factory UnitState.loaded(Unit unit) = _Loaded;
  const factory UnitState.error(String message) = _Error;
}

// 2. Notifier
@riverpod
class UnitNotifier extends _$UnitNotifier {
  @override
  Future<UnitState> build(String unitId) async {
    // Cargar unidad desde repositorio
  }

  Future<void> completeLesson(String lessonId) async { ... }
  Future<void> updateProgress() async { ... }
}

// 3. Provider expuesto
final unitProvider = AsyncNotifierProvider<UnitNotifier, UnitState>(
  UnitNotifier.new,
);
```

---

## 5. CONFIGURACIÓN MULTI-ENTORNO

```
lib/
└── bootstrap/
    ├── main_development.dart
    ├── main_staging.dart
    └── main_production.dart

.firebaserc
├── projects:
│   ├── ef-app-dev
│   ├── ef-app-staging
│   └── ef-app-prod
```

### main.dart (punto de entrada único)

```dart
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppBootstrap.initialize();
  runApp(const EFApp());
}
```
