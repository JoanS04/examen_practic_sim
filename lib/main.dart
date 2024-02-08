import 'package:examen_practic_sim/Preferences/preferences.dart';
import 'package:examen_practic_sim/Providers/db_users_provider.dart';
import 'package:examen_practic_sim/Providers/local_user_provider.dart';
import 'package:examen_practic_sim/Providers/ui_provider.dart';
import 'package:examen_practic_sim/Providers/users_providers.dart';
import 'package:examen_practic_sim/Screens/detail_screen.dart';
import 'package:examen_practic_sim/Screens/home_screen.dart';
import 'package:examen_practic_sim/Screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Preferences.init();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (_) => LocalUserProvider(Preferences.nomUsuari, Preferences.contrassenya)),
      ChangeNotifierProvider(create: (_) => UserService()),
      ChangeNotifierProvider(create: (_) => ScanListProvider()),
      ChangeNotifierProvider(create: (_) => UiProvider())
    ],
    child: MyApp()));
  }

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/home',
      routes: {
        // '/login': (_) => LoginScreen(),
        '/home': (_) => const HomeScreen(),
        'detail': (_) => DetailScreen(),
      },
    );
  }
}