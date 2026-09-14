import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:stitch_worker/l10n/generated/app_localizations.dart';
import 'package:provider/provider.dart';
import 'router.dart';
import 'theme/app_theme.dart';
import '../core/services/locale_service.dart';

/// Root MaterialApp.router that consumes the LocaleProvider.
/// When the locale changes, the entire widget tree rebuilds in the new language.
class StitchWorkerApp extends StatefulWidget {
  const StitchWorkerApp({super.key});

  @override
  State<StitchWorkerApp> createState() => _StitchWorkerAppState();
}

class _StitchWorkerAppState extends State<StitchWorkerApp> {
  late final _router = createRouter();

  @override
  Widget build(BuildContext context) {
    final localeProvider = context.watch<LocaleProvider>();

    return MaterialApp.router(
      title: 'WORK SOLUTE',
      onGenerateTitle: (context) => AppLocalizations.of(context).appTitle,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(context),
      scrollBehavior: const AppScrollBehavior(),
      locale: localeProvider.locale,
      supportedLocales: AppLocales.supported,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      routerConfig: _router,
    );
  }
}
