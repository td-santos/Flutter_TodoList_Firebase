import 'package:clean_tasks/Screens/Login.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:shared_preferences/shared_preferences.dart';

salvarShared(bool darkmode) async {    
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool("darkMode", darkmode);
    print("(SalvarPrefs): ");    
  }
  

main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
final prefs = await SharedPreferences.getInstance();

bool darkMode;
darkMode = prefs.getBool("darkMode");
if(darkMode == null){
  darkMode = false;
  salvarShared(darkMode);
}

print("DARKMODE: $darkMode");


/*WidgetsFlutterBinding.ensureInitialized();
ThemeData tema;
final prefs = await SharedPreferences.getInstance();

print("MAIN DARK MODE: ${prefs.getBool("darkMode")}");

if(prefs.getBool("darkMode") != true){
  tema = ThemeData.light();
}else{
  tema = ThemeData.dark();
}*/

  initializeDateFormatting().then((_) {
    runApp(MaterialApp(
      home: LoginPage(),
      debugShowCheckedModeBanner: false,
      //theme: tema,
    ));
  });
}
