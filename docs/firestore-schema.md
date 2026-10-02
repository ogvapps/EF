# ESQUEMA DE BASE DE DATOS — Firestore (EF App)

## 1. CONVENCIONES

| Regla | Valor |
|-------|-------|
| Formato IDs | `snake_case` |
| Timestamps | `Timestamp` de Firestore |
| Fechas legibles | `createdAt`, `updatedAt` |
| Soft delete | `isActive: bool` |
| Subcolecciones | Prefijo `sub_` solo si hay riesgo de confusión |

---

## 2. COLECCIÓN: `users`

**Document ID:** `{uid}` (mismo que Auth UID)

```typescript
users/{uid}
{
  // === DATOS PERSONALES ===
  uid:            string,
  email:          string,
  displayName:    string,
  photoURL:       string | null,
  role:           "alumno" | "profesor" | "admin",
  course:         "1_eso" | "2_eso" | "3_eso" | "4_eso", // solo alumno
  group:          string | null,                          // ej: "A", "B"
  schoolYear:     string,                                  // ej: "2025-2026"

  // === GAMIFICACIÓN ===
  xp:             number,           // experiencia total
  level:          number,           // nivel global
  streak:         number,           // días consecutivos
  lastActiveDate: Timestamp,
  avatarTier:     "rookie" | "amateur" | "competidor" | "capitan" | "elite",
  avatarConfig: {
    outfitId:     string,
    accessoryId:  string | null,
    colorHex:     string,
  },

  // === ATRIBUTOS ===
  attributes: {
    fuerza:       number,   // 0-100
    resistencia:  number,   // 0-100
    estrategia:   number,   // 0-100
    cooperacion:  number,   // 0-100
    salud:        number,   // 0-100
    liderazgo:    number,   // 0-100
  },

  // === PROGRESO ACADÉMICO ===
  currentUnitId: string | null,   // última unidad activa
  completedUnits: string[],       // IDs de unidades completadas
  totalLessonsCompleted: number,
  totalChallengesCompleted: number,

  // === MÉTRICAS ===
  totalMinutesActive: number,
  totalSessions: number,
  averageDailySteps: number,

  // === METADATA ===
  isActive:       boolean,
  createdAt:      Timestamp,
  updatedAt:      Timestamp,
  lastLoginAt:    Timestamp,
}
```

### Índices compuestos requeridos

| Colección | Campos | Tipo |
|-----------|--------|------|
| `users` | `role` + `course` | Query alumnos por curso |
| `users` | `group` + `course` | Query alumnos por grupo |
| `users` | `xp` (desc) | Leaderboard global |

---

## 3. COLECCIÓN: `units`

**Document ID:** `{unitId}` (ej: `1eso_ud1`)

```typescript
units/{unitId}
{
  unitId:        string,
  course:        "1_eso" | "2_eso" | "3_eso" | "4_eso",
  trimester:     1 | 2 | 3,
  order:         number,           // orden dentro del curso
  title:         string,           // ej: "Bienvenido a tu cuerpo"
  subtitle:      string,           // ej: "UD1 — 1º ESO"
  description:   string,
  durationWeeks: number,           // 3-5 semanas

  // === GAMIFICACIÓN ===
  narrativeTitle:  string,         // ej: "El Despertar del Cuerpo"
  bossName:        string,         // nombre del jefe final
  totalXP:         number,         // XP máximo de la unidad
  requiredXP:      number,         // XP mínimo para aprobar
  bossXP:          number,         // XP del jefe final

  // === ATRIBUTOS QUE ENTRENA ===
  attributeFocus: {
    fuerza:      0-5,
    resistencia: 0-5,
    estrategia:  0-5,
    cooperacion: 0-5,
    salud:       0-5,
    liderazgo:   0-5,
  },

  // === CONTENIDO ===
  saberBasico:   string[],         // saberes básicos que cubre
  competencias:  string[],         // competencias específicas
  criteriosEval: string[],         // criterios de evaluación

  // === UI ===
  iconURL:       string,
  colorHex:      string,           // color distintivo
  isLocked:      boolean,
  prerequisiteUnit: string | null, // unidad que debe completar antes

  // === METADATA ===
  isActive:      boolean,
  createdAt:     Timestamp,
  updatedAt:     Timestamp,
}
```

