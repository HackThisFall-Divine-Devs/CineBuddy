import 'package:cine_buddy/src/features/authentication/bloc/authentication_bloc.dart';
import 'package:cine_buddy/src/features/groups/bloc/group_bloc.dart';
import 'package:cine_buddy/src/features/home/bloc/carousel_bloc.dart';
import 'package:cine_buddy/src/features/home/bloc/movie_categories_bloc.dart';
import 'package:cine_buddy/src/features/home_outline/home_outline.dart';
import 'package:cine_buddy/src/features/splash_screen/splash_screen.dart';
import 'package:cine_buddy/src/theme/app_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'src/utils/firebase_options.dart';

late SharedPreferences prefs;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  prefs = await SharedPreferences.getInstance();
  await prefs.clear();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthenticationBloc()),
        BlocProvider(create: (context) => CarouselBloc()),
        BlocProvider(create: (context) => MovieCategoriesBloc()),
        BlocProvider(create: (context) => GroupBloc()),
      ],
      child: MaterialApp(
        title: "Cine Buddy",
        debugShowCheckedModeBanner: false,
        theme: AppTheme.theme,
        home: const SplashScreen(),
      ),
    );
  }

  Future<String?> getAuthToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('authToken');
  }

  Future<void> storeAuthToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('authToken', token);
  }

  Future<String?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('userId');
  }

  Future<void> storeUserId(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userId', token);
  }
}
