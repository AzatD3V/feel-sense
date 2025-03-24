import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xxx/core/config/theme.dart';
import 'package:xxx/logic/blocs/db/db_bloc.dart';
import 'package:xxx/presentation/screens/intro_screen.dart';
import 'package:xxx/presentation/screens/new_screen.dart';
import 'package:xxx/data/repositories/auth_services.dart';
import 'package:xxx/logic/blocs/auth/auth_bloc.dart';
import 'package:xxx/data/repositories/db_services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp();

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.black, statusBarColor: Colors.black));
  runApp(EasyLocalization(supportedLocales: [
    Locale("en", "US"),
    Locale("tr", "TR"),
  ], path: "assets/lang", fallbackLocale: Locale("en", "US"), child: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => AuthBloc(authServices: AuthServices())),
        BlocProvider(create: (context) => DBBlock(DBServices())),
      ],
      child: MaterialApp(
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        home:
            // NewScreen()
            IntroScreen(),
        theme: AppTheme.light,
      ),
    );
  }
}