---

## 4. SUBCOLECCIÓN: `units/{unitId}/lessons`

**Document ID:** `{lessonId}` (ej: `leccion_01`)

```typescript
units/{unitId}/lessons/{lessonId}
{
  lessonId:     string,
  unitId:       string,
  order:        number,
  type:         "video" | "quiz" | "flashcard" | "reading" | "challenge_prep",
  title:        string,
  description:  string,
  durationSec:  number,          // ~60 segundos

  // === CONTENIDO ===
  videoURL:     string | null,
  contentHTML:  string | null,   // para reading/flashcard
  quizData: {
    questions: [
      {
        id:       string,
        question: string,
        options:  string[4],
        correct:  number,        // índice 0-3
        explanation: string,
        xpReward: number,
      }
    ],
    minPassScore: number,        // % para avanzar
  } | null,

  // === RECOMPENSAS ===
  xpReward:     number,
  attributeRewards: {
    fuerza:      0-10,
    resistencia: 0-10,
    estrategia:  0-10,
    cooperacion: 0-10,
    salud:       0-10,
    liderazgo:   0-10,
  },
  coinReward:   number,

  // === METADATA ===
  isActive:     boolean,
  createdAt:    Timestamp,
}
```

---

## 5. SUBCOLECCIÓN: `units/{unitId}/challenges`

**Document ID:** `{challengeId}` (ej: `reto_01`)

```typescript
units/{unitId}/challenges/{challengeId}
{
  challengeId:  string,
  unitId:       string,
  order:        number,
  type:         "steps" | "mobility" | "cardio" | "strength" | "coordination" | "tactical",
  title:        string,
  description:  string,
  difficulty:   "facil" | "medio" | "dificil",

  // === REQUISITOS ===
  goalType:     "reps" | "seconds" | "meters" | "steps" | "heart_rate" | "score",
  goalValue:    number,           // ej: 30 (repeticiones), 300 (segundos)
  minValue:     number,           // mínimo para aprobar
  maxValue:     number,           // valor máximo (3 estrellas)

  // === IA ADAPTATIVA ===
  adaptiveDifficulty: {
    enabled:    boolean,
    baseValue:  number,
    incrementPerLevel: number,
    maxValue:   number,
  },

  // === RECOMPENSAS ===
  xpReward:     number,
  xpThreeStars: number,          // XP extra por 3 estrellas
  attributeRewards: { ... },

  // === GUIÓN (para el narrador) ===
  introText:    string,
  successText:  string,
  failText:     string,

  // === METADATA ===
  isActive:     boolean,
  createdAt:    Timestamp,
}
```

---

## 6. SUBCOLECCIÓN: `units/{unitId}/minigames`

**Document ID:** `{minigameId}` (ej: `reflex_01`)

```typescript
units/{unitId}/minigames/{minigameId}
{
  minigameId:  string,
  unitId:      string,
  order:       number,
  type:        "reflex" | "timing" | "pattern" | "tactical_decision" | "puzzle",
  title:       string,
  description: string,

  // === CONFIGURACIÓN ===
  config: {
    rounds:         number,
    timePerRound:   number,    // segundos
    difficultyLevels: number,  // 3-5 niveles
    assets: {
      imageURL:     string | null,
      soundURL:     string | null,
    },
  },

  // === NIVELES ===
  levels: [
    {
      level:      1,
      params:     {},          // parámetros específicos del juego
      passScore:  number,
      threeStarScore: number,
    }
  ],

  // === RECOMPENSAS ===
  xpReward:     number,
  coinReward:   number,

  isActive:     boolean,
  createdAt:    Timestamp,
}
```

---

## 7. COLECCIÓN: `user_progress`

**Document ID:** `{userId}_{unitId}_{lessonOrChallengeId}` (compuesto)

