import 'package:clean_tasks/Screens/Login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';


main(List<String> args) {
  runApp(MaterialApp(
    localizationsDelegates: [
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate
    ],
    supportedLocales: [
      const Locale("pt","BR"),
      //const Locale("en","US")
    ],
    home: LoginPage(),
    debugShowCheckedModeBanner: false,
  ));
}