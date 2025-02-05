import 'package:flutter/material.dart';
import 'package:mobile_pet_app/constants/color_class.dart';
import 'package:mobile_pet_app/provider/pet_provider.dart';
import 'package:provider/provider.dart';

import 'screens/splash_screen/splash_screen.dart';

void main() {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    runApp(const MyApp());
  } catch (e) {
    debugPrint('---- $e');
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PetDataProvider()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: AppColors.getLightTheme(),
        darkTheme: AppColors.getDarkTheme(),
        home: const SplashScreen(),
      ),
    );
  }
}
