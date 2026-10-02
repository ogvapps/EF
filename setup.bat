@echo off
echo ========================================
echo  EF Quest - Script de Configuracion
echo ========================================
echo.

:: 1. Anadir Flutter al PATH (si no esta)
where flutter >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo [1/5] Anadiendo Flutter al PATH...
    setx PATH "%%PATH%%;C:\tools\flutter\bin"
) else (
    echo [1/5] Flutter ya esta en el PATH
)

:: 2. Verificar Flutter
echo [2/5] Verificando Flutter...
flutter --version >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo ERROR: Flutter no encontrado. Descargalo de https://docs.flutter.dev/get-started/install/windows
    pause
    exit /b 1
)
echo    OK

:: 3. Obtener dependencias
echo [3/5] Instalando dependencias...
cd /d "%~dp0"
flutter pub get
if %ERRORLEVEL% NEQ 0 (
    echo ERROR: flutter pub get fallo
    pause
    exit /b 1
)
echo    OK

:: 4. Verificar variables de entorno (.env)
echo [4/5] Verificando configuracion Supabase (.env)...
if exist .env (
    echo    .env encontrado
) else (
    echo    ATENCION: Falta el archivo .env
    echo    Copia .env.example a .env y anade tus credenciales de Supabase
)

:: 5. Resumen
echo [5/5] Resumen del entorno:
echo.
call flutter doctor
echo.
echo ========================================
echo  Para ejecutar en Chrome:
echo    flutter run -d chrome
echo.
echo  Para Android (necesitas Android Studio):
echo    flutter run
echo.
echo  Para Windows (experimental):
echo    flutter run -d windows
echo ========================================
pause
