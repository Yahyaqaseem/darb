import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:darb_mobile/core/theme/darb_theme.dart';
import 'package:darb_mobile/core/router/app_router.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const DarbApp());
}

class DarbApp extends StatelessWidget {
  const DarbApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'DARB دَرْب',
      theme: DarbTheme.lightTheme,
      darkTheme: DarbTheme.darkTheme,
      themeMode: ThemeMode.system,
      routerConfig: appRouter,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('ar'), // Arabic
        Locale('ku'), // Kurdish
        Locale('en'), // English
      ],
      locale: const Locale('ar'), // Default to Arabic RTL
    );
  }
}
