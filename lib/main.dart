import 'package:flutter/material.dart';
import 'package:ig_clone/provider/auth_provider.dart';
import 'package:ig_clone/provider/main_provider.dart';
import 'package:ig_clone/provider/pageviewer_provider.dart';
import 'package:ig_clone/screens/main_screen.dart';
import 'package:ig_clone/screens/login_screen.dart';
import 'package:ig_clone/screens/messages_screen.dart';
import 'package:ig_clone/screens/profile_screen.dart';
import 'package:ig_clone/screens/splash_screen.dart';
import 'package:ig_clone/theme/app_theme.dart';
import 'package:provider/provider.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => PageviewProvider()),
        ChangeNotifierProvider(create: (context) => AuthProvider()),
        ChangeNotifierProvider(create: (context) => MainProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Instagram',
        initialRoute: 'splash',
        theme: AppTheme.theme,
        routes: {
          'home': (context) => const MainContainer(),
          'login': (context) => const LoginScreen(),
          'messages': (context) => const MessagesScreen(),
          'profile': (context) => const ProfileScreen(),
          'splash': (context) => const SplashScreen(),
        },
      ),
    );
  }
}