```typescript
user_progress/{progressId}
{
  userId:       string,
  unitId:       string,
  refId:        string,           // lessonId o challengeId
  refType:      "lesson" | "challenge" | "minigame" | "boss",

  // === ESTADO ===
  status:       "locked" | "available" | "in_progress" | "completed" | "failed",
  score:        number | null,    // 0-100 o según tipo
  stars:        0 | 1 | 2 | 3,

  // === MÉTRICAS ===
  timeSpentSec: number,
  attempts:     number,
  completedAt:  Timestamp | null,

  // === DATOS ESPECÍFICOS ===
  quizAnswers: [
    {
      questionId: string,
      selected:   number,
      correct:    boolean,
      timestamp:  Timestamp,
    }
  ] | null,
  challengeResult: {
    value:      number,           // ej: reps logradas
    heartRate:  number | null,
    duration:   number | null,
  } | null,

  // === IA ===
  aiDifficulty: number | null,   // nivel de dificultad asignado por IA

  createdAt:    Timestamp,
  updatedAt:    Timestamp,
}
```

### Índices compuestos

| Colección | Campos | Uso |
|-----------|--------|-----|
| `user_progress` | `userId` + `unitId` | Progreso de un usuario en una unidad |
| `user_progress` | `userId` + `status` | Filtrar completados/pendientes |
| `user_progress` | `unitId` + `refType` | Estadísticas por tipo |

---

## 8. COLECCIÓN: `achievements`

**Document ID:** `{achievementId}`

```typescript
achievements/{achievementId}
{
  achievementId: string,
  title:         string,
  description:   string,
  iconURL:       string,
  category:      "streak" | "units" | "attributes" | "social" | "special",
  rarity:        "comun" | "raro" | "epico" | "legendario",

  // === CONDICIÓN ===
  condition: {
    type:    "xp_reach" | "streak_reach" | "units_completed" |
             "attribute_reach" | "challenges_perfect" | "social",
    target:  number,              // valor necesario
    params:  {},                  // parámetros extra
  },

  xpReward:      number,
  coinReward:    number,
  attributeReward: { ... },

  isActive:      boolean,
  createdAt:     Timestamp,
}
```

---

## 9. COLECCIÓN: `user_achievements`

**Document ID:** `{userId}_{achievementId}`

```typescript
user_achievements/{userAchievementId}
{
  userId:        string,
  achievementId: string,
  unlockedAt:    Timestamp,
  progress:      number,          // 0-100 (% hacia conseguirlo)
  isComplete:    boolean,
  claimed:       boolean,         // si ya recogió la recompensa
}
```

### Índices

| Colección | Campos | Uso |
|-----------|--------|-----|
| `user_achievements` | `userId` + `isComplete` | Logros del usuario |
| `user_achievements` | `userId` + `claimed` | Recompensas pendientes |

---

## 10. COLECCIÓN: `shop_items`

**Document ID:** `{itemId}`

```typescript
shop_items/{itemId}
{
  itemId:       string,
  type:         "outfit" | "accessory" | "powerup" | "special",
  name:         string,
  description:  string,
  imageURL:     string,
  price:        number,           // monedas
  tier:         "rookie" | "amateur" | "competidor" | "capitan" | "elite",
  isLimited:    boolean,
  availableUntil: Timestamp | null,
  isActive:     boolean,
  createdAt:    Timestamp,
}
```

---

## 11. COLECCIÓN: `user_inventory`

**Document ID:** `{userId}_{itemId}`

```typescript
user_inventory/{userInventoryId}
{
  userId:       string,
  itemId:       string,
  acquiredAt:   Timestamp,
  isEquipped:   boolean,
  quantity:     number,            // para powerups consumibles
}
```

---

## 12. COLECCIÓN: `classes` (para profesor)

**Document ID:** `{classId}`

```typescript
classes/{classId}
{
  classId:      string,
  teacherId:    string,
  course:       "1_eso" | "2_eso" | "3_eso" | "4_eso",
  group:        string,            // ej: "A", "B"
  schoolYear:   string,
  students:     string[],           // array de UIDs

  // === CONFIGURACIÓN ===
  customChallenges: [
    {
      title:      string,
      description: string,
      dueDate:    Timestamp,
      xpReward:   number,
      isActive:   boolean,
    }
  ],

  createdAt:     Timestamp,
  updatedAt:     Timestamp,
}
```

### Índices

| Colección | Campos | Uso |
|-----------|--------|-----|
| `classes` | `teacherId` | Clases de un profesor |
| `classes` | `course` + `group` | Buscar grupo |

---

## 13. COLECCIÓN: `notifications`

