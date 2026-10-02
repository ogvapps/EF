# Seed Firestore — EF App

## Requisitos

```bash
# Instalar Firebase Admin SDK para Dart
dart pub global activate firebase_admin

# O añadir al proyecto
dart pub add firebase_admin yaml
```

## Configuración

1. Ir a **Firebase Console** → Configuración del proyecto → Cuentas de servicio
2. Generar nueva clave privada → descargar `service-account.json`
3. Colocar `service-account.json` en la raíz del proyecto

## Ejecutar

```bash
# Seed normal (inserta sin borrar)
dart run scripts/seed_firestore.dart

# Seed con limpieza previa (borra units, achievements, shop_items)
dart run scripts/seed_firestore.dart --clean

# Con ruta personalizada de credenciales
dart run scripts/seed_firestore.dart /ruta/a/service-account.json
```

## Qué inserta

| Colección | Registros |
|-----------|-----------|
| `units` | 36 unidades didácticas |
| `units/{id}/lessons` | 100+ lecciones |
| `units/{id}/challenges` | 70+ retos físicos |
| `units/{id}/minigames` | 20+ minijuegos |
| `units/{id}/boss` | 36 jefes finales |
| `achievements` | 12 logros |
| `shop_items` | 12 artículos de tienda |

## Notas

- No borra `users`, `classes` ni `user_progress`
- Los timestamps se generan con la fecha actual
- Los IDs siguen el patrón `{curso}_ud{num}`, `{udId}_l{num}`, etc.
