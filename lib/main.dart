import 'package:flutter/material.dart';
import 'theme/app_theme.dart';
import 'shell.dart';
import 'l10n/app_localizations.dart';

void main() {
  runApp(const TherapyShowcaseApp());
}

class TherapyShowcaseApp extends StatelessWidget {
  const TherapyShowcaseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      title: 'Intherapy',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme,
      home: const RootShell(),
    );
  }
}
