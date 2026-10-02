# ARQUITECTURA DE PANTALLAS — EF App

## 1. FLUJO DE NAVEGACIÓN GLOBAL

```
                    ┌──────────────────┐
                    │   SplashScreen   │
                    └────────┬─────────┘
                             │
                    ┌────────▼─────────┐
                    │  OnboardingScreen │ (solo primera vez)
                    └────────┬─────────┘
                             │
                    ┌────────▼─────────┐
                    │   AuthScreen     │
                    │ (Login/Register) │
                    └────────┬─────────┘
                             │
                    ┌────────▼─────────┐
                    │  RoleSelectScreen│
                    └────────┬─────────┘
                             │
              ┌──────────────┼──────────────┐
              ▼              ▼              ▼
       ┌──────────┐   ┌──────────┐   ┌──────────┐
       │ Alumno   │   │ Profesor │   │ Admin    │
       │  Flow    │   │  Flow    │   │  Flow    │
       └──────────┘   └──────────┘   └──────────┘
```

---

## 2. FLUJO ALUMNO — NAVEGACIÓN PRINCIPAL

### 2.1 Bottom Navigation Bar (4 tabs fijos)

```
┌──────────────────────────────────────────┐
│  [🏠 Home]  [📊 Progreso]  [👤 Avatar]  [⚙️ Más] │
└──────────────────────────────────────────┘
```

---

### 2.2 TAB HOME — Árbol de Unidades

```
HomeScreen (UnitMap)
│
├──► UnitDetailScreen (unidad seleccionada)
│     │
│     ├──► LessonScreen (microlección)
│     │     ├──► VideoScreen (1 min)
│     │     ├──► QuizScreen (preguntas)
│     │     └──► FlashcardsScreen
│     │
│     ├──► ChallengeScreen (reto físico)
│     │     ├──► StepCounterScreen
│     │     ├──► MobilityScreen
│     │     └──► TimerScreen
│     │
│     ├──► MiniGameScreen
│     │     ├──► ReflexGame
│     │     ├──► TimingGame
│     │     ├──► TacticalDecisionScreen
│     │     └──► PuzzleScreen
│     │
│     └──► BossFightScreen (misión final de UD)
│           └──► BossResultScreen
│
├──► QRScannerScreen (escanea calentamientos)
│
└──► NotificationSheet (bottom sheet)
```

### 2.3 TAB PROGRESO

```
ProgressScreen
│
├──► AttributeDetailScreen (Fuerza, Resistencia, etc.)
│     └──► RadarChartView
│
├──► AchievementListScreen
│     └──► AchievementDetailScreen
│
├──► StatsScreen
│     ├──► WeeklyHeatmap
│     ├──► StreakCounter
│     └──► XPHistory
│
└──► LevelProgressBar (siempre visible)
```

### 2.4 TAB AVATAR

```
AvatarScreen
│
├──► AvatarCustomizeScreen
│     ├──► OutfitSelector
│     ├──► AccessorySelector
│     └──► ColorPalette
│
├──► InventoryScreen (ítems desbloqueados)
│
└──► ShopScreen
      ├──► OutfitsSection
      ├──► PowerUpsSection
      └──► SpecialItemsSection
```

### 2.5 TAB MÁS

```
MoreScreen
│
├──► ProfileScreen
│     ├──► EditProfileScreen
│     └──► BadgeDisplay
│
├──► LeaderboardScreen
│     ├──► ClassLeaderboard
│     ├──► SchoolLeaderboard
│     └──► GlobalLeaderboard
│
├──► SettingsScreen
│     ├──► NotificationSettings
│     ├──► SoundSettings
│     ├──► PrivacySettings
│     └──► AccountSettings
│
├──► HelpScreen
│
└──► AboutScreen
```

---

## 3. FLUJO PROFESOR

