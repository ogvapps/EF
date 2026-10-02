import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'core/theme/app_theme.dart';
import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');

  FlutterError.onError = (details) {
    FlutterError.dumpErrorToConsole(details);
  };

  ErrorWidget.builder = (details) {
    return Material(
      color: AppTheme.deepNavy,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.error_outline, color: Colors.red, size: 48),
              const SizedBox(height: 16),
              const Text(
                'Algo sali\u00f3 mal',
                style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              Text(
                details.exception.toString(),
                style: const TextStyle(color: Colors.white54, fontSize: 12),
                textAlign: TextAlign.center,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  };

  try {
    final sbUrl = dotenv.env['SUPABASE_URL'];
    final sbKey = dotenv.env['SUPABASE_PUBLISHABLE_KEY'];
    if (sbUrl != null && sbKey != null) {
      await Supabase.initialize(
        url: sbUrl,
        publishableKey: sbKey,
        authOptions: const FlutterAuthClientOptions(
          authFlowType: kIsWeb ? AuthFlowType.implicit : AuthFlowType.pkce,
        ),
      );
    }
  } catch (e) {
    debugPrint('Supabase init error: $e');
  }

  if (!kIsWeb) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
  }

  runApp(
    ProviderScope(
      child: EFApp(),
    ),
  );
}
