import 'package:flutter/material.dart';
import 'package:fyrm_frontend/providers/test_provider.dart';
import 'package:fyrm_frontend/routes.dart';
import 'package:fyrm_frontend/screens/splash/splash_screen.dart';
import 'package:fyrm_frontend/theme.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => TestProvider(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: theme(),
        initialRoute: SplashScreen.routeName,
        routes: routes,
      ),
    );
  }
}
