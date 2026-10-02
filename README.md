# EF Quest 🏋️

App gamificada de Educación Física para 1º–4º ESO (LOMLOE Extremadura).

## Stack

| Capa | Tecnología |
|------|-----------|
| Frontend | Flutter 3.x (Android + iOS + Web) |
| Backend | Supabase (PostgreSQL, Auth, Storage, Realtime) |
| Estado | Riverpod + GoRouter |
| Offline | Cache + Cola de sincronización resiliente |
| IA | Lógica adaptativa y heurística de retos |

## Requisitos

- Flutter SDK ≥ 3.2 ([instalar](https://docs.flutter.dev/get-started/install))
- Proyecto Supabase ([crear](https://supabase.com/))

## Setup rápido

```bash
# 1. Descargar dependencias
flutter pub get

# 2. Configurar Supabase
#    - Ejecuta supabase/migration.sql en el SQL Editor de tu proyecto Supabase
#    - Ejecuta supabase/seed_curriculum.sql para poblar el currículo LOMLOE

# 3. Variables de entorno
cp .env.example .env
# Edita .env con tu SUPABASE_URL y SUPABASE_PUBLISHABLE_KEY

# 4. Ejecutar
flutter run
```

## Estructura

```
lib/
├── core/               # Enums, providers compartidos, tema
│   ├── enums/          # 12 enums (UserRole, AvatarTier, etc.)
│   └── providers/      # Firebase, repositorios, IA
├── data/
│   ├── models/         # 12 modelos con toFirestore/fromFirestore
│   ├── repositories/   # 8 repositorios (auth, user, unit, shop...)
│   └── datasources/    # (futuro: remoto/local)
├── features/
│   ├── auth/           # Splash, Onboarding, Login, Register
│   ├── home/           # HomeScreen (unidades)
│   ├── units/          # Detalle unidad, lecciones, retos, minijuegos
│   ├── lessons/        # Flujo lección, quiz interactivo
│   ├── challenges/     # Retos con temporizador y estrellas
│   ├── boss/           # Boss fight por fases
│   ├── progress/       # Atributos, estadísticas, progreso curso
│   ├── avatar/         # Avatar, tienda, personalizar, perfil
│   ├── more/           # Menú más, cierre sesión
│   └── profile/        # Panel del profesor
├── router/             # GoRouter con StatefulShellRoute (4 tabs)
├── shared/widgets/     # AppScaffold, CustomButton
├── app.dart            # MaterialApp.router
└── main.dart           # Entry point
```

## Pantallas (19)

| Pantalla | Ruta | Estado |
|----------|------|--------|
| Splash | `/splash` | ✅ |
| Onboarding | `/onboarding` | ✅ |
| Login | `/auth/login` | ✅ |
| Registro | `/auth/register` | ✅ |
| Home (unidades) | `/home` | ✅ |
| Detalle unidad | `/home/unit/:unitId` | ✅ |
| Lección | `/home/unit/:unitId/lesson/:lessonId` | ✅ |
| Quiz | `/home/unit/:unitId/quiz/:lessonId` | ✅ |
| Reto | `/home/unit/:unitId/challenge/:challengeId` | ✅ |
| Boss fight | `/home/unit/:unitId/boss` | ✅ |
| Progreso | `/progress` | ✅ |
| Avatar | `/avatar` | ✅ |
| Personalizar avatar | `/avatar/customize` | ✅ |
| Tienda | `/avatar/shop` | ✅ |
| Perfil | `/more/perfil` | ✅ |
| Clasificación | `/more/leaderboard` | ✅ |
| Ajustes | `/more/ajustes` | ✅ |
| Más | `/more` | ✅ |
| Panel profesor | `/teacher` | ✅ |

## Base de datos y Migraciones

La base de datos se inicializa y puebla mediante los scripts SQL en `supabase/`:
- `supabase/migration.sql`: Esquema relacional PostgreSQL, tablas, índices, triggers, políticas RLS y funciones atómicas RPC.
- `supabase/seed_curriculum.sql`: Currículo completo de Educación Física LOMLOE (36 unidades, 100+ lecciones, 70+ retos, minijuegos, jefes finales, logros e ítems de tienda).

## Licencia

Uso educativo — IES Extremadura.
