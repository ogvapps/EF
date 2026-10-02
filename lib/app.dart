import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'router/app_router.dart';
import 'core/theme/app_theme.dart';
import 'core/services/pending_write_service.dart';
import 'core/services/connectivity_service.dart';
import 'l10n/app_localizations.dart';

class EFApp extends ConsumerWidget {
  EFApp({super.key});

  final _router = router;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final syncService = ref.read(syncServiceProvider);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      syncService.processPendingWrites();
    });

    ref.listen(connectivityStatusProvider, (_, next) {
      next.whenData((status) {
        if (status == ConnectivityStatus.online) {
          syncService.processPendingWrites();
        }
      });
    });

    return MaterialApp.router(
      title: 'EF Quest',
      debugShowCheckedModeBanner: false,
      routerConfig: _router,
      theme: AppTheme.darkTheme,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('es'),
        Locale('en'),
      ],
      locale: const Locale('es'),
    );
  }
}
