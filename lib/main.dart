import 'package:flutter/material.dart';
import 'package:pokedex_project/assets/colors/app-colors.dart';
import 'package:pokedex_project/components/text-style/pokemon-solid-style.dart';
import 'package:pokedex_project/components/text-style/pokemon-style.dart';
import 'package:pokedex_project/models/model-theme.dart';
import 'package:pokedex_project/models/mytheme_preference.dart';
import 'package:pokedex_project/pages/home/home.dart';
import 'package:provider/provider.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'components/theme-data/dark-theme-data.dart';
import 'components/theme-data/light-theme-data.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(const MyApp());
  FlutterNativeSplash.remove();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ModelTheme(),
      child: Consumer<ModelTheme>(
          builder: (context, ModelTheme themeNotifier, child) {
            return MaterialApp(
              title: 'Pokédex app',
              themeMode: themeNotifier.isSystem ? ThemeMode.system : themeNotifier.isDark ? ThemeMode.system : ThemeMode.light,
              darkTheme: DarkThemeData().themeData,
              theme: LightThemeData().themeData,
              debugShowCheckedModeBanner: false,
              home: const MyHomePage(title: 'Pokédex'),
            );
          }),
    );
  }
}