**Document ID:** `{notificationId}` (auto-generado)

```typescript
notifications/{notificationId}
{
  userId:       string,
  type:         "streak_reminder" | "new_unit" | "achievement" |
                "challenge_available" | "teacher_message" | "class_event",
  title:        string,
  body:         string,
  data:         {},                 // datos para deep link
  isRead:       boolean,
  createdAt:    Timestamp,
}
```

### Índices

| Colección | Campos | Uso |
|-----------|--------|-----|
| `notifications` | `userId` + `isRead` + `createdAt` (desc) | Notificaciones del usuario |

---

## 14. COLECCIÓN: `ai_adaptations` (caché de IA)

**Document ID:** `{userId}_{contextId}`

```typescript
ai_adaptations/{aiAdaptationId}
{
  userId:        string,
  contextType:   "unit" | "challenge" | "global",
  contextId:     string,

  // === PERFIL IA ===
  difficultyLevel:    number,    // 1-10
  performanceTrend:   "up" | "down" | "stable",
  weakAttributes:     string[],  // atributos a reforzar
  strongAttributes:   string[],  // atributos destacados
  recommendedPace:    "slow" | "normal" | "fast",
  lastPrediction:     Timestamp,

  // === FEEDBACK PERSONALIZADO ===
  motivationalMessage: string | null,
  suggestedFocus:      string | null,

  updatedAt:      Timestamp,
}
```

---

## 15. DIAGRAMA DE RELACIONES

```
users (1) ──────< (N) user_progress
users (1) ──────< (N) user_achievements
users (1) ──────< (N) user_inventory
users (1) ──────< (N) notifications
users (1) ──────< (N) ai_adaptations
users (N) ───────> (1) classes (a través de students[])
users (1) ───────> (1) classes (teacherId)

units (1) ──────< (N) lessons    (subcolección)
units (1) ──────< (N) challenges (subcolección)
units (1) ──────< (N) minigames  (subcolección)

achievements (1) ──────< (N) user_achievements
shop_items   (1) ──────< (N) user_inventory
```

---

## 16. REGLAS DE SEGURIDAD (Firestore Security Rules)

```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {

    // === USUARIOS ===
    match /users/{userId} {
      allow read: if request.auth != null;
      allow write: if request.auth != null
                   && request.auth.uid == userId;
      allow create: if request.auth != null
                    && request.auth.uid == userId;
    }

    // === UNIDADES (lectura pública) ===
    match /units/{unitId} {
      allow read: if request.auth != null;
      allow write: if request.auth != null
                   && get(/databases/$(database)/documents/users/$(request.auth.uid)).data.role == 'admin';

      match /lessons/{lessonId} { allow read: if request.auth != null; }
      match /challenges/{challengeId} { allow read: if request.auth != null; }
      match /minigames/{minigameId} { allow read: if request.auth != null; }
    }

    // === PROGRESO (solo propio) ===
    match /user_progress/{progressId} {
      allow read, write: if request.auth != null
                         && resource.data.userId == request.auth.uid;
    }

    // === LOGROS ===
    match /achievements/{achievementId} {
      allow read: if request.auth != null;
    }

    match /user_achievements/{uaId} {
      allow read, write: if request.auth != null
                         && resource.data.userId == request.auth.uid;
    }

    // === TIENDA E INVENTARIO ===
    match /shop_items/{itemId} {
      allow read: if request.auth != null;
    }

    match /user_inventory/{invId} {
      allow read, write: if request.auth != null
                         && resource.data.userId == request.auth.uid;
    }

    // === CLASES (profesor) ===
    match /classes/{classId} {
      allow read: if request.auth != null
                  && (resource.data.teacherId == request.auth.uid
                      || request.auth.uid in resource.data.students);
      allow write: if request.auth != null
                   && resource.data.teacherId == request.auth.uid;
    }

    // === NOTIFICACIONES ===
    match /notifications/{notificationId} {
      allow read, write: if request.auth != null
                         && resource.data.userId == request.auth.uid;
    }

    // === IA ADAPTATIONS ===
    match /ai_adaptations/{adaptationId} {
      allow read: if request.auth != null
                  && resource.data.userId == request.auth.uid;
    }
  }
}
```
