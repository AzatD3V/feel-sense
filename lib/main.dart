import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xxx/logic/bloc/db_bloc.dart';
import 'package:xxx/screens/intro_screen.dart';
import 'package:xxx/services/auth_services.dart';
import 'package:xxx/logic/bloc/auth_bloc.dart';
import 'package:xxx/services/db_services.dart';
import 'package:xxx/widgets/nav_bar.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.black, statusBarColor: Colors.black));
  runApp(MyApp());
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
            navigatorKey: navigatorKey,
            debugShowCheckedModeBanner: false,
            home: NavBar() // IntroScreen()
            ));
  }
}
