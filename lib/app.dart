import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'core/theme/app_theme.dart';
import 'core/injection_container.dart' as di;
import 'core/bloc_providers.dart';
import 'core/navigation/navigation_service.dart';
import 'core/navigation/routers.dart';
import 'presentation/pages/home_page/home_page.dart';

class MyApp extends StatefulWidget {
  final AdaptiveThemeMode theme;

  const MyApp({
    required this.theme,
    super.key,
  });

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late AdaptiveThemeMode currentTheme;
  final botToastBuilder = BotToastInit();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MultiBlocProvider(
      providers: BlocProviders.toGenerateProviders(),
      child: AdaptiveTheme(
        light: AppTheme.light,
        dark: AppTheme.dark,
        initial: widget.theme,
        builder: (light, dark) {
          return Builder(
            builder: (context) {
              return MaterialApp(
                home: const HomePage(),
                theme: light,
                darkTheme: dark,
                navigatorKey: di.sl<NavigationService>().navigatorKey,
                onGenerateRoute: (settings) =>
                    Routers.toGenerateRoute(settings),
                debugShowCheckedModeBanner: false,
                localizationsDelegates: AppLocalizations.localizationsDelegates,
                supportedLocales: AppLocalizations.supportedLocales,
                builder: ((context, child) {
                  final MediaQueryData data = MediaQuery.of(context);
                  child = botToastBuilder(context, child);
                  return MediaQuery(
                    data: data.copyWith(
                      textScaler: const TextScaler.linear(1.0),
                    ),
                    child: child,
                  );
                }),
              );
            },
          );
        },
      ),
    );
  }
}
