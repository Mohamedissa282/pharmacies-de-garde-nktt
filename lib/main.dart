import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:fastdelivery/Authentification/SignUp.dart';
import 'package:fastdelivery/Authentification/login.dart';
import 'package:fastdelivery/Pharmacie/listPharmacy.dart';
import 'package:fastdelivery/generated/l10n.dart';
import 'package:fastdelivery/pages/Drawer/BD.dart';
import 'package:fastdelivery/pages/LanguageProvider.dart';
import 'package:fastdelivery/pages/homme.dart';
import 'package:fastdelivery/pages/maps.dart';
import 'package:fastdelivery/pages/page1.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:intl/intl.dart';
import 'package:fastdelivery/pages/page2.dart';
import 'package:fastdelivery/pages/test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Platform.isAndroid
      ? await Firebase.initializeApp(
          options: const FirebaseOptions(
              apiKey: 'AIzaSyD7lAGryKyg-CI9ErGbk5hawpNkxoHL94I',
              appId: '1:753481431963:android:2f01a2acc11b93a389bf3e',
              messagingSenderId: '753481431963',
              projectId: 'appflutter-5db73'),
        )
      : dotenv.load(fileName: ".env");
  await Firebase.initializeApp();
  runApp(
    ChangeNotifierProvider(
      create: (context) => languageProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  void initState() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print(
            '#########################################User is currently signed out!');
      } else {
        print(
            '###########################################################User is signed in!');
      }
    });
    super.initState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        "pharmacyList": (context) => listPharmacy(),
        "login": (context) => login(),
        "SignUp": (context) => SingnUp(),
      },
      locale: Provider.of<languageProvider>(context).local,
      localizationsDelegates: [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      home:
          FirebaseAuth.instance.currentUser == null ? homme() : listPharmacy(),
    );
  }
}

bool isArabic() {
  return Intl.getCurrentLocale() == "ar";
}