```
TeacherDashboardScreen
│
├──► ClassListScreen
│     └──► ClassDetailScreen
│           ├──► StudentListScreen
│           │     └──► StudentDetailScreen
│           │           ├──► StudentProgressScreen
│           │           ├──► StudentAttributesScreen
│           │           └──► StudentActivityLogScreen
│           │
│           ├──► CreateAssignmentScreen
│           ├──► CreateChallengeScreen
│           └──► ExportGradesScreen
│
├──► UnitManagerScreen
│     ├──► UnitEditorScreen
│     └──► LessonEditorScreen
│
├──► AnalyticsScreen
│     ├──► ClassProgressOverview
│     ├──► AttributeDistributionChart
│     └──► ParticipationReport
│
└──► SettingsScreen (profesor)
```

---

## 4. MAPA DE NAVEGACIÓN DETALLADO (Alumno)

```
SplashScreen
  │
  ├──[primera vez]──► OnboardingScreen (3-5 slides)
  │                     │
  │                     └──► AuthScreen
  │
  └──[ya registrado]──► AuthScreen
                          │
                          ├──► RegisterScreen
                          │     └──► RoleSelectScreen
                          │           ├──► HomeScreen (alumno)
                          │           └──► TeacherDashboardScreen (profesor)
                          │
                          └──► LoginScreen
                                └──► HomeScreen / TeacherDashboardScreen
```

---

## 5. WIDGETS REUTILIZABLES (Componentes compartidos)

| Widget | Screens donde aparece |
|--------|----------------------|
| `UnitCard` | HomeScreen, UnitDetailScreen |
| `LessonTile` | UnitDetailScreen |
| `ChallengeCard` | UnitDetailScreen, ChallengeScreen |
| `AvatarDisplay` | AvatarScreen, ProfileScreen, HomeScreen (header) |
| `AttributeRadar` | ProgressScreen, AttributeDetailScreen, StudentDetailScreen |
| `XPBar` | Todas las pantallas principales (header) |
| `StreakIndicator` | HomeScreen, ProgressScreen |
| `RewardAnimation` | Al completar lección/reto/boss |
| `DifficultyBadge` | ChallengeScreen, LessonScreen |
| `TimerWidget` | ChallengeScreen, MiniGameScreen |
| `QRScannerOverlay` | QRScannerScreen |
| `BottomNavBar` | HomeScreen, ProgressScreen, AvatarScreen, MoreScreen |

---

## 6. FLUJO DE PANTALLAS POR UNIDAD DIDÁCTICA

```
UnitMapScreen
  │
  └── tap en UD ──► UnitDetailScreen
                      │
                      ├──► [Lección 1] ──► LessonScreen ──► QuizScreen ──► RewardAnimation
                      ├──► [Lección 2] ──► LessonScreen ──► QuizScreen ──► RewardAnimation
                      ├──► [Lección 3] ──► VideoScreen ──► FlashcardsScreen ──► RewardAnimation
                      ├──► [Reto 1] ──► ChallengeScreen ──► RewardAnimation
                      ├──► [Reto 2] ──► MiniGameScreen ──► RewardAnimation
                      │
                      └──► [JEFE FINAL] ──► BossFightScreen
                                              │
                                              └──► BossResultScreen ──► RewardAnimation (grande)
```

---

## 7. DIAGRAMA DE ESTADOS (Auth + Sesión)

```
[No autenticado]
      │
      ▼
[Autenticando] ────error───► [No autenticado]
      │
      ▼
[Autenticado] ──► [Cargando perfil]
                      │
                      ├──► [Alumno] ──► HomeScreen
                      └──► [Profesor] ──► TeacherDashboardScreen

[En sesión]
      │
      ├──► [Background] ──► reconectar si pierde conexión
      ├──► [Completando lección] ──► guardar progreso
      └──► [Cerrando sesión] ──► [No autenticado]
```

---

## 8. ESPECIFICACIONES TÉCNICAS (Flutter)

| Aspecto | Decisión |
|---------|----------|
| State Management | Riverpod o Bloc |
| Routing | GoRouter (declarativo, deep links) |
| Navegación anidada | ShellRoute para BottomNav |
| Transiciones | `slideTransition` para lecciones, `fade` para modales |
| Animaciones | `flutter_animate` o `Lottie` para recompensas |
| Deep links | `deeplink://unidad/{id}/leccion/{id}` |
| Offline first | SQLite (drift) + Firestore sync |

### 8.1 Estructura de carpetas (Flutter)

```
lib/
├── main.dart
├── app.dart
├── router/
│   ├── app_router.dart
│   └── route_names.dart
│
├── core/
│   ├── theme/
│   ├── constants/
│   ├── utils/
│   └── widgets/        # Widgets reutilizables
│
├── features/
│   ├── auth/
│   │   ├── screens/
│   │   ├── widgets/
│   │   ├── models/
│   │   └── providers/
│   │
│   ├── home/
│   │   ├── screens/
│   │   ├── widgets/
│   │   └── providers/
│   │
│   ├── units/
│   │   ├── screens/
│   │   ├── widgets/
│   │   ├── models/
│   │   └── providers/
│   │
│   ├── lessons/
│   │   ├── screens/
│   │   ├── widgets/
│   │   └── providers/
│   │
│   ├── challenges/
│   │   ├── screens/
│   │   ├── widgets/
│   │   └── providers/
│   │
│   ├── minigames/
│   │   ├── screens/
│   │   └── widgets/
│   │
│   ├── avatar/
│   │   ├── screens/
│   │   ├── widgets/
│   │   ├── models/
│   │   └── providers/
│   │
│   ├── progress/
│   │   ├── screens/
│   │   ├── widgets/
│   │   └── providers/
│   │
│   ├── shop/
│   │   ├── screens/
│   │   └── providers/
│   │
│   └── teacher/
│       ├── screens/
│       ├── widgets/
│       └── providers/
│
└── data/
    ├── models/          # Modelos de datos
    ├── repositories/    # Capa de acceso a datos
    ├── datasources/     # Firestore, local, etc.
    └── enums/
```

---

## 9. ESPECIFICACIÓN DE NAVEGACIÓN (GoRouter)

```dart
// Rutas principales
GoRouter(
  initialLocation: '/splash',
  routes: [
    GoRoute(path: '/splash', ...),
    GoRoute(path: '/onboarding', ...),
    GoRoute(path: '/auth', ...),
    GoRoute(path: '/auth/login', ...),
    GoRoute(path: '/auth/register', ...),

    // App principal con BottomNav
    StatefulShellRoute.indexedStack(
      branches: [
        // Tab Home
        StatefulShellBranch(
          routes: [
            GoRoute(path: '/home', ...),
            GoRoute(path: '/home/unit/:unitId', ...),
            GoRoute(path: '/home/unit/:unitId/lesson/:lessonId', ...),
            GoRoute(path: '/home/unit/:unitId/challenge/:challengeId', ...),
            GoRoute(path: '/home/unit/:unitId/boss', ...),
            GoRoute(path: '/home/scan', ...),
          ],
        ),
        // Tab Progreso
        StatefulShellBranch(
          routes: [
            GoRoute(path: '/progress', ...),
            GoRoute(path: '/progress/atributo/:attr', ...),
            GoRoute(path: '/progress/logros', ...),
          ],
        ),
        // Tab Avatar
        StatefulShellBranch(
          routes: [
            GoRoute(path: '/avatar', ...),
            GoRoute(path: '/avatar/customize', ...),
            GoRoute(path: '/avatar/shop', ...),
            GoRoute(path: '/avatar/inventory', ...),
          ],
        ),
        // Tab Más
        StatefulShellBranch(
          routes: [
            GoRoute(path: '/more', ...),
            GoRoute(path: '/more/perfil', ...),
            GoRoute(path: '/more/leaderboard', ...),
            GoRoute(path: '/more/ajustes', ...),
          ],
        ),
      ],
    ),

    // Rutas profesor
    GoRoute(path: '/teacher', ...),
    GoRoute(path: '/teacher/clase/:classId', ...),
    GoRoute(path: '/teacher/clase/:classId/alumno/:studentId', ...),
  ],
)
```
